IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'uTradePartnerVendor'
and COLUMN_NAME = N'VendorCode'
and CHARACTER_MAXIMUM_LENGTH = 25 )
BEGIN
      ALTER TABLE uTradePartnerVendor ALTER COLUMN VendorCode NVARCHAR(25) NULL
END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02260'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02260', GetDate())
END
GO