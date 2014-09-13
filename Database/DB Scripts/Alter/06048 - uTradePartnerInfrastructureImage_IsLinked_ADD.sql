IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uTradePartnerInfrastructureImage' AND COLUMN_NAME = 'IsLinked')
BEGIN
	ALTER TABLE uTradePartnerInfrastructureImage ADD IsLinked INT NULL
END
GO

UPDATE uTradePartnerInfrastructureImage SET IsLinked = 0 WHERE IsLinked IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06048', GetDate())
GO
