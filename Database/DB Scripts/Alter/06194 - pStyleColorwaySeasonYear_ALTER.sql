IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleColorwaySeasonYear' AND COLUMN_NAME = 'ColorPaletteID')
BEGIN
	ALTER TABLE pStyleColorwaySeasonYear ADD ColorPaletteID UNIQUEIDENTIFIER NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06194', GetDate())
GO
