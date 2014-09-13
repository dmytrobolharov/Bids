IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteStyleSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteStyleSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteStyleSummary_SELECT]
	@StyleID UNIQUEIDENTIFIER
	, @QuoteStatusID INT = NULL
AS
BEGIN
IF @QuoteStatusID IS NULL
	SELECT
		sqi.StyleQuoteItemNo
		, sqi.StyleQuoteItemStatusId
		, sqis.Custom AS StyleQuoteItemStatus
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, CASE WHEN tpm.VendorCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isVendorComplianceFailed
		, CASE WHEN tpm.FactoryCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isFactoryComplianceFailed
		, sqi.StyleQuoteItemCustomField16 AS TotalUnits
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0)) AS PartnerExtendedFOB
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0))
		   + ISNULL(sqi.StyleQuoteItemCustomField8, 0 )
		   + ISNULL(sqi.StyleQuoteItemCustomField10, 0)
		   + ISNULL(sqi.StyleQuoteItemCustomField12, 0) 
		   + ISNULL(sqi.StyleQuoteItemCustomField13, 0)
		   + SUM(ISNULL(Amount, 0))
		AS PartnerExtendedLDP
		, CASE WHEN sqi.StyleQuoteItemCustomField16>0 THEN
			(SUM(ISNULL(sqBOMd.PartnerTotal, 0))
			+ ISNULL(sqi.StyleQuoteItemCustomField8, 0 )
			+ ISNULL(sqi.StyleQuoteItemCustomField10, 0)
			+ ISNULL(sqi.StyleQuoteItemCustomField12, 0) 
			+ ISNULL(sqi.StyleQuoteItemCustomField13, 0)
			+ SUM(ISNULL(Amount, 0)))/sqi.StyleQuoteItemCustomField16
			ELSE 0 END
		AS AvgUnitCost
		, sqi.StyleQuoteItemCustomField3 AS VendorMin
		, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
		, sqi.StyleQuoteItemDueDate
		, soh.SourcingName
		, COUNT(qsha.StyleQouteItemID) AS AgentShared
		, COUNT(qshv.StyleQouteItemID) AS VendorShared
		, COUNT(qshf.StyleQouteItemID) AS FactoryShared
		, sqi.SourcingHeaderID
		, sqi.TradePartnerID
		, sqi.StyleSourcingID
		, sqi.TradePartnerVendorID
		, sqi.StyleDevelopmentID
		, sqi.StyleQuoteItemID
		, sh.StyleID
	FROM
		pStyleQuoteItem sqi
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationShipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqBOMd ON sqi.StyleQuoteItemID = sqBOMd.StyleQuoteItemID
		LEFT OUTER JOIN pStyleQuoteItemShare qsha ON sqi.StyleQuoteItemID = qsha.StyleQouteItemID AND tpm.AgentID = qsha.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshv ON sqi.StyleQuoteItemID = qshv.StyleQouteItemID AND tpm.VendorID = qshv.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshf ON sqi.StyleQuoteItemID = qshf.StyleQouteItemID AND tpm.FactoryID = qshf.TradePartnerID
		LEFT OUTER JOIN pSourcingAdditionalCost sac ON sqi.StyleQuoteItemID = sac.QuoteItemID
		LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
		LEFT OUTER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
	WHERE sh.StyleID = @StyleID
	GROUP BY
		sh.StyleID
		, sqi.StyleQuoteItemNo
		, sqi.StyleQuoteItemStatusId
		, sqis.Custom
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, sqi.StyleQuoteItemCustomField16
		, sqi.SourcingHeaderID
		, sqi.TradePartnerID
		, sqi.StyleSourcingID
		, sqi.TradePartnerVendorID
		, sqi.StyleDevelopmentID
		, sqi.StyleQuoteItemID
		, sqi.StyleQuoteItemCustomField8
		, sqi.StyleQuoteItemCustomField10
		, sqi.StyleQuoteItemCustomField12
		, sqi.StyleQuoteItemCustomField13
		, sqi.StyleQuoteItemDueDate
		, sqi.StyleQuoteItemCustomField3
		, soh.SourcingName
		, tpm.VendorCStatusID
		, tpm.FactoryCStatusID
