IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleQuoteDBOMDetailSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleQuoteDBOMDetailSchema NVARCHAR (200)
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleQuoteDBOMDetailReadSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleQuoteDBOMDetailReadSchema NVARCHAR (200)
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleCommitmentDBOMDetailSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleCommitmentDBOMDetailSchema NVARCHAR (200)
END
GO

-- Import
UPDATE pStyleCostingType SET 
	StyleQuoteDBOMDetailReadSchema = 'Sourcing_StylePage_QuotationBOMEditRead_Import.xml',
	StyleQuoteDBOMDetailSchema = 'Sourcing_StylePage_QuotationBOMEdit_Import.xml',
	StyleCommitmentDBOMDetailSchema = 'Sourcing_StylePage_CommitmentBOMEdit_Import.xml'
WHERE StyleCostingTypeID = 1

-- Domestic
UPDATE pStyleCostingType SET 
	StyleQuoteDBOMDetailReadSchema = 'Sourcing_StylePage_QuotationBOMEditRead_Domestic.xml',
	StyleQuoteDBOMDetailSchema = 'Sourcing_StylePage_QuotationBOMEdit_Domestic.xml',
	StyleCommitmentDBOMDetailSchema = 'Sourcing_StylePage_CommitmentBOMEdit_Domestic.xml'
WHERE StyleCostingTypeID = 3

-- Indirect
UPDATE pStyleCostingType SET 
	StyleQuoteDBOMDetailReadSchema = 'Sourcing_StylePage_QuotationBOMEditRead_Indirect.xml',
	StyleQuoteDBOMDetailSchema = 'Sourcing_StylePage_QuotationBOMEdit_Indirect.xml',
	StyleCommitmentDBOMDetailSchema = 'Sourcing_StylePage_CommitmentBOMEdit_Indirect.xml'
WHERE StyleCostingTypeID = 4

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06116', GetDate())
GO
