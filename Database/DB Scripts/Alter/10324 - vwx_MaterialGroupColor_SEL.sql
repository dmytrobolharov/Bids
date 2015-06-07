IF OBJECT_ID(N'[dbo].[vwx_MaterialGroupColor_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialGroupColor_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialGroupColor_SEL]
AS

SELECT a.MaterialCoreColorID, a.MaterialCoreID,
       dbo.fnx_GetStreamingColorImageHTML(b.ColorFolderID, b.ColorPaletteID, 25, '') AS ColorImagePath, 
	   b.ColorCode, b.ColorName
FROM pMaterialCoreColor a 
INNER JOIN pColorPalette AS b ON a.ColorPaletteID = b.ColorPaletteID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10324', GetUTCDate())
GO
