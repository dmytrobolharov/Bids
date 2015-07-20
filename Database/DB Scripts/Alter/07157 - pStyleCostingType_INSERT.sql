IF NOT EXISTS (SELECT * FROM pStyleCostingType WHERE StyleCostingTypeID = 5)
BEGIN
	INSERT INTO pStyleCostingType (StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, StyleCostingTypeRepId, ShowBOM, ShowBOL, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			StyleEnhancedCostingSchema, StyleEnhancedCostingSpreadsheet, StyleEnhancedQuoteSchema, StyleEnhancedCommitmentSchema, StyleEnhancedQuotationPaletteSchema, 
			StyleQuoteDBOMDetailSchema, StyleQuoteDBOMDetailReadSchema, StyleCommitmentDBOMDetailSchema)
	SELECT 5, 'FOB', StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, NEWID(), 1, 1, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			'Style_Costing_FOBUnits.xml', 'Style_Costing_FOB_New.xls', 'Sourcing_StylePage_QuotationEdit_FOB.xml', 'Sourcing_StylePage_CommitmentEdit_FOB.xml', 'Sourcing_StylePage_Quotation_FOB.xml', 
			'Sourcing_StylePage_QuotationBOMEdit_FOB.xml', 'Sourcing_StylePage_QuotationBOMEditRead_FOB.xml', 'Sourcing_StylePage_CommitmentBOMEdit_FOB.xml'
	FROM pStyleCostingType
	WHERE StyleCostingTypeID = 1
END


IF NOT EXISTS (SELECT * FROM pStyleCostingType WHERE StyleCostingTypeID = 6)
BEGIN
	INSERT INTO pStyleCostingType (StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, StyleCostingTypeRepId, ShowBOM, ShowBOL, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			StyleEnhancedCostingSchema, StyleEnhancedCostingSpreadsheet, StyleEnhancedQuoteSchema, StyleEnhancedCommitmentSchema, StyleEnhancedQuotationPaletteSchema, 
			StyleQuoteDBOMDetailSchema, StyleQuoteDBOMDetailReadSchema, StyleCommitmentDBOMDetailSchema)
	SELECT 6, 'DDP', StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, NEWID(), 1, 1, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			'Style_Costing_DDPUnits.xml', 'Style_Costing_DDP_New.xls', 'Sourcing_StylePage_QuotationEdit_DDP.xml', 'Sourcing_StylePage_CommitmentEdit_DDP.xml', 'Sourcing_StylePage_Quotation_DDP.xml', 
			'Sourcing_StylePage_QuotationBOMEdit_DDP.xml', 'Sourcing_StylePage_QuotationBOMEditRead_DDP.xml', 'Sourcing_StylePage_CommitmentBOMEdit_DDP.xml'
	FROM pStyleCostingType
	WHERE StyleCostingTypeID = 1
END


IF NOT EXISTS (SELECT * FROM pStyleCostingType WHERE StyleCostingTypeID = 7)
BEGIN
	INSERT INTO pStyleCostingType (StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, StyleCostingTypeRepId, ShowBOM, ShowBOL, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			StyleEnhancedCostingSchema, StyleEnhancedCostingSpreadsheet, StyleEnhancedQuoteSchema, StyleEnhancedCommitmentSchema, StyleEnhancedQuotationPaletteSchema, 
			StyleQuoteDBOMDetailSchema, StyleQuoteDBOMDetailReadSchema, StyleCommitmentDBOMDetailSchema)
	SELECT 7, 'LDP', StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, NEWID(), 1, 1, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			'Style_Costing_LDPUnits.xml', 'Style_Costing_LDP_New.xls', 'Sourcing_StylePage_QuotationEdit_LDP.xml', 'Sourcing_StylePage_CommitmentEdit_LDP.xml', 'Sourcing_StylePage_Quotation_LDP.xml', 
			'Sourcing_StylePage_QuotationBOMEdit_LDP.xml', 'Sourcing_StylePage_QuotationBOMEditRead_LDP.xml', 'Sourcing_StylePage_CommitmentBOMEdit_LDP.xml'
	FROM pStyleCostingType
	WHERE StyleCostingTypeID = 1
END


IF NOT EXISTS (SELECT * FROM pStyleCostingType WHERE StyleCostingTypeID = 8)
BEGIN
	INSERT INTO pStyleCostingType (StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, StyleCostingTypeRepId, ShowBOM, ShowBOL, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			StyleEnhancedCostingSchema, StyleEnhancedCostingSpreadsheet, StyleEnhancedQuoteSchema, StyleEnhancedCommitmentSchema, StyleEnhancedQuotationPaletteSchema, 
			StyleQuoteDBOMDetailSchema, StyleQuoteDBOMDetailReadSchema, StyleCommitmentDBOMDetailSchema)
	SELECT 8, 'CMP', StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteVariationSchema, 
			StyleQuoteVariationSummarySchema, StyleQuoteTradeSchema, StyleQuoteSchema, StyleQuoteSummarySchema, StyleQuoteVendorSummarySchema, StyleQuoteVendorSchema, 
			Active, StyleSourcingQuoteSchema, NEWID(), 1, 1, 
			StyleCostingCompareSchema, StyleCostingSearchSchema, StyleCostingGridSchema, StyleCostingEditSchema, StyleCostingHeaderSchema, 
			'Style_Costing_CMPUnits.xml', 'Style_Costing_CMP_New.xls', 'Sourcing_StylePage_QuotationEdit_CMP.xml', 'Sourcing_StylePage_CommitmentEdit_CMP.xml', 'Sourcing_StylePage_Quotation_CMP.xml', 
			'Sourcing_StylePage_QuotationBOMEdit_CMP.xml', 'Sourcing_StylePage_QuotationBOMEditRead_CMP.xml', 'Sourcing_StylePage_CommitmentBOMEdit_CMP.xml'
	FROM pStyleCostingType
	WHERE StyleCostingTypeID = 1
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07157', GetDate())
GO
