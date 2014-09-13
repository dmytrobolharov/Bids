ALTER TABLE pColorPalette ALTER COLUMN ColorPaletteCustom4 nvarchar(50)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03665', GetDate())
GO