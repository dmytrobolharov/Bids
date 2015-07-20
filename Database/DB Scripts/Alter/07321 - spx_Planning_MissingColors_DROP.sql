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
	sbdi.ItemDim1Active = CASE WHEN sc.StyleColorID = ItemDim1Id THEN 0 ELSE sbdi.ItemDim1Active END, 
	sbdi.ItemDim2Active = CASE WHEN sc.StyleColorID = ItemDim2Id THEN 0 ELSE sbdi.ItemDim2Active END, 
	sbdi.ItemDim3Active = CASE WHEN sc.StyleColorID = ItemDim3Id THEN 0 ELSE sbdi.ItemDim3Active END
	FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND ssy.SeasonYearID = @SeasonYearID
			AND pli.PlanningID = @PlanningID
		INNER JOIN pStyleBOMDimensionItem sbdi ON pli.StyleBOMDimensionId = sbdi.StyleBOMDimensionID
		INNER JOIN pStyleColorway sc ON (sbdi.ItemDim1Id = sc.StyleColorID OR sbdi.ItemDim2Id = sc.StyleColorID OR sbdi.ItemDim3Id = sc.StyleColorID)
											AND sc.ColorPaletteID = @ColorPaletteID
		

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07321', GetDate())
GO
