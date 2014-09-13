IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uTradePartner' AND COLUMN_NAME = 'DefaultCurrency')
BEGIN
	ALTER TABLE uTradePartner ADD DefaultCurrency NVARCHAR(5)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06779', GetDate())
GO
