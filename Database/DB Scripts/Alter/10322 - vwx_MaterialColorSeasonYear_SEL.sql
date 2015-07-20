IF OBJECT_ID(N'[dbo].[vwx_MaterialColorSeasonYear_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialColorSeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialColorSeasonYear_SEL]
AS
SELECT TOP (100) PERCENT a.MaterialColorID, a.MaterialID, a.MaterialColorImageID, a.MaterialColorImageVersion, a.ColorFolderID, a.ColorPaletteID, 
                      a.ColorID, a.ColorCode, a.ColorNo, a.ColorName, a.ColorSource, a.VendorColorNo, a.VendorColorName, a.MaterialColorNote, a.ColorHex, a.Hex, a.R, 
                      a.G, a.B, a.C, a.M, a.Y, a.K, a.H, a.S, a.L, a.LAB_L, a.LAB_A, a.LAB_B, a.ColorHexCode, a.CDate, a.CUser, a.MDate, a.MUser, a.MaterialColorVersion, 
                      a.ColorVersion, a.Action, a.Sort, a.VendorColorCode, a.CopyMaterialColorID, b.SeasonYearID, b.MaterialColorSeasonYearID, 
                      dbo.fnx_GetStreamingColorImageHTML(c.ColorFolderID, c.ColorPaletteID, 25, '') AS ColorImagePath
FROM         dbo.pMaterialColor AS a INNER JOIN
                      dbo.pMaterialColorSeasonYear AS b ON a.MaterialColorID = b.MaterialColorID AND a.MaterialID = b.MaterialID LEFT OUTER JOIN
                      dbo.pColorPalette AS c ON c.ColorPaletteID = a.ColorPaletteID
ORDER BY a.Sort, a.ColorCode, a.ColorName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10322', GetUTCDate())
GO
