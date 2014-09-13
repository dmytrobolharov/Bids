

/****** Object:  StoredProcedure [dbo].[rpx_Sourcing_StyleQuote_SELECT]    Script Date: 03/04/2013 13:46:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Sourcing_StyleQuote_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Sourcing_StyleQuote_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[rpx_Sourcing_StyleQuote_SELECT]    Script Date: 03/04/2013 13:46:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[rpx_Sourcing_StyleQuote_SELECT]
	@SourcingHeaderID nvarchar(50) = NULL
	
AS
BEGIN
	CREATE TABLE #QuoteTMP (
		StyleID UNIQUEIDENTIFIER
		, StyleNo NVARCHAR(20)
		, StyleVariationNo INT
		, StyleVariation NVARCHAR(100)
		, StyleDescription NVARCHAR(100)
		, StyleCategoryID UNIQUEIDENTIFIER
		, StyleCategoryName NVARCHAR(255)
		, SizeClass NVARCHAR(255)
		, StyleDesignImage NVARCHAR(800)
		, StyleQuoteItemNo INT
		, StyleQuoteItemStatusID INT
		, StyleQuoteItemStatus NVARCHAR(200)
		, AgentName NVARCHAR(200)
		, VendorName NVARCHAR(200)
		, FactoryName NVARCHAR(200)
		, TotalUnits INT
		, PartnerExtendedFOB DECIMAL(18,3)
		, PartnerExtendedLDP DECIMAL(18,3)
		, LDPPerUnit DECIMAL(18,3)
		, WholesaleUnits INT
		, WholesalePricePerUnit DECIMAL(18,3)
		, WholesaleExtendedTotal DECIMAL(18,3)
		, WholesaleMarginPercent DECIMAL(18,3)
		, RetailUnits INT
		, RetailPricePerUnit DECIMAL(18,3)
		, RetailExtendedTotal DECIMAL(18,3)
		, RetailMarginPercent DECIMAL(18,3)
		, Revenue DECIMAL(18,3)
		, GrossProfit DECIMAL(18,3)
		, GrossProfitPercent DECIMAL(18,3)
		, IsLowestGrossMargin BIT
		, IsSharedWithAgent BIT
		, IsSharedWithVendor BIT
		, IsSharedWithFactory BIT
		, SourcingFolderID UNIQUEIDENTIFIER
		, TradePartnerID UNIQUEIDENTIFIER
		, StyleSourcingID UNIQUEIDENTIFIER
		, TradePartnerVendorID UNIQUEIDENTIFIER
		, StyleDevelopmentID UNIQUEIDENTIFIER
		, StyleQuoteItemID UNIQUEIDENTIFIER
	)

	INSERT INTO #QuoteTMP (
		StyleID
		, StyleNo
		, StyleVariationNo
		, StyleVariation
		, StyleDescription
		, StyleCategoryID
		, StyleCategoryName
		, SizeClass
		, StyleDesignImage
		, StyleQuoteItemNo
		, StyleQuoteItemStatusID
		, StyleQuoteItemStatus
		, AgentName
		, VendorName
		, FactoryName
		, TotalUnits
		, PartnerExtendedFOB
		, PartnerExtendedLDP
		, WholesaleUnits
		, WholesalePricePerUnit
		, WholesaleExtendedTotal
		, RetailUnits
		, RetailPricePerUnit
		, RetailExtendedTotal
		, IsSharedWithAgent
		, IsSharedWithVendor
		, IsSharedWithFactory
		, SourcingFolderID
		, TradePartnerID
		, StyleSourcingID
		, TradePartnerVendorID
		, StyleDevelopmentID
		, StyleQuoteItemID
	)
		SELECT
			sh.StyleID
			, sh.StyleNo
			, sdi.Variation
			, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation as NVARCHAR(1))) as StyleVariation
			, sh.Description
			, sh.StyleCategory
			, sc.StyleCategory as StyleCategoryName
			, sh.SizeClass
			, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS ImagePath
			, sqi.StyleQuoteItemNo
			, sqi.StyleQuoteItemStatusId
			, sqis.Custom AS StyleQuoteItemStatus
			, tpm.AgentName
			, tpm.VendorName
			, tpm.FactoryName
			, sqi.StyleQuoteItemCustomField16 AS TotalUnits
			, (SELECT SUM(ISNULL(PartnerTotal, '0.00')) AS PartnerCost
			   FROM dbo.pSourcingQuotationBOMDetails
			   WHERE (StyleQuoteItemID = sqi.StyleQuoteItemID))
			AS PartnerExtendedFOB
			, (SELECT SUM(ISNULL(PartnerTotal, '0.00')) AS PartnerCost
			   FROM dbo.pSourcingQuotationBOMDetails AS pSourcingQuotationBOMDetails_1
			   WHERE (StyleQuoteItemID = sqi.StyleQuoteItemID))
			   + ISNULL(sqi.StyleQuoteItemCustomField8, '0.00'
			   + ISNULL(sqi.StyleQuoteItemCustomField10, '0.00')
			   + ISNULL(sqi.StyleQuoteItemCustomField12, '0.00') 
			   + ISNULL(sqi.StyleQuoteItemCustomField13, '0.00'))
			   + ISNULL((SELECT SUM(ISNULL(Amount, '0.00')) AS TotalAmount
						 FROM dbo.pSourcingAdditionalCost
						 WHERE (QuoteItemID = sqi.StyleQuoteItemID)), '0.00')
			AS PartnerExtendedLDP
			, sqi.StyleQuoteItemCustomField2 AS WhosaleUnits
			, sqi.StyleCostingCustomField15 AS WhosalePricePerUnit
			, (sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField15) AS WholesaleExtendedTotal
			, sqi.StyleQuoteItemCustomField6 AS RetailUnits
			, sqi.StyleCostingCustomField16 AS RetailPricePerUnit
			, (sqi.StyleQuoteItemCustomField6 * sqi.StyleCostingCustomField16) AS RetailExtendedTotal
			, (SELECT COUNT(*) FROM pStyleQuoteItemShare qsh WHERE qsh.StyleQouteItemID = sqi.StyleQuoteItemID AND qsh.TradePartnerID = tpm.AgentID) AS AgentShared
			, (SELECT COUNT(*) FROM pStyleQuoteItemShare qsh WHERE qsh.StyleQouteItemID = sqi.StyleQuoteItemID AND qsh.TradePartnerID = tpm.VendorID) AS VendorShared
			, (SELECT COUNT(*) FROM pStyleQuoteItemShare qsh WHERE qsh.StyleQouteItemID = sqi.StyleQuoteItemID AND qsh.TradePartnerID = tpm.FactoryID) AS FactoryShared
			, sqi.SourcingHeaderID
			, sqi.TradePartnerID
			, sqi.StyleSourcingID
			, sqi.TradePartnerVendorID
			, sqi.StyleDevelopmentID
			, sqi.StyleQuoteItemID			
		FROM
			pStyleQuoteItem sqi
			INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID
			INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
			INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
			INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId
			INNER JOIN pStyleCategory sc ON sc.StyleCategoryId = sh.StyleCategory
			INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = sh.StyleID
	   where sqi.SourcingHeaderID=@SourcingHeaderID
	   
	UPDATE #QuoteTMP SET LDPPerUnit = CASE WHEN TotalUnits>0 THEN PartnerExtendedLDP/TotalUnits ELSE 0 END
	UPDATE #QuoteTMP SET
		WholesaleMarginPercent = CASE WHEN WholesalePricePerUnit>0 THEN (WholesalePricePerUnit-LDPPerUnit)/WholesalePricePerUnit ELSE 0 END
		, RetailMarginPercent = CASE WHEN RetailPricePerUnit>0 THEN (RetailPricePerUnit-LDPPerUnit)/RetailPricePerUnit ELSE 0 END
		, Revenue = WholesaleExtendedTotal + RetailExtendedTotal
		, GrossProfit = WholesaleExtendedTotal + RetailExtendedTotal - PartnerExtendedLDP
		, GrossProfitPercent = CASE WHEN (WholesaleExtendedTotal + RetailExtendedTotal)>0 THEN (WholesaleExtendedTotal + RetailExtendedTotal - PartnerExtendedLDP)/(WholesaleExtendedTotal + RetailExtendedTotal) ELSE 0 END

	UPDATE #QuoteTMP SET IsLowestGrossMargin = CASE WHEN GrossProfitPercent = (SELECT MIN(GrossProfitPercent) FROM #QuoteTMP inQtmp WHERE inQtmp.StyleID = StyleID AND inQtmp.StyleVariationNo = StyleVariationNo) THEN 1 ELSE 0 END


	
	SELECT * FROM #QuoteTMP

	DROP TABLE #QuoteTMP
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05233', GetDate())
GO
