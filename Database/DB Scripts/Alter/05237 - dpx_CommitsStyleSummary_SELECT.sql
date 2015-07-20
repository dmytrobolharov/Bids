IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_CommitsStyleSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_CommitsStyleSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_CommitsStyleSummary_SELECT]
	@StyleID UNIQUEIDENTIFIER
	, @CommitStatusID INT = NULL
AS
BEGIN
IF @CommitStatusID IS NULL
	SELECT
		sci.StyleCommitmentNo
		, sci.StyleQuoteItemStatusId
		, sqis.Custom AS StyleQuoteItemStatus
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, CASE WHEN tpm.VendorCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isVendorComplianceFailed
		, CASE WHEN tpm.FactoryCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isFactoryComplianceFailed
		, sci.StyleQuoteItemCustomField16 AS TotalUnits
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0)) AS PartnerExtendedFOB
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0))
		   + ISNULL(sci.StyleQuoteItemCustomField8, 0 )
		   + ISNULL(sci.StyleQuoteItemCustomField10, 0)
		   + ISNULL(sci.StyleQuoteItemCustomField12, 0) 
		   + ISNULL(sci.StyleQuoteItemCustomField13, 0)
		   + SUM(ISNULL(Amount, 0))
		AS PartnerExtendedLDP
		, CASE WHEN sci.StyleQuoteItemCustomField16>0 THEN
			(SUM(ISNULL(sqBOMd.PartnerTotal, 0))
			+ ISNULL(sci.StyleQuoteItemCustomField8, 0 )
			+ ISNULL(sci.StyleQuoteItemCustomField10, 0)
			+ ISNULL(sci.StyleQuoteItemCustomField12, 0) 
			+ ISNULL(sci.StyleQuoteItemCustomField13, 0)
			+ SUM(ISNULL(Amount, 0)))/sci.StyleQuoteItemCustomField16
			ELSE 0 END
		AS AvgUnitCost
		, sci.StyleQuoteItemCustomField3 AS VendorMin
		, sci.StyleQuoteItemDueDate
		, soh.SourcingName
		, COUNT(qsha.StyleQouteItemID) AS AgentShared
		, COUNT(qshv.StyleQouteItemID) AS VendorShared
		, COUNT(qshf.StyleQouteItemID) AS FactoryShared
		, sci.SourcingHeaderID
		, sci.TradePartnerID
		, sci.StyleSourcingID
		, sci.TradePartnerVendorID
		, sci.StyleDevelopmentID
		, sci.StyleQuoteItemID
		, sh.StyleID
		, sci.SourcingCommitmentItemID
	FROM
		pSourcingCommitmentItem sci
		INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationShipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sci.StyleQuoteItemStatusId
		INNER JOIN pStyleQuoteItem sqi ON sci.StyleQuoteItemID = sqi.StyleQuoteItemID
		LEFT OUTER JOIN pStyleQuoteItemShare qsha ON sqi.StyleQuoteItemID = qsha.StyleQouteItemID AND tpm.AgentID = qsha.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshv ON sqi.StyleQuoteItemID = qshv.StyleQouteItemID AND tpm.VendorID = qshv.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshf ON sqi.StyleQuoteItemID = qshf.StyleQouteItemID AND tpm.FactoryID = qshf.TradePartnerID
		LEFT OUTER JOIN pSourcingAdditionalCost sac ON sci.StyleQuoteItemID = sac.QuoteItemID
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqBOMd ON sci.StyleQuoteItemID = sqBOMd.StyleQuoteItemID
		LEFT OUTER JOIN pSourcingHeader soh ON sci.SourcingHeaderID = soh.SourcingHeaderID
	WHERE sh.StyleID = @StyleID
	GROUP BY
		sh.StyleID
		, sci.StyleCommitmentNo
		, sci.StyleQuoteItemStatusId
		, sqis.Custom
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, sci.StyleQuoteItemCustomField16
		, sci.SourcingHeaderID
		, sci.TradePartnerID
		, sci.StyleSourcingID
		, sci.TradePartnerVendorID
		, sci.StyleDevelopmentID
		, sci.StyleQuoteItemID
		, sci.StyleQuoteItemCustomField8
		, sci.StyleQuoteItemCustomField10
		, sci.StyleQuoteItemCustomField12
		, sci.StyleQuoteItemCustomField13
		, sci.StyleQuoteItemDueDate
		, sci.StyleQuoteItemCustomField3
		, soh.SourcingName
		, tpm.VendorCStatusID
		, tpm.FactoryCStatusID
		, sci.SourcingCommitmentItemID
