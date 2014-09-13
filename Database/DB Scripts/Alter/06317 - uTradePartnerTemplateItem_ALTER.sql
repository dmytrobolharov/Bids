IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uTradePartnerTemplateItem' AND COLUMN_NAME = 'Shared')
BEGIN
	ALTER TABLE uTradePartnerTemplateItem ADD Shared BIT
	ALTER TABLE dbo.uTradePartnerTemplateItem ADD CONSTRAINT DF_uTradePartnerTemplateItem_Shared DEFAULT (1) FOR Shared
END
GO

UPDATE uTradePartnerTemplateItem SET Shared = 1
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06317', GetDate())
GO
