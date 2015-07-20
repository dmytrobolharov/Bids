/****** Object:  View [dbo].[vwx_MaterialColor_Select]    Script Date: 04/12/2012 12:37:04 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialColor_Select]'))
DROP VIEW [dbo].[vwx_MaterialColor_Select]
GO

/****** Object:  View [dbo].[vwx_MaterialColor_Select]    Script Date: 04/12/2012 12:37:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialColor_Select]
AS
SELECT     '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pMaterialColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pMaterialColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '''  />' AS ColorImagePath, dbo.pMaterialColor.MaterialColorID, dbo.pMaterialColor.MaterialID, dbo.pMaterialColor.MaterialColorImageID, 
                      dbo.pMaterialColor.MaterialColorImageVersion, dbo.pMaterialColor.ColorFolderID, dbo.pMaterialColor.ColorPaletteID, dbo.pMaterialColor.ColorID, 
                      dbo.pMaterialColor.ColorCode, dbo.pMaterialColor.ColorNo, dbo.pMaterialColor.ColorName, dbo.pMaterialColor.ColorSource, dbo.pMaterialColor.VendorColorNo, 
                      dbo.pMaterialColor.VendorColorName, dbo.pMaterialColor.MaterialColorNote, dbo.pMaterialColor.ColorHex, dbo.pMaterialColor.Hex, dbo.pMaterialColor.R, 
                      dbo.pMaterialColor.G, dbo.pMaterialColor.B, dbo.pMaterialColor.C, dbo.pMaterialColor.M, dbo.pMaterialColor.Y, dbo.pMaterialColor.K, dbo.pMaterialColor.H, 
                      dbo.pMaterialColor.S, dbo.pMaterialColor.L, dbo.pMaterialColor.LAB_L, dbo.pMaterialColor.LAB_A, dbo.pMaterialColor.LAB_B, dbo.pMaterialColor.ColorHexCode, 
                      dbo.pMaterialColor.CDate, dbo.pMaterialColor.CUser, dbo.pMaterialColor.MDate, dbo.pMaterialColor.MUser, dbo.pMaterialColor.MaterialColorVersion, 
                      dbo.pMaterialColor.ColorVersion, dbo.pMaterialColor.Action, dbo.pMaterialColor.Sort, dbo.pMaterialColor.VendorColorCode, dbo.pMaterialColor.CopyMaterialColorID, 
                      dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.MaterialType
FROM         dbo.pMaterialColor INNER JOIN
                      dbo.pMaterial ON dbo.pMaterialColor.MaterialID = dbo.pMaterial.MaterialID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03340'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03340', GetDate())

END
GO