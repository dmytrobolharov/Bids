IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'ColorPaletteGridSearchSchema' and object_id = object_id('pColorType'))
BEGIN 
	 ALTER TABLE pColorType
		ADD ColorPaletteGridSearchSchema nvarchar(200) NULL
END 
GO  
 

UPDATE pColorType SET ColorPaletteGridSearchSchema = 'Color_Palette_GridSearch_Default.xml'
WHERE ColorPaletteGridSearchSchema IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04291', GetDate())
GO