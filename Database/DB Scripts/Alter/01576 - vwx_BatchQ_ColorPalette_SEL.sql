IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorPalette_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_ColorPalette_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_ColorPalette_SEL]
AS
SELECT     
	'<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(a.ColorFolderID, 
	'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(a.ColorPaletteID, 
    '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, 
    a.ColorPaletteID, a.ColorFolderID, 
    a.ColorCode, a.ColorName, a.ColorPaletteCustom1,  a.ColorPaletteCustom4
FROM dbo.pColorPalette a

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01576'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01576', GetDate())
END	

GO
