/****** Object:  View [dbo].[vwx_MaterialColor_Select]    Script Date: 01/25/2011 14:49:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialColor_Select]'))
DROP VIEW [dbo].[vwx_MaterialColor_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create VIEW [dbo].[vwx_MaterialColor_Select]
AS
SELECT     '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(pMaterialColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pMaterialColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '''  />' AS ColorImagePath, pMaterialColor.MaterialColorID as MaterialColorID, pMaterialColor.MaterialID as MaterialID, pMaterialColor.MaterialColorImageID as MaterialColorImageID, 
                      pMaterialColor.MaterialColorImageVersion as MaterialColorImageVersion, pMaterialColor.ColorFolderID as ColorFolderID, pMaterialColor.ColorPaletteID as ColorPaletteID, pMaterialColor.ColorID as ColorID, 
                      pMaterialColor.ColorCode as ColorCode, pMaterialColor.ColorNo as ColorNo, pMaterialColor.ColorName as ColorName, pMaterialColor.ColorSource as ColorSource, pMaterialColor.VendorColorNo as VendorColorNo, 
                      pMaterialColor.VendorColorName as VendorColorName, pMaterialColor.MaterialColorNote as MaterialColorNote, pMaterialColor.ColorHex as ColorHex, pMaterialColor.Hex as Hex, pMaterialColor.R as R, 
                      pMaterialColor.G as G, pMaterialColor.B as B, pMaterialColor.C as C, pMaterialColor.M as M, pMaterialColor.Y as Y, pMaterialColor.K as K, pMaterialColor.H as H, 
                      pMaterialColor.S as S, pMaterialColor.L as L, pMaterialColor.LAB_L as LAB_L, pMaterialColor.LAB_A as LAB_A, pMaterialColor.LAB_B as LAB_B, pMaterialColor.ColorHexCode as ColorHexCode, 
                      pMaterialColor.CDate as CDate, pMaterialColor.CUser as CUser, pMaterialColor.MDate as MDate, pMaterialColor.MUser as MUser, pMaterialColor.MaterialColorVersion as MaterialColorVersion, 
                      pMaterialColor.ColorVersion as ColorVersion, pMaterialColor.[Action], pMaterialColor.Sort as Sort, pMaterialColor.VendorColorCode as VendorColorCode, pMaterialColor.CopyMaterialColorID as CopyMaterialColorID, 
                      pMaterial.MaterialNo as MaterialNo , pMaterial.MaterialName as MaterialName
FROM         pMaterialColor INNER JOIN
                      pMaterial ON pMaterialColor.MaterialID = pMaterial.MaterialID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01049', GetDate())
GO