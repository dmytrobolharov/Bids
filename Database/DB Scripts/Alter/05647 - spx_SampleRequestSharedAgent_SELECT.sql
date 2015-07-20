IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSharedAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSharedAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSharedAgent_SELECT]
(
	@StyleId uniqueidentifier
	, @TradePartnerId uniqueidentifier
)
AS

SELECT
	dbo.pSampleRequestTrade.SampleRequestTradeID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL('/' + tprl.FactoryName,''), 2, 1000) + ': (' + ISNULL(pStyleColorway.MainColor, 'NA') + ') ' + pStyleHeader.SizeClass AS SampleRequest
FROM
	dbo.pSampleRequestTrade
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON  dbo.pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN dbo.pStyleHeader ON dbo.pSampleRequestTrade.StyleID = dbo.pStyleHeader.StyleID
	LEFT OUTER JOIN dbo.pStyleColorway ON dbo.pSampleRequestTrade.StyleColorID = dbo.pStyleColorway.StyleColorID
WHERE
	dbo.pSampleRequestTrade.StyleID = @StyleId
	AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	AND dbo.pSampleRequestTrade.SampleRequestShare = 1
ORDER BY
	dbo.pStyleHeader.SizeClass
	, SampleRequest

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05647', GetDate())
GO
