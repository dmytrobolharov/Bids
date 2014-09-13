IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_DevelopmentTracker_MissingBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_DevelopmentTracker_MissingBOM_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_DevelopmentTracker_MissingBOM_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT DISTINCT pli.PlanningItemID
	FROM vwx_PlanningItem_SELECT pli
	LEFT JOIN pStyleBOMDimension sbd
		INNER JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
		ON pli.StyleBOMDimensionID = sbd.StyleBOMDimensionID 
		AND pli.StyleSeasonYearID = wfi.StyleSeasonYearID
	WHERE
		pli.TeamId = @TeamID
		AND pli.PlanningID = @PlanningID
		AND pli.SeasonYearID = @SeasonYearID
		AND pli.PlanningItemDrop = 'No'
		AND (sbd.StyleBOMDimensionID IS NULL OR sbd.StyleBOMDimensionID = '00000000-0000-0000-0000-000000000000')
	

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '08455', GetDate())
GO
