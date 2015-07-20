IF OBJECT_ID(N'[dbo].[vwx_MaterialWizardRequest_ColorSeasonYear_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialWizardRequest_ColorSeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialWizardRequest_ColorSeasonYear_SEL]
AS
SELECT a.MaterialRequestGroupID, a.MaterialColorSeasonYearID, a.MaterialID, a.SeasonYearID, a.CUser, a.CDate, a.MaterialSizeID, 
       dbo.fnx_GetStreamingColorImageHTML(c.ColorFolderID, d.ColorPaletteID, 25, '') AS ColorImagePath, d.ColorCode, d.ColorName
FROM dbo.pMaterialRequestSeasonColorTemp AS a 
INNER JOIN dbo.pMaterialColorSeasonYear AS b ON a.MaterialColorSeasonYearID = b.MaterialColorSeasonYearID 
INNER JOIN dbo.pMaterialColor AS c ON c.MaterialColorID = b.MaterialColorID 
INNER JOIN dbo.pColorPalette AS d ON d.ColorPaletteID = c.ColorPaletteID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10327', GetUTCDate())
GO