ELSE
	SELECT
		sci.StyleCommitmentNo
		, sci.StyleQuoteItemStatusId
		, sqis.Custom AS StyleQuoteItemStatus
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, CASE WHEN tpm.VendorCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isVendorComplianceFailed
		, CASE WHEN tpm.FactoryCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isFactoryComplianceFailed
		, sci.StyleQuoteItemCustomField16 AS TotalUnits
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0)) AS PartnerExtendedFOB
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0))
		   + ISNULL(sci.StyleQuoteItemCustomField8, 0 )
		   + ISNULL(sci.StyleQuoteItemCustomField10, 0)
		   + ISNULL(sci.StyleQuoteItemCustomField12, 0) 
		   + ISNULL(sci.StyleQuoteItemCustomField13, 0)
		   + SUM(ISNULL(Amount, 0))
		AS PartnerExtendedLDP
		, CASE WHEN sci.StyleQuoteItemCustomField16>0 THEN
			(SUM(ISNULL(sqBOMd.PartnerTotal, 0))
			+ ISNULL(sci.StyleQuoteItemCustomField8, 0 )
			+ ISNULL(sci.StyleQuoteItemCustomField10, 0)
			+ ISNULL(sci.StyleQuoteItemCustomField12, 0) 
			+ ISNULL(sci.StyleQuoteItemCustomField13, 0)
			+ SUM(ISNULL(Amount, 0)))/sci.StyleQuoteItemCustomField16
			ELSE 0 END
		AS AvgUnitCost
		, sci.StyleQuoteItemCustomField3 AS VendorMin
		, sci.StyleQuoteItemDueDate
		, soh.SourcingName
		, COUNT(qsha.StyleQouteItemID) AS AgentShared
		, COUNT(qshv.StyleQouteItemID) AS VendorShared
		, COUNT(qshf.StyleQouteItemID) AS FactoryShared
		, sci.SourcingHeaderID
		, sci.TradePartnerID
		, sci.StyleSourcingID
		, sci.TradePartnerVendorID
		, sci.StyleDevelopmentID
		, sci.StyleQuoteItemID
		, sh.StyleID
		, sci.SourcingCommitmentItemID
	FROM
		pSourcingCommitmentItem sci
		INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationShipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sci.StyleQuoteItemStatusId
		INNER JOIN pStyleQuoteItem sqi ON sci.StyleQuoteItemID = sqi.StyleQuoteItemID
		LEFT OUTER JOIN pStyleQuoteItemShare qsha ON sqi.StyleQuoteItemID = qsha.StyleQouteItemID AND tpm.AgentID = qsha.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshv ON sqi.StyleQuoteItemID = qshv.StyleQouteItemID AND tpm.VendorID = qshv.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshf ON sqi.StyleQuoteItemID = qshf.StyleQouteItemID AND tpm.FactoryID = qshf.TradePartnerID
		LEFT OUTER JOIN pSourcingAdditionalCost sac ON sci.StyleQuoteItemID = sac.QuoteItemID
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqBOMd ON sci.StyleQuoteItemID = sqBOMd.StyleQuoteItemID
		LEFT OUTER JOIN pSourcingHeader soh ON sci.SourcingHeaderID = soh.SourcingHeaderID
	WHERE sh.StyleID = @StyleID AND sci.StyleQuoteItemStatusId = @CommitStatusID
	GROUP BY
		sh.StyleID
		, sci.StyleCommitmentNo
		, sci.StyleQuoteItemStatusId
		, sqis.Custom
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, sci.StyleQuoteItemCustomField16
		, sci.SourcingHeaderID
		, sci.TradePartnerID
		, sci.StyleSourcingID
		, sci.TradePartnerVendorID
		, sci.StyleDevelopmentID
		, sci.StyleQuoteItemID
		, sci.StyleQuoteItemCustomField8
		, sci.StyleQuoteItemCustomField10
		, sci.StyleQuoteItemCustomField12
		, sci.StyleQuoteItemCustomField13
		, sci.StyleQuoteItemDueDate
		, sci.StyleQuoteItemCustomField3
		, soh.SourcingName
		, tpm.VendorCStatusID
		, tpm.FactoryCStatusID
		, sci.SourcingCommitmentItemID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05237', GetDate())
GO
