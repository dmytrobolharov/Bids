IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'pLineFolder'
			AND COLUMN_NAME='FlashCostFixedMarkup')
BEGIN
	ALTER TABLE pLineFolder ADD FlashCostFixedMarkup INT NOT NULL DEFAULT 0
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04636', GetDate())
GO
