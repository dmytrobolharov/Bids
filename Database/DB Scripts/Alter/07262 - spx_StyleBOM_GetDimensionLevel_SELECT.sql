/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_GetDimensionLevel_SELECT]    Script Date: 03/18/2014 13:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_GetDimensionLevel_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_GetDimensionLevel_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_GetDimensionLevel_SELECT]    Script Date: 03/18/2014 13:26:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOM_GetDimensionLevel_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@DimensionTypeName NVARCHAR(200),
	@DimLevel INT = 0 OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DimensionTypeID UNIQUEIDENTIFIER
	DECLARE @StyleBOMDimensionType UNIQUEIDENTIFIER
	
    SELECT @DimensionTypeID = DimTypeID
	FROM pStyleBOMDimType WHERE UPPER(RTRIM(LTRIM(DimTypeName)))=RTRIM(LTRIM(@DimensionTypeName))
	
	SELECT @StyleBOMDimensionType = ItemDim1TypeId FROM pStyleBOMDimensionItem
	WHERE StyleBOMDimensionID = @StyleBOMDimensionId
	IF @StyleBOMDimensionType = @DimensionTypeID -- Color
	BEGIN
		SET @DimLevel = 1
	END
	ELSE
	BEGIN
		SELECT @StyleBOMDimensionType = ItemDim2TypeId FROM pStyleBOMDimensionItem
		WHERE StyleBOMDimensionID = @StyleBOMDimensionId
		IF @StyleBOMDimensionType = @DimensionTypeID
		BEGIN
			SET @DimLevel = 2
		END
		ELSE
		BEGIN
			SELECT @StyleBOMDimensionType = ItemDim3TypeId FROM pStyleBOMDimensionItem
			WHERE StyleBOMDimensionID = @StyleBOMDimensionId
			IF @StyleBOMDimensionType = @DimensionTypeID
			BEGIN
				SET @DimLevel = 3
			END
		END
	END
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07262', GetDate())
GO
