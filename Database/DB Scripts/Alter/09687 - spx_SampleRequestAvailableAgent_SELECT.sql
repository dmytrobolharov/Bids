IF OBJECT_ID(N'[dbo].[spx_SampleRequestAvailableAgent_SELECT]') IS NOT NULL
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
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL('/' + tprl.FactoryName,''), 2, 1000) + 
	 ': (' + ISNULL(pStyleColorway.MainColor, 'NA') + ') ' + COALESCE(sc.Custom, sh.SizeClass) AS SampleRequest
FROM 
	pSampleRequestTrade
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON  dbo.pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN pStyleHeader sh ON pSampleRequestTrade.StyleID = sh.StyleID
	LEFT OUTER JOIN pStyleColorway ON pSampleRequestTrade.StyleColorID = pStyleColorway.StyleColorID
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE
	sh.StyleID = @StyleId
	AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	AND pSampleRequestTrade.SampleRequestShare = 0
ORDER BY COALESCE(sc.Custom, sh.SizeClass), SampleRequest


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09687', GetDate())
GO
