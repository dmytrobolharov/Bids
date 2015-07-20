IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_LineFolder_Header_SEL]'))
DROP VIEW [dbo].[vwx_Style_LineFolder_Header_SEL]
GO

CREATE VIEW [dbo].[vwx_Style_LineFolder_Header_SEL]
AS
SELECT lf.*, 
	STUFF ((SELECT ', ' + pStyleType.StyleTypeDescription
			FROM pLineFolderStyleType 
			LEFT JOIN pStyleType ON pLineFolderStyleType.StyleTypeID = pStyleType.StyleTypeID
			WHERE pLineFolderStyleType.LineFolderID = lf.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS StyleType
	, STUFF ((SELECT ', ' + CAST(pLineFolderStyleType.StyleTypeID AS nvarchar(50)) 
	        FROM pLineFolderStyleType 
			WHERE pLineFolderStyleType.LineFolderID = lf.LineFolderID 
			ORDER BY pLineFolderStyleType.StyleTypeID
			FOR XML PATH('')), 1, 2, '') AS StyleTypeID
	, STUFF ((SELECT ', ' + pStyleCategory.StyleCategory
			FROM pLineFolderStyleCategory 
			LEFT JOIN pStyleCategory ON pStyleCategory.StyleCategoryId = pLineFolderStyleCategory.StyleCategoryID
			WHERE pLineFolderStyleCategory.LineFolderID = lf.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS StyleCategory
	, STUFF ((SELECT ', ' + CAST(pLineFolderStyleCategory.StyleCategoryID AS nvarchar(50))
			FROM pLineFolderStyleCategory 
			WHERE pLineFolderStyleCategory.LineFolderID = lf.LineFolderID 
			ORDER BY pLineFolderStyleCategory.StyleCategoryID
			FOR XML PATH('')), 1, 2, '') AS StyleCategoryID
	, STUFF ((SELECT ', ' + pCalendarHeader.CalendarName
			FROM pCalendarLineFolder 
			INNER JOIN pCalendarHeader ON pCalendarLineFolder.CalendarHeaderID = pCalendarHeader.CalendarHeaderID
			WHERE pCalendarLineFolder.LineFolderID = lf.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS Calendar
	, CAST(lf.LineSubFolder6 AS DATETIME) AS DueDate
	, lfi.StyleID
FROM pLineFolder lf
	INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06604', GetDate())
GO
