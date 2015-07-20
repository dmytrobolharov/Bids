IF OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_ColorPaletteSeasonYear_SEL]
AS
SELECT dbo.fnx_GetStreamingColorImageHTML(ColorFolderID, ColorPaletteID, 25, '') AS ColorImagePath, 
       ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, Hex, 
	   R, G, B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorID, Change, Action, 
       Active, Sort, ColorImage, ColorImageType, CopyColorPaletteID, SystemServerStorageID, ColorPaletteCustom1, 
	   ColorPaletteCustom2, ColorPaletteCustom3, ColorPaletteCustom4, ColorPaletteCustom5, ColorPaletteCustom6, 
	   ColorPaletteCustom7, ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10, Status, ColorLibraryID
FROM dbo.pColorPalette
WHERE (CUser <> 'YUNIQUE' OR CUser IS NULL) AND 
      EXISTS(SELECT * FROM dbo.pColorPaletteSeasonYear
             WHERE ColorPaletteID = dbo.pColorPalette.ColorPaletteID)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10310', GetUTCDate())
GO
