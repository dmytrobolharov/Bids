IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]'))
DROP VIEW [dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]
GO

CREATE VIEW [dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]
AS

SELECT
	pli.PlanningID, ssy.SeasonYearID
	, 'StyleSeasonYearID|' + CAST(pli.StyleSeasonYearID AS nVARCHAR(50)) + ',StyleID|' + CAST(pli.StyleID AS nVARCHAR(50)) AS AddIDs
	, sc.StyleCategory AS StyleCategoryName, st.StyleTypeDescription
	, CASE WHEN pli.PlanningItemDrop = 'No' THEN 'Yes' ELSE 'No' END AS PlanningItemDrop
	, sch.StyleCostingHeaderID, sch.StyleCostingCustomField6, sch.StyleCostingCustomField1, sch.StyleCostingCustomField9, sch.StyleCostingCustomField7, sch.StyleCostingCustomField2
	, sch.StyleCostingCustomField12, sch.StyleCostingCustomField21, sch.StyleCostingCustomField22, sch.StyleCostingCustomField10
	, sh.*
	, pli.PlanningItemSort
FROM pPlanningItem pli
	INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN pStyleWorkflow sw ON pli.StyleID = sw.StyleID AND pli.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = '10000000-0000-0000-0000-000000000010'
	LEFT JOIN pStyleCostingHeader sch ON sh.StyleID = sch.StyleID AND pli.StyleSeasonYearID = sch.StyleSeasonYearID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07569', GetDate())
GO