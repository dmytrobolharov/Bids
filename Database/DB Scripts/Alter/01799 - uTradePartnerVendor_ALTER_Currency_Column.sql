ALTER TABLE [dbo].[uTradePartnerVendor]
	ALTER COLUMN [CurrencyType] [uniqueidentifier] NULL
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01799'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01799', GetDate())
END

GO 

