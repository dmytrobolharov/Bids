ALTER TABLE pStyleQuoteItem ADD StyleQuotaVendorDutyID UNIQUEIDENTIFIER NULL
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02492'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02492', GetDate())
END
GO