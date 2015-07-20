IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]
AS
SELECT     '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&CPID=' + CAST(ISNULL(ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, ColorPaletteID, ColorFolderID, 
                      ColorCode, ColorName, ColorSource, ColorNotes, Hex, R, G, B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorID, Change, Action, 
                      Active, Sort, ColorImage, ColorImageType, CopyColorPaletteID, SystemServerStorageID, ColorPaletteCustom1, ColorPaletteCustom2, ColorPaletteCustom3, 
                      ColorPaletteCustom4, ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7, ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10, Status, 
                      ColorLibraryID
FROM         dbo.pColorPalette
WHERE     (CUser <> 'YUNIQUE' OR
                      CUser IS NULL) AND EXISTS
                          (SELECT     ColorPaletteSeasonYearID, SeasonYearID, ColorFolderID, ColorPaletteID, ColorSeason, ColorYear, CUser, CDate, MUser, MDate, CurrentSeason
                            FROM          dbo.pColorPaletteSeasonYear
                            WHERE      (ColorPaletteID = dbo.pColorPalette.ColorPaletteID))

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07216', GetDate())
GO
