IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestAvailableAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestAvailableAgent_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_SampleRequestAvailableAgent_SELECT]
(
	@StyleId uniqueidentifier
	, @TradePartnerId uniqueidentifier
)
AS 

SELECT
	pSampleRequestTrade.SampleRequestTradeID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL('/' + tprl.FactoryName,''), 2, 1000) + ': (' + ISNULL(pStyleColorway.MainColor, 'NA') + ') ' + pStyleHeader.SizeClass AS SampleRequest
FROM 
	pSampleRequestTrade
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON  dbo.pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN pStyleHeader ON pSampleRequestTrade.StyleID = pStyleHeader.StyleID
	LEFT OUTER JOIN pStyleColorway ON pSampleRequestTrade.StyleColorID = pStyleColorway.StyleColorID
WHERE
	pStyleHeader.StyleID = @StyleId
	AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	AND pSampleRequestTrade.SampleRequestShare = 0
ORDER BY
	pStyleHeader.SizeClass
	, SampleRequest

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05645', GetDate())
GO
