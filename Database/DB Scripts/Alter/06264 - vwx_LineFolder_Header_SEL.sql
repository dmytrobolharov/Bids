-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 13 March 2013                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

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
			FOR XML PATH('')), 1, 2, '') AS StyleTypeID, 
	STUFF ((SELECT ', ' + pStyleCategory.StyleCategory
			FROM pLineFolderStyleCategory 
			LEFT JOIN pStyleCategory ON pStyleCategory.StyleCategoryId = pLineFolderStyleCategory.StyleCategoryID
			WHERE pLineFolderStyleCategory.LineFolderID = pLineFolder.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS StyleCategory, 
	STUFF ((SELECT ', ' + CAST(pLineFolderStyleCategory.StyleCategoryID AS nvarchar(50))
			FROM pLineFolderStyleCategory 
			WHERE pLineFolderStyleCategory.LineFolderID = pLineFolder.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS StyleCategoryID,
	STUFF ((SELECT ', ' + pCalendarHeader.CalendarName
			FROM pCalendarLineFolder 
			INNER JOIN pCalendarHeader ON pCalendarLineFolder.CalendarHeaderID = pCalendarHeader.CalendarHeaderID
			WHERE pCalendarLineFolder.LineFolderID = pLineFolder.LineFolderID 
			FOR XML PATH('')), 1, 2, '') AS Calendar
FROM pLineFolder
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06264', GetDate())
GO

SET NOCOUNT Off
GO
