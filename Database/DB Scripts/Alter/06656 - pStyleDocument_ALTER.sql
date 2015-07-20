IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleDocument' AND COLUMN_NAME = 'TradePartnerID')
BEGIN
	ALTER TABLE pStyleDocument ADD TradePartnerID UNIQUEIDENTIFIER
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06656', GetDate())
GO
