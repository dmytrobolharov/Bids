IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterial' AND COLUMN_NAME = 'CurrencyType')
BEGIN
	ALTER TABLE pMaterial ADD CurrencyType NVARCHAR(5)
END
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialTradePartner' AND COLUMN_NAME = 'CurrencyType')
BEGIN
	ALTER TABLE pMaterialTradePartner ADD CurrencyType NVARCHAR(5)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06780', GetDate())
GO
