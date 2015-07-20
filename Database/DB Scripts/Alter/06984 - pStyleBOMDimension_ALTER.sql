IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleBOMDimension' AND COLUMN_NAME = 'ExchangeRateItemID')
BEGIN
	ALTER TABLE pStyleBOMDimension ADD ExchangeRateItemID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06984', GetDate())
GO
