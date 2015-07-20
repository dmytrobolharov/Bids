IF OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorPalette_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_ColorPalette_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_ColorPalette_SEL]
AS
SELECT dbo.fnx_GetStreamingColorImageHTML(a.ColorFolderID, a.ColorPaletteID, 25, '') AS ColorImagePath, 
       a.ColorPaletteID, a.ColorFolderID, a.ColorCode, a.ColorName, a.ColorPaletteCustom1, a.ColorPaletteCustom4
FROM dbo.pColorPalette a

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10309', GetUTCDate())
GO
