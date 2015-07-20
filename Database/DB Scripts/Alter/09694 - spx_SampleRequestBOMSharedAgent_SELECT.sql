IF OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSharedAgent_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestBOMSharedAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMSharedAgent_SELECT]
(
	@StyleId uniqueidentifier
	, @TradePartnerId uniqueidentifier
)
AS

SELECT
	dbo.pSampleRequestBOMTrade.SampleRequestTradeID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL('/' + tprl.FactoryName,''), 2, 1000) + 
	  ': (' + ISNULL(dbo.pStyleColorway.StyleColorName, 'NA') + ') ' + COALESCE(sc.Custom, sh.SizeClass) AS SampleRequest
FROM
	dbo.pSampleRequestBOMTrade
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON  dbo.pSampleRequestBOMTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN dbo.pStyleHeader sh ON dbo.pSampleRequestBOMTrade.StyleID = sh.StyleID
	LEFT OUTER JOIN dbo.pStyleColorway ON dbo.pSampleRequestBOMTrade.ItemDim1Id = dbo.pStyleColorway.StyleColorID
		OR dbo.pSampleRequestBOMTrade.ItemDim2Id = dbo.pStyleColorway.StyleColorID
		OR dbo.pSampleRequestBOMTrade.ItemDim3Id = dbo.pStyleColorway.StyleColorID
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE
	dbo.pSampleRequestBOMTrade.StyleID = @StyleId
	AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	AND dbo.pSampleRequestBOMTrade.SampleRequestShare = 1
ORDER BY COALESCE(sc.Custom, sh.SizeClass), SampleRequest
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09694', GetDate())
GO
