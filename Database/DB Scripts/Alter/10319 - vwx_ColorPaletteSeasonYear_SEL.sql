IF OBJECT_ID(N'[dbo].[vwx_ColorPaletteSeasonYear_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_ColorPaletteSeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_ColorPaletteSeasonYear_SEL]
AS
SELECT dbo.fnx_GetStreamingColorImageHTML(cp.ColorFolderID, cp.ColorPaletteID, 20, '') AS ColorImagePath, 
       cp.ColorPaletteID, cp.ColorFolderID, cp.ColorCode, cp.ColorName, cp.ColorSource, cp.ColorNotes, 
	   cp.Hex, cp.R, cp.G, cp.B, cp.C, cp.M, cp.Y, cp.K, cp.H, cp.S, cp.L, cp.LAB_L, cp.LAB_A, cp.LAB_B, 
	   cp.CUser, cp.CDate, cp.MUser, cp.MDate, cp.ColorID, cp.Change, cp.Action, cp.Active, cp.Sort, 
	   cp.ColorImage, cp.ColorImageType, cp.CopyColorPaletteID, cpsy.SeasonYearID, cpsy.ColorSeason, 
       cpsy.ColorYear, cf.ColorFolderDescription, cp.ColorClassID, cc.ColorClassName As ColorClass 
FROM dbo.pColorPalette cp 
INNER JOIN dbo.pColorPaletteSeasonYear cpsy ON cp.ColorPaletteID = cpsy.ColorPaletteID 
LEFT JOIN dbo.pColorFolder cf ON cp.ColorFolderID = cf.ColorFolderID 
LEFT JOIN dbo.pColorClass cc ON cp.ColorClassID = cc.ColorClassID
WHERE (cp.CUser <> 'YUNIQUE') OR (cp.CUser IS NULL)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10319', GetUTCDate())
GO
