IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartner'
and COLUMN_NAME = N'TradePartnerCode'
and CHARACTER_MAXIMUM_LENGTH = 25 )
BEGIN
      ALTER TABLE uTradePartner ALTER COLUMN TradePartnerCode NVARCHAR(25) NULL
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02235'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02235', GetDate())
END
GO