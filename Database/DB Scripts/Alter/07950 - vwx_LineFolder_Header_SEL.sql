/****** Object:  View [dbo].[vwx_LineFolder_Header_SEL]    Script Date: 06/06/2014 13:39:52 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolder_Header_SEL]'))
DROP VIEW [dbo].[vwx_LineFolder_Header_SEL]
GO

/****** Object:  View [dbo].[vwx_LineFolder_Header_SEL]    Script Date: 06/06/2014 13:39:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vwx_LineFolder_Header_SEL]
AS
SELECT pLineFolder.LineFolderID
      ,pLineFolder.LineFolderNo
      ,pLineFolder.LineFolderDescription
      ,pLineFolder.LineSubFolder1
      ,pLineFolder.LineSubFolder2
      ,pLineFolder.LineSubFolder3
      ,pLineFolder.LineSubFolder4
      ,pLineFolder.LineSubFolder5
      ,CASE WHEN ISDATE(LineSubFolder6) = 1 THEN CAST(LineSubFolder6 AS DATETIME) ELSE NULL END AS LineSubFolder6
      ,CASE WHEN ISDATE(LineSubFolder6) = 1 THEN CAST(LineSubFolder6 AS DATETIME) ELSE NULL END AS DueDate
      ,pLineFolder.LineSubFolder7
      ,pLineFolder.LineSubFolder8
      ,pLineFolder.LineSubFolder9
      ,pLineFolder.CUser
      ,pLineFolder.CDate
      ,pLineFolder.MUser
      ,pLineFolder.MDate
      ,pLineFolder.MChange
      ,pLineFolder.LineFolderActive
      ,pLineFolder.LineFolderTypeID
      ,pLineFolder.SeasonYearID
      ,pLineFolder.LineFolderSortBy
      ,pLineFolder.FlashCostFixedMarkup
      ,pLineFolder.LineListTypeID
      ,pLineFolder.LineFolderDivisionID
      ,ic1.Custom as LineFolderDivision
      ,pLineFolder.Active
      ,pLineFolder.PlanningID, 
	STUFF ((SELECT ', ' + pStyleType.StyleTypeDescription
			FROM pLineFolderStyleType 
			LEFT JOIN pStyleType ON pLineFolderStyleType.StyleTypeID = pStyleType.StyleTypeID
			WHERE pLineFolderStyleType.LineFolderID = pLineFolder.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS StyleType, 
	STUFF ((SELECT ', ' + CAST(pLineFolderStyleType.StyleTypeID AS nvarchar(50)) 
	        FROM pLineFolderStyleType 
			WHERE pLineFolderStyleType.LineFolderID = pLineFolder.LineFolderID 
			ORDER BY pLineFolderStyleType.StyleTypeID
			FOR XML PATH('')), 1, 2, '') AS StyleTypeID, 
	STUFF ((SELECT ', ' + pStyleCategory.StyleCategory
			FROM pLineFolderStyleCategory 
			LEFT JOIN pStyleCategory ON pStyleCategory.StyleCategoryId = pLineFolderStyleCategory.StyleCategoryID
			WHERE pLineFolderStyleCategory.LineFolderID = pLineFolder.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS StyleCategory, 
	STUFF ((SELECT ', ' + CAST(pLineFolderStyleCategory.StyleCategoryID AS nvarchar(50))
			FROM pLineFolderStyleCategory 
			WHERE pLineFolderStyleCategory.LineFolderID = pLineFolder.LineFolderID 
			ORDER BY pLineFolderStyleCategory.StyleCategoryID
			FOR XML PATH('')), 1, 2, '') AS StyleCategoryID,
	STUFF ((SELECT ', ' + pCalendarHeader.CalendarName
			FROM pCalendarLineFolder 
			INNER JOIN pCalendarHeader ON pCalendarLineFolder.CalendarHeaderID = pCalendarHeader.CalendarHeaderID
			WHERE pCalendarLineFolder.LineFolderID = pLineFolder.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS Calendar, 
	(SELECT CASE WHEN COUNT(lfi.LineFolderID)+COUNT(clf.LineFolderID)+COUNT(lfh.LineFolderID) > 0 THEN 1 ELSE 0 END
	FROM pLineFolder lf
		LEFT JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID
		LEFT JOIN pCalendarLineFolder clf ON lf.LineFolderID = clf.LineFolderID
		LEFT JOIN pLineFolderHistorical lfh ON lf.LineFolderID = lfh.LineFolderID
		WHERE lf.LineFolderID = plinefolder.LineFolderID) AS IsUsed
FROM pLineFolder
INNER JOIN iCustom1 ic1 ON ic1.CustomID = pLineFolder.LineFolderDivisionID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07950', GetDate())
GO