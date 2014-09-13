/* ALTER TABLE pStyleQuoteItem */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleQuoteItem' AND COLUMN_NAME = 'StyleQuoteItem_EcomUnits')
BEGIN
	ALTER TABLE pStyleQuoteItem ADD StyleQuoteItem_EcomUnits INT
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleQuoteItem' AND COLUMN_NAME = 'StyleQuoteItem_EcomPriceUnit')
BEGIN
	ALTER TABLE pStyleQuoteItem ADD StyleQuoteItem_EcomPriceUnit DECIMAL(18,5)
END

/* ALTER TABLE pSourcingCommitmentItem */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingCommitmentItem' AND COLUMN_NAME = 'StyleQuoteItem_EcomUnits')
BEGIN
	ALTER TABLE pSourcingCommitmentItem ADD StyleQuoteItem_EcomUnits INT
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingCommitmentItem' AND COLUMN_NAME = 'StyleQuoteItem_EcomPriceUnit')
BEGIN
	ALTER TABLE pSourcingCommitmentItem ADD StyleQuoteItem_EcomPriceUnit DECIMAL(18,5)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08155', GetDate())
GO
