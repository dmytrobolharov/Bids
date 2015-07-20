IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartnerContact'
and COLUMN_NAME = N'PhoneNumber'
and CHARACTER_MAXIMUM_LENGTH = 50 )
BEGIN
      ALTER TABLE uTradePartnerContact ALTER COLUMN PhoneNumber NVARCHAR(50) NULL
END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02261'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02261', GetDate())
END
GO