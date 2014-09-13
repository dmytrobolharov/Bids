IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartner_Style_Quote_Editor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartner_Style_Quote_Editor_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TradePartner_Style_Quote_Editor_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	SELECT DISTINCT
		sqi.StyleQuoteItemID
		, sqi.StyleSourcingID
		, sqi.SourcingHeaderID
		, sqi.StyleQuoteItemNo
		, p.AgentName
		, p.VendorName
		, p.FactoryName
		, sh.StyleNo
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation as nVARCHAR(5))) as VariationName
		, sh.Description
		, sh.SizeClass
		, CASE WHEN COUNT(sqbd.SourcingQuotationBOMDetailsID) > 0 THEN 1 ELSE 0 END AS isBOMDetail
		, p.AgentID
		, p.VendorID
		, p.FactoryID
		, sqi.StyleQuoteItemStatusId
		, soh.seasonYearId
		, ISNULL(soh.Season + ' ','') + ISNULL(soh.Year, '') as SeasonYear
	INTO #tmpQuotes
	FROM pStyleQuoteItem sqi
		INNER JOIN pStyleQuoteItemShare sqis ON sqi.StyleQuoteItemID = sqis.StyleQouteItemID AND sqis.TradePartnerID = @TradePartnerID
		INNER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID 
		LEFT OUTER JOIN pStyleDevelopmentItem sdi ON sqi.StyleID = sdi.StyleID 
		LEFT OUTER JOIN pStyleBOMDimension sbd ON sqi.StyleColorID = sbd.StyleBOMDimensionID
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqbd ON sbd.StyleBOMDimensionID = sqbd.StyleBOMDimensionID
			AND sqi.StyleQuoteItemID = sqbd.StyleQuoteItemID
			AND sqbd.ItemDim1Active=1
			AND sqbd.ItemDim2Active=1
			AND sqbd.ItemDim3Active=1
	WHERE @TradePartnerID IN (p.AgentID, p.VendorID, p.FactoryID)
	GROUP BY
		sqi.StyleQuoteItemID
		, sqi.StyleSourcingID
		, sqi.SourcingHeaderID
		, sqi.StyleQuoteItemNo
		, p.AgentName
		, p.VendorName
		, p.FactoryName
		, sh.StyleNo
		, sdi.StyleDevelopmentName
		, sdi.Variation
		, sh.Description
		, sh.SizeClass
		, p.AgentID
		, p.VendorID
		, p.FactoryID			
		, sqi.StyleQuoteItemStatusId
		, soh.seasonYearId
		, soh.Season
		, soh.Year
	
	EXEC('SELECT * FROM #tmpQuotes ' + @SearchCond + ' order by StyleQuoteItemNo desc ' )
	
	DROP TABLE #tmpQuotes
   
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06750', GetDate())
GO
