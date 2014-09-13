IF NOT EXISTS (SELECT * FROM pStyleCostingType WHERE StyleCostingTypeID = 9)
BEGIN
	INSERT INTO pStyleCostingType (StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, StyleCostingTypeRepId, ShowBOM, ShowBOL, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			StyleEnhancedCostingSchema, StyleEnhancedCostingSpreadsheet, StyleEnhancedQuoteSchema, StyleEnhancedCommitmentSchema, StyleEnhancedQuotationPaletteSchema, 
			StyleQuoteDBOMDetailSchema, StyleQuoteDBOMDetailReadSchema, StyleCommitmentDBOMDetailSchema)
	SELECT 9, 'Pre Pack', StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, NEWID(), 1, 1, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			'Style_Costing_PrePackUnits.xml', 'Style_Costing_PrePack_New.xls', 'Sourcing_StylePage_QuotationEdit_PrePack.xml', 'Sourcing_StylePage_CommitmentEdit_PrePack.xml', 'Sourcing_StylePage_Quotation_PrePack.xml', 
			'Sourcing_StylePage_QuotationBOMEdit_PrePack.xml', 'Sourcing_StylePage_QuotationBOMEditRead_PrePack.xml', 'Sourcing_StylePage_CommitmentBOMEdit_PrePack.xml'
	FROM pStyleCostingType
	WHERE StyleCostingTypeID = 1
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07158', GetDate())
GO
