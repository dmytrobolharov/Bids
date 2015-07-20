IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uTradePartnerContact' AND COLUMN_NAME = 'Intellimas')
BEGIN
	ALTER TABLE uTradePartnerContact ADD Intellimas INT NOT NULL DEFAULT(0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06492', GetDate())
GO
