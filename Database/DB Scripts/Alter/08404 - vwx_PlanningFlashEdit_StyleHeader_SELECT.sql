IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningFlashEdit_StyleHeader_SELECT]'))
DROP VIEW [dbo].[vwx_PlanningFlashEdit_StyleHeader_SELECT]
GO

CREATE VIEW [dbo].[vwx_PlanningFlashEdit_StyleHeader_SELECT]
AS
SELECT TOP (100) PERCENT pli.PlanningID, ssy.SeasonYearID, sc.StyleCategory AS StyleCategoryName, 
	st.StyleTypeDescription, sy.SeasonYear, d.Custom AS Division, pli.PlanningItemDrop, pli.PlanningItemDropDate, pli.PlanningItemDropUser,
	'PlanningID|' + CAST(pli.PlanningID AS nVARCHAR(50)) AS AddIDs, sh.*,
	pli.PlanningItemSort
FROM pPlanningItem pli
	INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN vwx_SeasonYear_SEL sy ON sh.IntroSeasonYearID = sy.SeasonYearID
	INNER JOIN iCustom1 d ON sh.DivisionID = d.CustomID	



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08404', GetDate())
GO