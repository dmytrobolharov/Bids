IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKU_Missing_Paired_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKU_Missing_Paired_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKU_Missing_Paired_SELECT]
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
		LEFT JOIN pStyleWorkflow sw ON pli.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = '40000000-0000-0000-0000-000000000090'
		LEFT JOIN pWorkFlowItem wfi
			INNER JOIN pStyleSKUItem ssi ON wfi.WorkFlowItemID = ssi.WorkflowItemID AND (ssi.PlanningSKUHeaderID = @PlanningSKUHeaderID OR ssi.PlanningSKUHeaderID IS NULL)
		ON pli.StyleSeasonYearID = wfi.StyleSeasonYearID AND sw.WorkflowID = wfi.WorkflowID
	WHERE
		pli.PlanningID = @PlanningID
		AND pli.PlanningItemDrop = 'No'
	GROUP BY pli.PlanningItemID
	HAVING SUM(CASE WHEN ssi.PlanningSKUHeaderID IS NOT NULL THEN 1 ELSE 0 END) = 0
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08367', GetDate())
GO
