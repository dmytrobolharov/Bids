/****** Object:  View [dbo].[vwx_MaterialColor_SEL]    Script Date: 05/16/2012 16:20:35 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialColor_SEL]'))
DROP VIEW [dbo].[vwx_MaterialColor_SEL]
GO

/****** Object:  View [dbo].[vwx_MaterialColor_SEL]    Script Date: 05/16/2012 16:20:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialColor_SEL]
AS
SELECT     '../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&CPID=' + CAST(ISNULL(ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImageUrl, 
                      '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&CPID=' + CAST(ISNULL(ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, MaterialColorID, MaterialID, 
                      MaterialColorImageID, MaterialColorImageVersion, ColorFolderID, ColorPaletteID, ColorID, ColorCode, ColorNo, ColorName, ColorSource, VendorColorNo, 
                      VendorColorName, MaterialColorNote, ColorHex, Hex, R, G, B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, ColorHexCode, CDate, CUser, MDate, MUser, 
                      MaterialColorVersion, ColorVersion, Action, Sort, VendorColorCode, CopyMaterialColorID
FROM         dbo.pMaterialColor

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03462', GetDate())
GO