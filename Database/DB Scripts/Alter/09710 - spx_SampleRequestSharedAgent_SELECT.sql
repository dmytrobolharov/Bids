IF OBJECT_ID(N'[dbo].[spx_SampleRequestSharedAgent_SELECT]') IS NOT NULL
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
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL('/' + tprl.FactoryName,''), 2, 1000) + 
	  ': (' + ISNULL(pStyleColorway.MainColor, 'NA') + ') ' + COALESCE(sc.Custom, sh.SizeClass) AS SampleRequest
FROM dbo.pSampleRequestTrade
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON  dbo.pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
INNER JOIN dbo.pStyleHeader sh ON dbo.pSampleRequestTrade.StyleID = sh.StyleID
LEFT OUTER JOIN dbo.pStyleColorway ON dbo.pSampleRequestTrade.StyleColorID = dbo.pStyleColorway.StyleColorID
LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE 
	dbo.pSampleRequestTrade.StyleID = @StyleId
	AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	AND dbo.pSampleRequestTrade.SampleRequestShare = 1
ORDER BY sh.SizeClass, SampleRequest


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09710', GetDate())
GO
