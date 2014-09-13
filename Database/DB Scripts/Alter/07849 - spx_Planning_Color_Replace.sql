IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Color_Replace]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Color_Replace]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Color_Replace]
(
	@PlanningItemID UNIQUEIDENTIFIER
	, @ColorPaletteID UNIQUEIDENTIFIER
	, @PlanningColorID UNIQUEIDENTIFIER
)
AS

BEGIN

	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @DimID UNIQUEIDENTIFIER
	DECLARE @NewDimID UNIQUEIDENTIFIER
	DECLARE @DimLevel INT

	SELECT
		@StyleBOMDimensionID = pli.StyleBOMDimensionID
		, @DimID = sc.StyleColorID
		, @DimLevel = CASE
			WHEN ItemDim1Id IS NOT NULL THEN 1
			WHEN ItemDim2Id IS NOT NULL THEN 2
			WHEN ItemDim3Id IS NOT NULL THEN 3
		  END
	FROM pPlanningItem pli
		INNER JOIN pStyleBOMDimensionItem sbdi ON pli.StyleBOMDimensionID = sbdi.StyleBOMDimensionID
		INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
			AND sc.ColorPaletteID = @ColorPaletteID
	WHERE PlanningItemID = @PlanningItemID

	SELECT @NewDimID = ColorPaletteID FROM pPlanningColor WHERE PlanningColorID = @PlanningColorID

	EXEC spx_StyleBOMDimItem_REPLACE @StyleBOMDimensionID, @DimLevel, @DimID, @NewDimID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07849', GetDate())
GO