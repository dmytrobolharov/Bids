IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingQuoteStyleBOM' AND COLUMN_NAME = 'SourcingStyleID')
BEGIN
	ALTER TABLE pSourcingQuoteStyleBOM ADD SourcingStyleID uniqueidentifier NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingQuotationBOMDetails' AND COLUMN_NAME = 'SourcingStyleID')
BEGIN
	ALTER TABLE pSourcingQuotationBOMDetails ADD SourcingStyleID uniqueidentifier NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04375', GetDate())
GO