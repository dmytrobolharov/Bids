IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMAvailableAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMAvailableAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMAvailableAgent_SELECT]
(
	@StyleId uniqueidentifier
	, @TradePartnerId uniqueidentifier
)
AS

SELECT
	dbo.pSampleRequestBOMTrade.SampleRequestTradeID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL('/' + tprl.FactoryName,''), 2, 1000) + ': (' + ISNULL(dbo.pColorPalette.ColorName, 'NA') + ') ' + dbo.pStyleHeader.SizeClass AS SampleRequest
FROM
	dbo.pSampleRequestBOMTrade
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON  dbo.pSampleRequestBOMTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN dbo.pStyleHeader ON dbo.pSampleRequestBOMTrade.StyleID = dbo.pStyleHeader.StyleID
	LEFT OUTER JOIN dbo.pColorPalette ON dbo.pSampleRequestBOMTrade.ItemDim1Id = dbo.pColorPalette.ColorPaletteID
		OR dbo.pSampleRequestBOMTrade.ItemDim2Id = dbo.pColorPalette.ColorPaletteID
		OR dbo.pSampleRequestBOMTrade.ItemDim3Id = dbo.pColorPalette.ColorPaletteID
WHERE
	dbo.pSampleRequestBOMTrade.StyleID = @StyleId
	AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	AND dbo.pSampleRequestBOMTrade.SampleRequestShare = 0
ORDER BY
	dbo.pStyleHeader.SizeClass
	, SampleRequest
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05644', GetDate())
GO
