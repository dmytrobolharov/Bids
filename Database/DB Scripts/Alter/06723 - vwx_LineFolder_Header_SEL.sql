IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolder_Header_SEL]'))
DROP VIEW [dbo].[vwx_LineFolder_Header_SEL]
GO

CREATE VIEW [dbo].[vwx_LineFolder_Header_SEL]
AS
SELECT pLineFolder.*, 
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

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06723', GetDate())
GO
