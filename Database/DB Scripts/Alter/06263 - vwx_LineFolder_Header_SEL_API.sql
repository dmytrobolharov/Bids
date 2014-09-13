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

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolder_Header_SEL_API]'))
	DROP VIEW [dbo].[vwx_LineFolder_Header_SEL_API]
GO


CREATE VIEW [dbo].[vwx_LineFolder_Header_SEL_API]
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
	(SELECT top 1 COALESCE(pStyleheader.DesignSketchID, '00000000-0000-0000-0000-000000000000')
	 FROM pStyleheader 
	 LEFT JOIN plinefolderitem ON plinefolderitem.StyleID = pStyleheader.StyleID
	 WHERE pLineFolder.LineFolderID = plinefolderitem.LineFolderID 
	 AND (pStyleheader.DesignSketchID IS NOT NULL 
	      AND pStyleheader.DesignSketchID <> '00000000-0000-0000-0000-000000000000')
	 ORDER BY plinefolderitem.mdate) AS DesignSketchID,
	(SELECT top 1 COALESCE(pStyleheader.DesignSketchversion, 0)
	 FROM pStyleheader 
	 LEFT JOIN plinefolderitem ON plinefolderitem.StyleID = pStyleheader.StyleID
	 WHERE pLineFolder.LineFolderID = plinefolderitem.LineFolderID
	 AND (pStyleheader.DesignSketchID IS NOT NULL 
	      AND pStyleheader.DesignSketchID <> '00000000-0000-0000-0000-000000000000') 
	 ORDER BY plinefolderitem.mdate) AS DesignSketchversion 
FROM pLineFolder 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06263', GetDate())
GO

SET NOCOUNT Off
GO
