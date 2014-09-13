IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialColor_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_MaterialColor_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialColor_SEL] 
AS

SELECT a.MaterialColorID, a.SeasonYearID, a.MaterialID , c.ColorName 
FROM pMaterialColorSeasonYear a WITH(NOLOCK)
	INNER JOIN dbo.pMaterialColor b WITH(NOLOCK) ON a.MaterialColorID = b.MaterialColorID 
	INNER JOIN dbo.pColorPalette c WITH(NOLOCK) ON c.ColorPaletteID =  b.ColorPaletteID
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01575'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01575', GetDate())
END	

GO
