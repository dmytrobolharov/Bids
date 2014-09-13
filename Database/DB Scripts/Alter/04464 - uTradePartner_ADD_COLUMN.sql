IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartner' AND COLUMN_NAME = N'TradePartnerStatusID')
BEGIN 
	ALTER TABLE uTradePartner ADD TradePartnerStatusID INT NULL
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '04464', GetDate())
GO