IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]'))
DROP VIEW [dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]
GO

CREATE VIEW [dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]
AS

SELECT TOP (100) PERCENT
	lfi.LineFolderID, ssy.SeasonYearID
	, 'StyleSeasonYearID|' + CAST(lfi.StyleSeasonYearID AS nVARCHAR(50)) + ',StyleID|' + CAST(lfi.StyleID AS nVARCHAR(50)) AS AddIDs
	, sc.StyleCategory AS StyleCategoryName, st.StyleTypeDescription
	, CASE WHEN lfi.LineFolderItemDrop = 'No' THEN 'Yes' ELSE 'No' END AS LineFolderItemDrop
	, sch.StyleCostingHeaderID, sch.StyleCostingCustomField6, sch.StyleCostingCustomField1, sch.StyleCostingCustomField9, sch.StyleCostingCustomField7, sch.StyleCostingCustomField2
	, sch.StyleCostingCustomField12, sch.StyleCostingCustomField21, sch.StyleCostingCustomField22, sch.StyleCostingCustomField10
	, sh.*
FROM pLineFolderItem lfi
	INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN pStyleWorkflow sw ON lfi.StyleID = sw.StyleID AND lfi.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = '10000000-0000-0000-0000-000000000010'
	LEFT JOIN pStyleCostingHeader sch ON sh.StyleID = sch.StyleID AND lfi.StyleSeasonYearID = sch.StyleSeasonYearID
ORDER BY sh.StyleNo

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07507', GetDate())
GO