IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleBOMDimensionItems' AND COLUMN_NAME = 'ComboActive')
BEGIN
	ALTER TABLE pStyleBOMDimensionItems ADD ComboActive INT DEFAULT 1
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06462', GetDate())
GO
