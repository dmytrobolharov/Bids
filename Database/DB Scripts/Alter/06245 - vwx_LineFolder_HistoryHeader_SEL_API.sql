
/****** Object:  View [dbo].[vwx_LineFolder_HistoryHeader_SEL_API]    Script Date: 08/27/2013 18:37:39 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolder_HistoryHeader_SEL_API]'))
DROP VIEW [dbo].[vwx_LineFolder_HistoryHeader_SEL_API]
GO

/****** Object:  View [dbo].[vwx_LineFolder_HistoryHeader_SEL_API]    Script Date: 08/27/2013 18:37:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[vwx_LineFolder_HistoryHeader_SEL_API]
AS

SELECT     pLineFolder.*, c.Teamid,  STUFF
                          ((SELECT     ', ' + pStyleType.StyleTypeDescription
                              FROM         pLineFolderStyleType LEFT JOIN
                                                    pStyleType ON pLineFolderStyleType.StyleTypeID = pStyleType.StyleTypeID
                              WHERE     pLineFolderStyleType.LineFolderID = pLineFolder.LineFolderID FOR XML PATH('')), 1, 2, '') AS StyleType, STUFF
                          ((SELECT     ', ' + pStyleCategory.StyleCategory
                              FROM         pLineFolderStyleCategory LEFT JOIN
                                                    pStyleCategory ON pStyleCategory.StyleCategoryId = pLineFolderStyleCategory.StyleCategoryID
                              WHERE     pLineFolderStyleCategory.LineFolderID = pLineFolder.LineFolderID FOR XML PATH('')), 1, 2, '') AS StyleCategory
 from pLineFolder Inner join  pLineListHistory c 
 On  c.LineFolderID = pLineFolder.LineFolderID 





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06245', GetDate())
GO
