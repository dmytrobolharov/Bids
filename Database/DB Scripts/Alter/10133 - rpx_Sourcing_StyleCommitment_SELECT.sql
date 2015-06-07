IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Sourcing_StyleCommitment_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Sourcing_StyleCommitment_SELECT]
GO

Create PROCEDURE [dbo].[rpx_Sourcing_StyleCommitment_SELECT]
	@SourcingHeaderID nvarchar(50) = NULL
AS
BEGIN
	CREATE TABLE #CommitmentTMP (
		StyleID UNIQUEIDENTIFIER
		, StyleNo NVARCHAR(20)
		, StyleVariationNo INT
		, StyleVariation NVARCHAR(100)
		, StyleDescription NVARCHAR(100)
		, StyleCategoryID UNIQUEIDENTIFIER
		, StyleCategoryName NVARCHAR(255)
		, SizeClass NVARCHAR(255)
		, StyleDesignImage NVARCHAR(800)
		, StyleCommitmentItemNo INT
		, StyleCommitmentItemStatusID INT
		, StyleCommitmentItemStatus NVARCHAR(200)
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
		, StyleCommitmentItemID UNIQUEIDENTIFIER
		, StyleQuoteItemID UNIQUEIDENTIFIER
	)

	INSERT INTO #CommitmentTMP (
		StyleID
		, StyleNo
		, StyleVariationNo
		, StyleVariation
		, StyleDescription
		, StyleCategoryID
		, StyleCategoryName
		, SizeClass
		, StyleDesignImage
		, StyleCommitmentItemNo
		, StyleCommitmentItemStatusID
		, StyleCommitmentItemStatus
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
		, StyleCommitmentItemID
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
			, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion, 2000) AS ImagePath
			, sci.StyleCommitmentNo
			, sci.StyleQuoteItemStatusId
			, sqis.Custom AS StyleQuoteItemStatus
			, tpm.AgentName
			, tpm.VendorName
			, tpm.FactoryName
			, sci.StyleQuoteItemCustomField16 AS TotalUnits
			, (SELECT SUM(ISNULL(PartnerTotal, '0.00')) AS PartnerCost
			   FROM dbo.pSourcingCommitmentBOMDetails
			   WHERE (SourcingCommitmentItemID = sci.SourcingCommitmentItemID))
			AS PartnerExtendedFOB
			, (SELECT SUM(ISNULL(PartnerTotal, '0.00')) AS PartnerCost
			   FROM dbo.pSourcingQuotationBOMDetails AS pSourcingQuotationBOMDetails_1
			   WHERE (SourcingCommitmentItemID = sci.SourcingCommitmentItemID))
			   + ISNULL(sci.StyleQuoteItemCustomField8, '0.00'
			   + ISNULL(sci.StyleQuoteItemCustomField10, '0.00')
			   + ISNULL(sci.StyleQuoteItemCustomField12, '0.00') 
			   + ISNULL(sci.StyleQuoteItemCustomField13, '0.00'))
			   + ISNULL((SELECT SUM(ISNULL(Amount, '0.00')) AS TotalAmount
						 FROM dbo.pSourcingAdditionalCost
						 WHERE (SourcingCommitmentItemID = sci.SourcingCommitmentItemID)), '0.00')
			AS PartnerExtendedLDP
			, sci.StyleQuoteItemCustomField2 AS WhosaleUnits
			, sci.StyleCostingCustomField15 AS WhosalePricePerUnit
			, (sci.StyleQuoteItemCustomField2 * sci.StyleCostingCustomField15) AS WholesaleExtendedTotal
			, sci.StyleQuoteItemCustomField6 AS RetailUnits
			, sci.StyleCostingCustomField16 AS RetailPricePerUnit
			, (sci.StyleQuoteItemCustomField6 * sci.StyleCostingCustomField16) AS RetailExtendedTotal
			, (SELECT COUNT(*) FROM pStyleQuoteItemShare qsh WHERE qsh.StyleQouteItemID = sci.StyleQuoteItemID AND qsh.TradePartnerID = tpm.AgentID) AS AgentShared
			, (SELECT COUNT(*) FROM pStyleQuoteItemShare qsh WHERE qsh.StyleQouteItemID = sci.StyleQuoteItemID AND qsh.TradePartnerID = tpm.VendorID) AS VendorShared
			, (SELECT COUNT(*) FROM pStyleQuoteItemShare qsh WHERE qsh.StyleQouteItemID = sci.StyleQuoteItemID AND qsh.TradePartnerID = tpm.FactoryID) AS FactoryShared
			, sci.SourcingHeaderID
			, sci.TradePartnerID
			, sci.StyleSourcingID
			, sci.TradePartnerVendorID
			, sci.StyleDevelopmentID
			, sci.SourcingCommitmentItemID
			, sci.StyleQuoteItemID			
		FROM
			pSourcingCommitmentItem sci
			INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID
			INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
			INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
			INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sci.StyleQuoteItemStatusId
			INNER JOIN pStyleCategory sc ON sc.StyleCategoryId = sh.StyleCategory
			INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = sh.StyleID
	where sci.SourcingHeaderID=@SourcingHeaderID
	
	UPDATE #CommitmentTMP SET LDPPerUnit = CASE WHEN TotalUnits>0 THEN PartnerExtendedLDP/TotalUnits ELSE 0 END
	UPDATE #CommitmentTMP SET
		WholesaleMarginPercent = CASE WHEN WholesalePricePerUnit>0 THEN (WholesalePricePerUnit-LDPPerUnit)/WholesalePricePerUnit ELSE 0 END
		, RetailMarginPercent = CASE WHEN RetailPricePerUnit>0 THEN (RetailPricePerUnit-LDPPerUnit)/RetailPricePerUnit ELSE 0 END
		, Revenue = WholesaleExtendedTotal + RetailExtendedTotal
		, GrossProfit = WholesaleExtendedTotal + RetailExtendedTotal - PartnerExtendedLDP
		, GrossProfitPercent = CASE WHEN (WholesaleExtendedTotal + RetailExtendedTotal)>0 THEN (WholesaleExtendedTotal + RetailExtendedTotal - PartnerExtendedLDP)/(WholesaleExtendedTotal + RetailExtendedTotal) ELSE 0 END

	UPDATE #CommitmentTMP SET IsLowestGrossMargin = CASE WHEN GrossProfitPercent = (SELECT MIN(GrossProfitPercent) FROM #CommitmentTMP inQtmp WHERE inQtmp.StyleID = StyleID AND inQtmp.StyleVariationNo = StyleVariationNo) THEN 1 ELSE 0 END


	
	SELECT * FROM #CommitmentTMP

	DROP TABLE #CommitmentTMP
END





GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10133', GetUTCDate())
GO