ELSE IF @QuoteStatusID = 200
	SELECT
		sqi.StyleQuoteItemNo
		, sqi.StyleQuoteItemStatusId
		, sqis.Custom AS StyleQuoteItemStatus
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, CASE WHEN tpm.VendorCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isVendorComplianceFailed
		, CASE WHEN tpm.FactoryCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isFactoryComplianceFailed		, sqi.StyleQuoteItemCustomField16 AS TotalUnits
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0)) AS PartnerExtendedFOB
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0))
		   + ISNULL(sqi.StyleQuoteItemCustomField8, 0 )
		   + ISNULL(sqi.StyleQuoteItemCustomField10, 0)
		   + ISNULL(sqi.StyleQuoteItemCustomField12, 0) 
		   + ISNULL(sqi.StyleQuoteItemCustomField13, 0)
		   + SUM(ISNULL(Amount, 0))
		AS PartnerExtendedLDP
		, CASE WHEN sqi.StyleQuoteItemCustomField16>0 THEN
			(SUM(ISNULL(sqBOMd.PartnerTotal, 0))
			+ ISNULL(sqi.StyleQuoteItemCustomField8, 0 )
			+ ISNULL(sqi.StyleQuoteItemCustomField10, 0)
			+ ISNULL(sqi.StyleQuoteItemCustomField12, 0) 
			+ ISNULL(sqi.StyleQuoteItemCustomField13, 0)
			+ SUM(ISNULL(Amount, 0)))/sqi.StyleQuoteItemCustomField16
			ELSE 0 END
		AS AvgUnitCost
		, sqi.StyleQuoteItemCustomField3 AS VendorMin
		, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
		, sqi.StyleQuoteItemDueDate
		, soh.SourcingName
		, COUNT(qsha.StyleQouteItemID) AS AgentShared
		, COUNT(qshv.StyleQouteItemID) AS VendorShared
		, COUNT(qshf.StyleQouteItemID) AS FactoryShared
		, sqi.SourcingHeaderID
		, sqi.TradePartnerID
		, sqi.StyleSourcingID
		, sqi.TradePartnerVendorID
		, sqi.StyleDevelopmentID
		, sqi.StyleQuoteItemID
		, sh.StyleID
	FROM
		pStyleQuoteItem sqi
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationShipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqBOMd ON sqi.StyleQuoteItemID = sqBOMd.StyleQuoteItemID
		LEFT OUTER JOIN pStyleQuoteItemShare qsha ON sqi.StyleQuoteItemID = qsha.StyleQouteItemID AND tpm.AgentID = qsha.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshv ON sqi.StyleQuoteItemID = qshv.StyleQouteItemID AND tpm.VendorID = qshv.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshf ON sqi.StyleQuoteItemID = qshf.StyleQouteItemID AND tpm.FactoryID = qshf.TradePartnerID
		LEFT OUTER JOIN pSourcingAdditionalCost sac ON sqi.StyleQuoteItemID = sac.QuoteItemID
		INNER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
		LEFT OUTER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
	WHERE sh.StyleID = @StyleID
	GROUP BY
		sh.StyleID
		, sqi.StyleQuoteItemNo
		, sqi.StyleQuoteItemStatusId
		, sqis.Custom
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, sqi.StyleQuoteItemCustomField16
		, sqi.SourcingHeaderID
		, sqi.TradePartnerID
		, sqi.StyleSourcingID
		, sqi.TradePartnerVendorID
		, sqi.StyleDevelopmentID
		, sqi.StyleQuoteItemID
		, sqi.StyleQuoteItemCustomField8
		, sqi.StyleQuoteItemCustomField10
		, sqi.StyleQuoteItemCustomField12
		, sqi.StyleQuoteItemCustomField13
		, sqi.StyleQuoteItemDueDate
		, sqi.StyleQuoteItemCustomField3
		, soh.SourcingName
		, tpm.VendorCStatusID
		, tpm.FactoryCStatusID
