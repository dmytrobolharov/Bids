IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_MissingColors_DROP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_MissingColors_DROP]
GO

CREATE PROCEDURE [dbo].[spx_Planning_MissingColors_DROP]
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @ColorPaletteID UNIQUEIDENTIFIER

AS
BEGIN

	UPDATE sbdi SET
	sbdi.ItemDim1Active = CASE WHEN cp.ColorPaletteID = ItemDim1Id THEN 0 ELSE sbdi.ItemDim1Active END, 
	sbdi.ItemDim2Active = CASE WHEN cp.ColorPaletteID = ItemDim2Id THEN 0 ELSE sbdi.ItemDim2Active END, 
	sbdi.ItemDim3Active = CASE WHEN cp.ColorPaletteID = ItemDim3Id THEN 0 ELSE sbdi.ItemDim3Active END
	FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND ssy.SeasonYearID = @SeasonYearID
			AND pli.PlanningID = @PlanningID
		INNER JOIN pStyleBOMDimensionItem sbdi
			INNER JOIN pColorPalette cp ON (sbdi.ItemDim1Id = cp.ColorPaletteID OR sbdi.ItemDim2Id = cp.ColorPaletteID OR sbdi.ItemDim3Id = cp.ColorPaletteID)
											AND cp.ColorPaletteID = @ColorPaletteID
		ON pli.StyleBOMDimensionId = sbdi.StyleBOMDimensionID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06710', GetDate())
GO
