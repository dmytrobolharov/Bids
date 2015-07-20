IF EXISTS (SELECT * FROM pStyleCostingType WHERE StyleCostingType = 'CMP')
BEGIN
	UPDATE pStyleCostingType
	SET StyleCostingType = 'CMT', 
		StyleEnhancedCostingSchema = 'Style_Costing_CMTUnits.xml',
		StyleEnhancedCostingSpreadsheet = 'Style_Costing_CMT_New.xls',
		StyleEnhancedQuoteSchema = 'Sourcing_StylePage_QuotationEdit_CMT.xml',
		StyleEnhancedCommitmentSchema = 'Sourcing_StylePage_CommitmentEdit_CMT.xml',
		StyleEnhancedQuotationPaletteSchema = 'Sourcing_StylePage_Quotation_CMT.xml',
		StyleQuoteDBOMDetailSchema = 'Sourcing_StylePage_QuotationBOMEdit_CMT.xml',
		StyleQuoteDBOMDetailReadSchema = 'Sourcing_StylePage_QuotationBOMEditRead_CMT.xml',
		StyleCommitmentDBOMDetailSchema = 'Sourcing_StylePage_CommitmentBOMEdit_CMT.xml'
	WHERE StyleCostingType = 'CMP'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07224', GetDate())
GO
