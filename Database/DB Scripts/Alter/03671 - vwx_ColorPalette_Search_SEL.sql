/****** Object:  View [dbo].[vwx_ColorPalette_Search_SEL]    Script Date: 06/20/2012 12:51:15 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorPalette_Search_SEL]'))
DROP VIEW [dbo].[vwx_ColorPalette_Search_SEL]
GO

/****** Object:  View [dbo].[vwx_ColorPalette_Search_SEL]    Script Date: 06/20/2012 12:51:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ColorPalette_Search_SEL]
AS
SELECT     dbo.pColorFolder.ColorFolderDescription, dbo.pColorFolder.ColorSubFolder1, dbo.pColorFolder.ColorSubFolder2, dbo.pColorFolder.ColorSubFolder3, 
                      dbo.pColorFolder.ColorSubFolder4, dbo.pColorFolder.ColorSubFolder5, dbo.pColorFolder.ColorSubFolder6, dbo.pColorFolder.ColorSubFolder7, 
                      dbo.pColorFolder.ColorSubFolder8, dbo.pColorFolder.ColorSubFolder9, dbo.pColorFolder.CUser, dbo.pColorFolder.CDate, dbo.pColorFolder.MUser, 
                      dbo.pColorFolder.MDate, dbo.pColorFolder.MChange, dbo.pColorFolder.Active, dbo.pColorFolder.StyleColorway, dbo.pColorPalette.ColorSource, 
                      dbo.pColorPalette.ColorName, dbo.pColorPalette.ColorCode, dbo.pColorFolder.ColorFolderID, dbo.pColorFolder.ColorTypeID, 
                      dbo.pColorFolder.SystemServerStorageID, dbo.pColorPalette.ColorPaletteCustom1, dbo.pColorPalette.ColorPaletteCustom2, dbo.pColorPalette.ColorPaletteCustom3, 
                      dbo.pColorPalette.ColorPaletteCustom4, dbo.pColorPalette.ColorPaletteCustom5, dbo.pColorPalette.ColorPaletteCustom6, dbo.pColorPalette.ColorPaletteCustom7, 
                      dbo.pColorPalette.ColorPaletteCustom8, dbo.pColorPalette.ColorPaletteCustom9, dbo.pColorPalette.ColorPaletteCustom10
FROM         dbo.pColorFolder LEFT OUTER JOIN
                      dbo.pColorPalette ON dbo.pColorFolder.ColorFolderID = dbo.pColorPalette.ColorFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03671', GetDate())
GO