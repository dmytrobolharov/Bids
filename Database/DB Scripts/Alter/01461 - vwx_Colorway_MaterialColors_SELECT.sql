
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Colorway_MaterialColors_SELECT]'))
DROP VIEW [dbo].[vwx_Colorway_MaterialColors_SELECT]
GO


CREATE VIEW [dbo].[vwx_Colorway_MaterialColors_SELECT]
AS
SELECT     dbo.pMaterialColor.MaterialColorID, dbo.pMaterialColor.MaterialID, dbo.pMaterialColor.MaterialColorImageID, dbo.pMaterialColor.MaterialColorImageVersion, 
                      dbo.pMaterialColor.ColorFolderID, dbo.pMaterialColor.ColorPaletteID, dbo.pMaterialColor.ColorID, dbo.pMaterialColor.ColorCode, dbo.pMaterialColor.ColorNo, 
                      dbo.pMaterialColor.ColorName, dbo.pMaterialColor.ColorSource, dbo.pMaterialColor.VendorColorNo, dbo.pMaterialColor.VendorColorName, 
                      dbo.pMaterialColor.MaterialColorNote, dbo.pMaterialColor.ColorHex, dbo.pMaterialColor.Hex, dbo.pMaterialColor.R, dbo.pMaterialColor.G, dbo.pMaterialColor.B, 
                      dbo.pMaterialColor.C, dbo.pMaterialColor.M, dbo.pMaterialColor.Y, dbo.pMaterialColor.K, dbo.pMaterialColor.H, dbo.pMaterialColor.S, dbo.pMaterialColor.L, 
                      dbo.pMaterialColor.LAB_L, dbo.pMaterialColor.LAB_A, dbo.pMaterialColor.LAB_B, dbo.pMaterialColor.ColorHexCode, dbo.pMaterialColor.CDate, 
                      dbo.pMaterialColor.CUser, dbo.pMaterialColor.MDate, dbo.pMaterialColor.MUser, dbo.pMaterialColor.MaterialColorVersion, dbo.pMaterialColor.ColorVersion, 
                      dbo.pMaterialColor.Action, dbo.pMaterialColor.Sort, dbo.pMaterialColor.VendorColorCode, dbo.pMaterialColor.CopyMaterialColorID, 
                      dbo.pMaterialColor.MaterialColorImageIDBak, dbo.pMaterialColorSeasonYear.SeasonYearID, dbo.pMaterialColorSeasonYear.MaterialColorSeasonYearID
FROM         dbo.pMaterialColor INNER JOIN
                      dbo.pMaterialColorSeasonYear ON dbo.pMaterialColor.MaterialColorID = dbo.pMaterialColorSeasonYear.MaterialColorID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01461', GetDate())
GO
