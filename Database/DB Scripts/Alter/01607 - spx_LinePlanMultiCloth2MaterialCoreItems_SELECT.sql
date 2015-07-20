IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialCoreItems_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialCoreItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialCoreItems_SELECT](
	@MaterialCoreID uniqueidentifier
)
AS 


SELECT a.MaterialCoreColorID, a.MaterialColorID, b.ColorPaletteID,c.ColorCode, c.ColorName, a.MaterialID, a.MaterialCoreItemID
FROM pMaterialCoreColorItem a
INNER JOIN pMaterialCoreColor b ON a.MaterialCoreColorID = b.MaterialCoreColorID
INNER JOIN pColorPalette c ON c.ColorPaletteID =  b.ColorPaletteID 
WHERE a.MaterialCoreID = @MaterialCoreID 





GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01607'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01607', GetDate())
END	

GO
