/****** Object:  View [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]    Script Date: 05/16/2012 14:38:39 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]    Script Date: 05/16/2012 14:38:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]
AS
SELECT     '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&CPID=' + CAST(ISNULL(ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, ColorPaletteID, ColorFolderID, 
                      ColorCode, ColorName, ColorSource, ColorNotes, Hex, R, G, B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorID, Change, Action, 
                      Active, Sort, ColorImage, ColorImageType, CopyColorPaletteID
FROM         dbo.pColorPalette
WHERE     (CUser <> 'YUNIQUE' OR
                      CUser IS NULL) AND EXISTS
                          (SELECT     ColorPaletteSeasonYearID, SeasonYearID, ColorFolderID, ColorPaletteID, ColorSeason, ColorYear, CUser, CDate, MUser, MDate, CurrentSeason
                            FROM          dbo.pColorPaletteSeasonYear
                            WHERE      (ColorPaletteID = dbo.pColorPalette.ColorPaletteID))

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03481', GetDate())
GO