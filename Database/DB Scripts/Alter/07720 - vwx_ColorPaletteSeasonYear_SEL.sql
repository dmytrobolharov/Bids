IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorPaletteSeasonYear_SEL]'))
DROP VIEW [dbo].[vwx_ColorPaletteSeasonYear_SEL]
GO


CREATE VIEW [dbo].[vwx_ColorPaletteSeasonYear_SEL]
AS
SELECT     '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pColorPalette.ColorFolderID, 
                      '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pColorPalette.ColorPaletteID, 
                      '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, dbo.pColorPalette.ColorPaletteID, 
                      dbo.pColorPalette.ColorFolderID, dbo.pColorPalette.ColorCode, dbo.pColorPalette.ColorName, dbo.pColorPalette.ColorSource, 
                      dbo.pColorPalette.ColorNotes, dbo.pColorPalette.Hex, dbo.pColorPalette.R, dbo.pColorPalette.G, dbo.pColorPalette.B, dbo.pColorPalette.C, 
                      dbo.pColorPalette.M, dbo.pColorPalette.Y, dbo.pColorPalette.K, dbo.pColorPalette.H, dbo.pColorPalette.S, dbo.pColorPalette.L, 
                      dbo.pColorPalette.LAB_L, dbo.pColorPalette.LAB_A, dbo.pColorPalette.LAB_B, dbo.pColorPalette.CUser, dbo.pColorPalette.CDate, 
                      dbo.pColorPalette.MUser, dbo.pColorPalette.MDate, dbo.pColorPalette.ColorID, dbo.pColorPalette.Change, dbo.pColorPalette.Action, 
                      dbo.pColorPalette.Active, dbo.pColorPalette.Sort, dbo.pColorPalette.ColorImage, dbo.pColorPalette.ColorImageType, 
                      dbo.pColorPalette.CopyColorPaletteID, dbo.pColorPaletteSeasonYear.SeasonYearID, dbo.pColorPaletteSeasonYear.ColorSeason, 
                      dbo.pColorPaletteSeasonYear.ColorYear,
                      dbo.pColorFolder.ColorFolderDescription, dbo.pColorPalette.ColorClassID, dbo.pColorClass.ColorClassName As ColorClass 
FROM         dbo.pColorPalette INNER JOIN
                      dbo.pColorPaletteSeasonYear ON dbo.pColorPalette.ColorPaletteID = dbo.pColorPaletteSeasonYear.ColorPaletteID LEFT JOIN
                      dbo.pColorFolder ON dbo.pColorPalette.ColorFolderID = dbo.pColorFolder.ColorFolderID LEFT JOIN 
                      dbo.pColorClass ON dbo.pColorPalette.ColorClassID = dbo.pColorClass.ColorClassID
WHERE     (dbo.pColorPalette.CUser <> 'YUNIQUE') OR
                      (dbo.pColorPalette.CUser IS NULL)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07720', GetDate())
GO
