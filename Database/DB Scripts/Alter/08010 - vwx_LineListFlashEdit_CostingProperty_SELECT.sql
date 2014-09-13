/****** Object:  View [dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]    Script Date: 06/16/2014 12:45:51 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]'))
DROP VIEW [dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]
GO

/****** Object:  View [dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]    Script Date: 06/16/2014 12:45:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[vwx_LineListFlashEdit_CostingProperty_SELECT]
AS

SELECT
	'<img src=''' +
	  (SELECT TOP (1) AppSettingValue FROM dbo.sAppSetting WHERE (AppSettingKey = 'ImageServer')) + 
		'/ImageStream.ashx?S=50&IID=' + CAST(ISNULL(sh.DesignSketchID, N'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + 
		'&V=' + CAST(ISNULL(sh.DesignSketchVersion, N'0') AS NVARCHAR(5)) + '''  />' AS [Image]
	, lfi.LineFolderID, ssy.SeasonYearID
	, 'StyleSeasonYearID|' + CAST(lfi.StyleSeasonYearID AS nVARCHAR(50)) + ',StyleID|' + CAST(lfi.StyleID AS nVARCHAR(50)) AS AddIDs
	, sc.StyleCategory AS StyleCategoryName, st.StyleTypeDescription
	, lfi.LineFolderItemDrop, lfi.LineFolderItemSort
	, sch.StyleCostingHeaderID, sch.StyleCostingCustomField6, sch.StyleCostingCustomField1, sch.StyleCostingCustomField9, sch.StyleCostingCustomField7, sch.StyleCostingCustomField2
	, sch.StyleCostingCustomField12, sch.StyleCostingCustomField21, sch.StyleCostingCustomField22, sch.StyleCostingCustomField10
	, sch.StyleCostingCustomField5, sch.StyleCostingCustomField3, sch.StyleCostingCustomField14, sch.StyleCostingCustomField15 
	, sch.StyleCostingCustomField8, sch.StyleCostingCustomField18, sch.StyleCostingCustomField20, sch.StyleCostingCustomField13
	, sh.*
FROM pLineFolderItem lfi
	INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN pStyleWorkflow sw ON lfi.StyleID = sw.StyleID AND lfi.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = '10000000-0000-0000-0000-000000000010'
	LEFT JOIN pStyleCostingHeader sch ON sh.StyleID = sch.StyleID AND lfi.StyleSeasonYearID = sch.StyleSeasonYearID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08010', GetDate())
GO
