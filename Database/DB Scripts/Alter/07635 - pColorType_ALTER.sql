IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pColorType' AND COLUMN_NAME = 'ColorPaletteGridSchema')
BEGIN
	ALTER TABLE pColorType ADD ColorPaletteGridSchema NVARCHAR(200)
END
GO

UPDATE pColorType SET ColorPaletteGridSchema = 'Color_Palette_Grid_Default.xml'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07635', GetDate())
GO
