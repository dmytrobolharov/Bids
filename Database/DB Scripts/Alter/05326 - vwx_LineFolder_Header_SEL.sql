/****** Object:  View [dbo].[vwx_LineFolder_Header_SEL]    Script Date: 03/18/2013 12:43:35 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolder_Header_SEL]'))
DROP VIEW [dbo].[vwx_LineFolder_Header_SEL]
GO

/****** Object:  View [dbo].[vwx_LineFolder_Header_SEL]    Script Date: 03/18/2013 12:43:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LineFolder_Header_SEL]
AS
SELECT pLineFolder.*,
		STUFF(
		(SELECT ', ' + pStyleType.StyleTypeDescription
		FROM pLineFolderStyleType LEFT JOIN pStyleType ON pLineFolderStyleType.StyleTypeID = pStyleType.StyleTypeID
		WHERE pLineFolderStyleType.LineFolderID = pLineFolder.LineFolderID
		FOR XML PATH('')), 1, 2, '') AS StyleType,
		STUFF(
		(SELECT ', ' + pStyleCategory.StyleCategory
		FROM pLineFolderStyleCategory LEFT JOIN pStyleCategory ON pStyleCategory.StyleCategoryId = pLineFolderStyleCategory.StyleCategoryID
		WHERE pLineFolderStyleCategory.LineFolderID = pLineFolder.LineFolderID
		FOR XML PATH('')), 1, 2, '') AS StyleCategory	
 FROM pLineFolder

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05326', GetDate())
GO
