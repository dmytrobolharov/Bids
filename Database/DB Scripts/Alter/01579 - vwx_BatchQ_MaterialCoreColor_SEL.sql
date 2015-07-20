IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialCoreColor_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_MaterialCoreColor_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialCoreColor_SEL]
AS

SELECT  a.MaterialCoreColorID, MaterialCoreID, b.ColorCode, b.ColorName
FROM dbo.pMaterialCoreColor a 
	INNER JOIN dbo.pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01579'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01579', GetDate())
END	

GO
