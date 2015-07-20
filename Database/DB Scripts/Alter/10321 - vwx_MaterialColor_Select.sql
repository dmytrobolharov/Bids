IF OBJECT_ID(N'[dbo].[vwx_MaterialColor_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialColor_Select]
GO

CREATE VIEW [dbo].[vwx_MaterialColor_Select]
AS
SELECT dbo.fnx_GetStreamingColorImageHTML(mc.ColorFolderID, mc.ColorPaletteID, 25, '') AS ColorImagePath, 
       mc.MaterialColorID, mc.MaterialID, mc.MaterialColorImageID, mc.MaterialColorImageVersion, mc.ColorFolderID, 
	   mc.ColorPaletteID, mc.ColorID, mc.ColorCode, mc.ColorNo, mc.ColorName, mc.ColorSource, mc.VendorColorNo, 
       mc.VendorColorName, mc.MaterialColorNote, mc.ColorHex, mc.Hex, mc.R, mc.G, mc.B, mc.C, mc.M, mc.Y, mc.K, 
	   mc.H, mc.S, mc.L, mc.LAB_L, mc.LAB_A, mc.LAB_B, mc.ColorHexCode, mc.CDate, mc.CUser, mc.MDate, mc.MUser, 
	   mc.MaterialColorVersion, mc.ColorVersion, mc.Action, mc.Sort, mc.VendorColorCode, mc.CopyMaterialColorID, 
       m.MaterialNo, m.MaterialName, m.MaterialType
FROM dbo.pMaterialColor mc
INNER JOIN dbo.pMaterial m ON mc.MaterialID = m.MaterialID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10321', GetUTCDate())
GO
