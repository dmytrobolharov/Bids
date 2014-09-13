IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleEnhancedCostingSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleEnhancedCostingSchema NVARCHAR (200)
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleEnhancedCostingSpreadsheet')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleEnhancedCostingSpreadsheet NVARCHAR (200)
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleEnhancedQuoteSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleEnhancedQuoteSchema NVARCHAR (200)
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleEnhancedQuotationPaletteSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleEnhancedQuotationPaletteSchema NVARCHAR (200)
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingType' AND COLUMN_NAME = 'StyleEnhancedCommitmentSchema')
BEGIN
	ALTER TABLE pStyleCostingType ADD StyleEnhancedCommitmentSchema NVARCHAR (200)
END
GO

-- Import
UPDATE pStyleCostingType SET 
	StyleEnhancedCostingSchema = 'Style_Costing_ImportUnits.xml',
	StyleEnhancedCostingSpreadsheet = 'Style_Costing_Import_New.xls',
	StyleEnhancedQuoteSchema = 'Sourcing_StylePage_QuotationEdit_Import.xml',
	StyleEnhancedQuotationPaletteSchema = 'Sourcing_StylePage_Quotation_Import.xml',
	StyleEnhancedCommitmentSchema = 'Sourcing_StylePage_CommitmentEdit_Import.xml'
WHERE StyleCostingTypeID = 1

-- Domestic
UPDATE pStyleCostingType SET 
	StyleEnhancedCostingSchema = 'Style_Costing_DomesticUnits.xml',
	StyleEnhancedCostingSpreadsheet = 'Style_Costing_Domestic_New.xls',
	StyleEnhancedQuoteSchema = 'Sourcing_StylePage_QuotationEdit_Domestic.xml',
	StyleEnhancedQuotationPaletteSchema = 'Sourcing_StylePage_Quotation_Domestic.xml',
	StyleEnhancedCommitmentSchema = 'Sourcing_StylePage_CommitmentEdit_Domestic.xml'
WHERE StyleCostingTypeID = 3

-- Indirect
UPDATE pStyleCostingType SET 
	StyleEnhancedCostingSchema = 'Style_Costing_IndirectUnits.xml',
	StyleEnhancedCostingSpreadsheet = 'Style_Costing_Indirect_New.xls',
	StyleEnhancedQuoteSchema = 'Sourcing_StylePage_QuotationEdit_Indirect.xml',
	StyleEnhancedQuotationPaletteSchema = 'Sourcing_StylePage_Quotation_Indirect.xml',
	StyleEnhancedCommitmentSchema = 'Sourcing_StylePage_CommitmentEdit_Indirect.xml'
WHERE StyleCostingTypeID = 4

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05818', GetDate())
GO
