IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKU_Mismatching_Statuses_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKU_Mismatching_Statuses_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKU_Mismatching_Statuses_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @PlanningSKUHeaderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		pli.PlanningItemID
	FROM
		pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
		INNER JOIN pPlanningSKUHeader psh ON pli.PlanningID = psh.PlanningID
		INNER JOIN pWorkFlowItem wfi ON pli.StyleSeasonYearID = wfi.StyleSeasonYearID
		INNER JOIN pStyleSKUItem ssh ON wfi.WorkFlowItemID = ssh.WorkflowItemID AND psh.PlanningSKUHeaderID = ssh.PlanningSKUHeaderID
	WHERE
		pli.PlanningItemDrop = 'No'
		AND pli.PlanningID = @PlanningID
		AND psh.PlanningSKUHeaderID = @PlanningSKUHeaderID
		AND wfi.WorkStatus != psh.WorkStatus
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08292', GetDate())
GO
