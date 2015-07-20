IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_INSERT]
(
	@StyleID UNIQUEIDENTIFIER
	, @Styleset INT
	, @WorkFlowID UNIQUEIDENTIFIER
	, @WorkFlowItemID UNIQUEIDENTIFIER
	, @ItemDim1 UNIQUEIDENTIFIER
	, @ItemDim1Name NVARCHAR(50)
	, @ItemDim2 UNIQUEIDENTIFIER
	, @ItemDim2Name NVARCHAR(50)
	, @ItemDim3 UNIQUEIDENTIFIER
	, @ItemDim3Name NVARCHAR(50)
	, @MUser NVARCHAR(200)
	, @MDate DATETIME
)
AS
BEGIN
	
	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER = NEWID()

	INSERT INTO pStyleBOMDimension 
		(StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, styleset, ItemDim1TypeId, ItemDim1TypeName, ItemDim2TypeId, ItemDim2TypeName, ItemDim3TypeId, 
		ItemDim3TypeName, CUser , CDate, MUser, MDate) 
	VALUES 
		(@StyleBOMDimensionID, @WorkFlowID, @WorkFlowItemID, @StyleID, @Styleset, @ItemDim1, @ItemDim1Name, @ItemDim2, @ItemDim2Name, @ItemDim3, 
		@ItemDim3Name, @MUser , @MDate, @MUser, @MDate)
		

	INSERT INTO pStyleBOMConfig (StyleBOMDimensionID, DimBOM, DefaultBOMPage, FillColorway, ActiveColor, DimensionOptions)
	SELECT @StyleBOMDimensionID, ISNULL(DimBOM,1), ISNULL(DefaultBOMPage,1), ISNULL(FillColorway,1), ISNULL(ActiveColor,1), ISNULL(DimensionOptions,1)
	FROM pControlBOMConfig config
		INNER JOIN pStyleHeader sh ON config.DivisionID = sh.DivisionID AND config.StyleTypeID = sh.StyleType AND config.StyleCategoryID = sh.StyleCategory
	WHERE sh.StyleID = @StyleID
	
	IF NOT EXISTS (SELECT * FROM pStyleBOMConfig WHERE StyleBOMDimensionID = @StyleBOMDimensionID)
	BEGIN
		INSERT INTO pStyleBOMConfig (StyleBOMDimensionID, DimBOM, DefaultBOMPage, FillColorway, ActiveColor, DimensionOptions)
		SELECT @StyleBOMDimensionID, 1, 1, 1, 1, 1
	END
	
	-- Auto Set Size BEGIN
	
	DECLARE @AutoSetSize BIT
	DECLARE @IsSize INT
	DECLARE @SizeRangeID UNIQUEIDENTIFIER
	DECLARE @DimTypeID UNIQUEIDENTIFIER
	DECLARE @DimLevel INT
	
	SELECT @AutoSetSize = AutoSetSize
	FROM pControlBOMConfig cbc
		INNER JOIN pStyleHeader sh ON cbc.DivisionID = sh.DivisionID
			AND cbc.StyleTypeID = sh.StyleType
			AND cbc.StyleCategoryID = sh.StyleCategory
	WHERE sh.StyleID = @StyleID
	
	SELECT @DimTypeID = v.DimTypeID
		, @DimLevel = v.DimLevel
		, @IsSize = COUNT(*)
	FROM pStyleBOMDimType sbt
		CROSS APPLY (
			VALUES (@ItemDim1, @ItemDim1Name, 1),
				   (@ItemDim2, @ItemDim2Name, 2),
				   (@ItemDim3, @ItemDim3Name, 3)
		) V (DimTypeID, DimTypeName, DimLevel)
	WHERE LOWER(sbt.DimTypeName) = 'size'
		AND sbt.DimTypeID = V.DimTypeID
	GROUP BY v.DimTypeID, v.DimLevel
	
	SELECT @SizeRangeID = SizeRangeId FROM pStyleHeader sh WHERE sh.StyleID = @StyleID
	
	IF (@AutoSetSize * @IsSize) != 0 AND @SizeRangeID IS NOT NULL
		EXEC spx_StyleBOMSizeRange_Update
			'00000000-0000-0000-0000-000000000000'
			, @DimTypeID
			, @SizeRangeID
			, @StyleBOMDimensionID
			, @StyleID
			, @Styleset
			, @WorkFlowID
			, @WorkFlowItemID
			, @DimLevel
	-- Auto Set Size END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09938', GetDate())
GO
