IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineListFlashEdit_StyleHeader_SELECT]'))
DROP VIEW [dbo].[vwx_LineListFlashEdit_StyleHeader_SELECT]
GO

CREATE VIEW [dbo].[vwx_LineListFlashEdit_StyleHeader_SELECT]
AS

SELECT lfi.LineFolderID, ssy.SeasonYearID, sc.StyleCategory AS StyleCategoryName, st.StyleTypeDescription, sy.SeasonYear, d.Custom AS Division, lfi.LineFolderItemSort, lfi.LineFolderItemDrop, lfi.LineFolderItemDropDate, lfi.LineFolderItemDropUser, 'LineFolderID|' + CAST(lfi.LineFolderID AS nVARCHAR(50)) AS AddIDs, sh.*
FROM pLineFolderItem lfi
	INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
	LEFT OUTER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	LEFT OUTER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT OUTER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	LEFT OUTER JOIN vwx_SeasonYear_SEL sy ON sh.IntroSeasonYearID = sy.SeasonYearID
	LEFT JOIN iCustom1 d ON sh.DivisionID = d.CustomID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08448', GetDate())
GO