ELSE
	SELECT
		sqi.StyleQuoteItemNo
		, sqi.StyleQuoteItemStatusId
		, sqis.Custom AS StyleQuoteItemStatus
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, CASE WHEN tpm.VendorCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isVendorComplianceFailed
		, CASE WHEN tpm.FactoryCStatusID = '00000000-0000-0000-0000-000000000001' THEN 1 ELSE 0 END AS isFactoryComplianceFailed
		, sqi.StyleQuoteItemCustomField16 AS TotalUnits
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0)) AS PartnerExtendedFOB
		, SUM(ISNULL(sqBOMd.PartnerTotal, 0))
		   + ISNULL(sqi.StyleQuoteItemCustomField8, 0 )
		   + ISNULL(sqi.StyleQuoteItemCustomField10, 0)
		   + ISNULL(sqi.StyleQuoteItemCustomField12, 0) 
		   + ISNULL(sqi.StyleQuoteItemCustomField13, 0)
		   + SUM(ISNULL(Amount, 0))
		AS PartnerExtendedLDP
		, CASE WHEN sqi.StyleQuoteItemCustomField16>0 THEN
			(SUM(ISNULL(sqBOMd.PartnerTotal, 0))
			+ ISNULL(sqi.StyleQuoteItemCustomField8, 0 )
			+ ISNULL(sqi.StyleQuoteItemCustomField10, 0)
			+ ISNULL(sqi.StyleQuoteItemCustomField12, 0) 
			+ ISNULL(sqi.StyleQuoteItemCustomField13, 0)
			+ SUM(ISNULL(Amount, 0)))/sqi.StyleQuoteItemCustomField16
			ELSE 0 END
		AS AvgUnitCost
		, sqi.StyleQuoteItemCustomField3 AS VendorMin
		, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
		, sqi.StyleQuoteItemDueDate
		, soh.SourcingName
		, COUNT(qsha.StyleQouteItemID) AS AgentShared
		, COUNT(qshv.StyleQouteItemID) AS VendorShared
		, COUNT(qshf.StyleQouteItemID) AS FactoryShared
		, sqi.SourcingHeaderID
		, sqi.TradePartnerID
		, sqi.StyleSourcingID
		, sqi.TradePartnerVendorID
		, sqi.StyleDevelopmentID
		, sqi.StyleQuoteItemID
		, sh.StyleID
	FROM
		pStyleQuoteItem sqi
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationShipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqBOMd ON sqi.StyleQuoteItemID = sqBOMd.StyleQuoteItemID
		LEFT OUTER JOIN pStyleQuoteItemShare qsha ON sqi.StyleQuoteItemID = qsha.StyleQouteItemID AND tpm.AgentID = qsha.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshv ON sqi.StyleQuoteItemID = qshv.StyleQouteItemID AND tpm.VendorID = qshv.TradePartnerID
		LEFT OUTER JOIN pStyleQuoteItemShare qshf ON sqi.StyleQuoteItemID = qshf.StyleQouteItemID AND tpm.FactoryID = qshf.TradePartnerID
		LEFT OUTER JOIN pSourcingAdditionalCost sac ON sqi.StyleQuoteItemID = sac.QuoteItemID
		LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
		LEFT OUTER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
	WHERE sh.StyleID = @StyleID AND sqi.StyleQuoteItemStatusId = @QuoteStatusID
	GROUP BY
		sh.StyleID
		, sqi.StyleQuoteItemNo
		, sqi.StyleQuoteItemStatusId
		, sqis.Custom
		, tpm.AgentName
		, tpm.VendorName
		, tpm.FactoryName
		, sqi.StyleQuoteItemCustomField16
		, sqi.SourcingHeaderID
		, sqi.TradePartnerID
		, sqi.StyleSourcingID
		, sqi.TradePartnerVendorID
		, sqi.StyleDevelopmentID
		, sqi.StyleQuoteItemID
		, sqi.StyleQuoteItemCustomField8
		, sqi.StyleQuoteItemCustomField10
		, sqi.StyleQuoteItemCustomField12
		, sqi.StyleQuoteItemCustomField13
		, sqi.StyleQuoteItemDueDate
		, sqi.StyleQuoteItemCustomField3
		, soh.SourcingName
		, tpm.VendorCStatusID
		, tpm.FactoryCStatusID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05162', GetDate())
GO
