IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingStyle_Editor_Quote_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingStyle_Editor_Quote_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingStyle_Editor_Quote_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER
	, @SearchCond NVARCHAR(MAX) = ''
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
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation as VARCHAR(5))) as VariationName
		, sh.Description
		, sh.SizeClass
		, CASE WHEN COUNT(sqbd.SourcingQuotationBOMDetailsID) > 0 THEN 1 ELSE 0 END AS isBOMDetail
		, p.AgentID
		, p.VendorID
		, p.FactoryID
		, sqi.StyleQuoteItemStatusId
	INTO #tmpQuotes
	FROM pStyleQuoteItem sqi
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID 
		LEFT OUTER JOIN pStyleDevelopmentItem sdi ON sqi.StyleID = sdi.StyleID 
		LEFT OUTER JOIN pSourcingQuotationBOMDetails sqbd ON sqi.StyleColorID = sqbd.StyleBOMDimensionID
			AND sqi.StyleQuoteItemID = sqbd.StyleQuoteItemID
			AND sqbd.ItemDim1Active=1
			AND sqbd.ItemDim2Active=1
			AND sqbd.ItemDim3Active=1
	WHERE
		sqi.SourcingHeaderID = @SourcingHeaderID
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
	
	EXEC('SELECT * FROM #tmpQuotes ' + @SearchCond + ' ORDER BY StyleQuoteItemNo DESC ' )
	
	DROP TABLE #tmpQuotes
   
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05741', GetDate())
GO

