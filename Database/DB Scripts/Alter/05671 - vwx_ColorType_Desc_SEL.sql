/****** Object:  View [dbo].[vwx_ColorType_Desc_SEL]    Script Date: 05/13/2013 14:17:05 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorType_Desc_SEL]'))
DROP VIEW [dbo].[vwx_ColorType_Desc_SEL]
GO

/****** Object:  View [dbo].[vwx_ColorType_Desc_SEL]    Script Date: 05/13/2013 14:17:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ColorType_Desc_SEL]
AS
SELECT     a.ColorFolderID, a.ColorFolderDescription, a.ColorSubFolder1, a.ColorSubFolder2, a.ColorSubFolder3, a.ColorSubFolder4, a.ColorSubFolder5, a.ColorSubFolder6, 
                      a.ColorSubFolder7, a.ColorSubFolder8, a.ColorSubFolder9, a.CUser, a.CDate, a.MUser, a.MDate, a.MChange, a.Active, a.StyleColorway, a.SystemServerStorageID, 
                      a.ColorTypeID, a.ColorTypeSort, b.ColorTypeDescription,
                          (SELECT     COUNT(*) AS Colors
                            FROM          dbo.pColorPalette
                            WHERE      (ColorFolderID = a.ColorFolderID)) AS ColorCount
FROM         dbo.pColorFolder AS a INNER JOIN
                      dbo.pColorType AS b ON a.ColorTypeID = b.ColorTypeID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05671', GetDate())
GO
