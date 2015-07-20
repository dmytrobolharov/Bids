IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_MaterialGroupColor_SEL')
    DROP VIEW vwx_MaterialGroupColor_SEL
GO

CREATE VIEW [dbo].[vwx_MaterialGroupColor_SEL]
AS

SELECT  a.MaterialCoreColorID, a.MaterialCoreID,
'<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(b.ColorFolderID, '00000000-0000-0000-0000-000000000000') 
AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(b.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
+ '''  />' AS ColorImagePath, b.ColorCode, b.ColorName
FROM pMaterialCoreColor a 
INNER JOIN pColorPalette AS b ON a.ColorPaletteID = b.ColorPaletteID
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01164', GetDate())
GO

