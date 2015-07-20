IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineListFlashEdit_StyleHeader_SELECT]'))
DROP VIEW [dbo].[vwx_LineListFlashEdit_StyleHeader_SELECT]
GO

CREATE VIEW [dbo].[vwx_LineListFlashEdit_StyleHeader_SELECT]
AS

SELECT TOP (100) PERCENT lfi.LineFolderID, ssy.SeasonYearID, sc.StyleCategory AS StyleCategoryName, st.StyleTypeDescription, sy.SeasonYear, d.Custom AS Division, NULL AS AddIDs, sh.*
FROM pLineFolderItem lfi
	INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN vwx_SeasonYear_SEL sy ON sh.IntroSeasonYearID = sy.SeasonYearID
	LEFT JOIN iCustom1 d ON sh.DivisionID = d.CustomID
ORDER BY sh.StyleNo	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07379', GetDate())
GO
