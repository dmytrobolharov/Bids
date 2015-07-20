IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorPalette_GRID_SEL]') AND type = N'V')
	DROP VIEW [dbo].[vwx_ColorPalette_GRID_SEL]
GO

CREATE VIEW [dbo].[vwx_ColorPalette_GRID_SEL]
AS
SELECT     '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '''  />' AS ColorImagePath, dbo.pColorPalette.ColorPaletteID, dbo.pColorPalette.ColorFolderID, dbo.pColorPalette.ColorCode, dbo.pColorPalette.ColorName, 
                      dbo.pColorPalette.ColorSource, dbo.pColorPalette.ColorNotes, dbo.pColorPalette.Hex, dbo.pColorPalette.R, dbo.pColorPalette.G, dbo.pColorPalette.B, 
                      dbo.pColorPalette.C, dbo.pColorPalette.M, dbo.pColorPalette.Y, dbo.pColorPalette.K, dbo.pColorPalette.H, dbo.pColorPalette.S, dbo.pColorPalette.L, 
                      dbo.pColorPalette.LAB_L, dbo.pColorPalette.LAB_A, dbo.pColorPalette.LAB_B, dbo.pColorPalette.CUser, dbo.pColorPalette.CDate, dbo.pColorPalette.MUser, 
                      dbo.pColorPalette.MDate, dbo.pColorPalette.ColorID, dbo.pColorPalette.Change, dbo.pColorPalette.Action, dbo.pColorPalette.Active, dbo.pColorPalette.Sort, 
                      dbo.pColorPalette.ColorImage, dbo.pColorPalette.ColorImageType, dbo.pColorPalette.CopyColorPaletteID, dbo.pColorPalette.SystemServerStorageID, 
                      dbo.pColorFolder.ColorFolderDescription, dbo.pColorFolder.ColorTypeID, dbo.pColorPalette.ColorClassID, dbo.pColorPaletteSeasonYear.SeasonYearID,
					  dbo.pColorPalette.Status, dbo.pColorPaletteSeasonYear.ColorSeason + ' ' + dbo.pColorPaletteSeasonYear.ColorYear as ColorSeasonYear
FROM         dbo.pColorPalette INNER JOIN
                      dbo.pColorFolder ON dbo.pColorPalette.ColorFolderID = dbo.pColorFolder.ColorFolderID LEFT OUTER JOIN
                      dbo.pColorPaletteSeasonYear ON dbo.pColorPalette.ColorPaletteID = dbo.pColorPaletteSeasonYear.ColorPaletteID
WHERE     (dbo.pColorPalette.CUser <> 'YUNIQUE') OR
                      (dbo.pColorPalette.CUser IS NULL)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '6.0.0000', '09038', GetDate())
GO

