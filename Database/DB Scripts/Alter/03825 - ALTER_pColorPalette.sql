IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pColorPalette' and  DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom1 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom2 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom3 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom4 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom5 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom6 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom7 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom8 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom9 nvarchar(50)
	ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom10 nvarchar(50)
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'ColorLibraryPending' and  DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom1 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom2 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom3 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom4 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom5 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom6 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom7 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom8 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom9 nvarchar(50)
	ALTER TABLE ColorLibraryPending ALTER COLUMN ColorPaletteCustom10 nvarchar(50)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03825', GetDate())
GO
