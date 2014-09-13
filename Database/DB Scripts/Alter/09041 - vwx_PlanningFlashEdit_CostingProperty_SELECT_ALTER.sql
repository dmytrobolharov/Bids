
/****** Object:  View [dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]    Script Date: 9/2/2014 4:32:09 PM ******/
DROP VIEW [dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]
GO

/****** Object:  View [dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]    Script Date: 9/2/2014 4:32:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[vwx_PlanningFlashEdit_CostingProperty_SELECT]
AS

SELECT
	'<img src=''' +
	  (SELECT TOP (1) AppSettingValue FROM dbo.sAppSetting WHERE (AppSettingKey = 'ImageServer')) + 
		'/ImageStream.ashx?S=50&IID=' + CAST(ISNULL(sh.DesignSketchID, N'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + 
		'&V=' + CAST(ISNULL(sh.DesignSketchVersion, N'0') AS NVARCHAR(5)) + '''  />' AS [Image]
	, pli.PlanningID, ssy.SeasonYearID
	, 'StyleSeasonYearID|' + CAST(pli.StyleSeasonYearID AS nVARCHAR(50)) + ',StyleID|' + CAST(pli.StyleID AS nVARCHAR(50)) AS AddIDs
	, sc.StyleCategory AS StyleCategoryName, st.StyleTypeDescription, sbc.Custom AS SubCategoryName, d.Custom AS DivisionName
	, pli.PlanningItemDrop
	, sch.StyleCostingHeaderID, sch.StyleCostingCustomField6, sch.StyleCostingCustomField1, sch.StyleCostingCustomField9, sch.StyleCostingCustomField7, sch.StyleCostingCustomField2
	, sch.StyleCostingCustomField12, sch.StyleCostingCustomField21, sch.StyleCostingCustomField22, sch.StyleCostingCustomField10
	, sch.StyleCostingCustomField5, sch.StyleCostingCustomField3, sch.StyleCostingCustomField14, sch.StyleCostingCustomField15 
	, sch.StyleCostingCustomField8, sch.StyleCostingCustomField18, sch.StyleCostingCustomField20, sch.StyleCostingCustomField13
	, sh.*
	, pli.PlanningItemSort
FROM pPlanningItem pli
	INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN iCustom1 d ON sh.DivisionID = d.CustomID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN pStyleWorkflow sw ON pli.StyleID = sw.StyleID AND pli.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = '10000000-0000-0000-0000-000000000010'
	LEFT JOIN pStyleCostingHeader sch ON sh.StyleID = sch.StyleID AND pli.StyleSeasonYearID = sch.StyleSeasonYearID
	LEFT JOIN pSubCategory sbc ON sh.SubCategoryId = CAST(sbc.CustomID AS nVARCHAR(40))

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09041', GetDate())
GO
