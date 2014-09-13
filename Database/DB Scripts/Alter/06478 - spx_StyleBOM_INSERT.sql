IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_INSERT]
(
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier,
@ItemDim1 uniqueidentifier,
@ItemDim1Name nvarchar(50),
@ItemDim2 uniqueidentifier,
@ItemDim2Name nvarchar(50),
@ItemDim3 uniqueidentifier,
@ItemDim3Name nvarchar(50),
@MUser nvarchar(200),
@MDate datetime
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

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06478', GetDate())
GO
