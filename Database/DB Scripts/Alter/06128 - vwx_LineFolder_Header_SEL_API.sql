/****** Object:  View [dbo].[vwx_LineFolder_Header_SEL_API]    Script Date: 08/08/2013 01:19:46 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolder_Header_SEL_API]'))
DROP VIEW [dbo].[vwx_LineFolder_Header_SEL_API]
GO


/****** Object:  View [dbo].[vwx_LineFolder_Header_SEL_API]    Script Date: 08/08/2013 01:19:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_LineFolder_Header_SEL_API]
AS
SELECT     pLineFolder.*, '' as StyleType, '' as StyleCategory, 
--(SELECT  top 1 convert(nvarchar(50),pStyleheader.DesignSketchID) + ',' + convert(nvarchar(2),pStyleheader.DesignSketchVersion)
(SELECT  top 1 COALESCE(pStyleheader.DesignSketchID,'00000000-0000-0000-0000-000000000000')
 FROM   pStyleheader LEFT JOIN
 plinefolderitem ON plinefolderitem.StyleID = pStyleheader.StyleID
 WHERE     pLineFolder.LineFolderID = plinefolderitem.LineFolderID and 
 (pStyleheader.DesignSketchID is not null and  pStyleheader.DesignSketchID<>'00000000-0000-0000-0000-000000000000') order by plinefolderitem.mdate) AS DesignSketchID ,
(SELECT  top 1 COALESCE(pStyleheader.DesignSketchversion,0)
 FROM   pStyleheader LEFT JOIN
 plinefolderitem ON plinefolderitem.StyleID = pStyleheader.StyleID
 WHERE     pLineFolder.LineFolderID = plinefolderitem.LineFolderID and 
 (pStyleheader.DesignSketchID is not null and  pStyleheader.DesignSketchID<>'00000000-0000-0000-0000-000000000000') order by plinefolderitem.mdate)  AS DesignSketchversion 
 from pLineFolder 





GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06128', GetDate())
GO
