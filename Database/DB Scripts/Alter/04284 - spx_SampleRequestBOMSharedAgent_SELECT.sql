IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSharedAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSharedAgent_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMSharedAgent_SELECT](
@StyleId uniqueidentifier,
@TradePartnerId uniqueidentifier)
AS

SELECT     dbo.pSampleRequestBOMTrade.SampleRequestTradeID, dbo.uTradePartnerVendor.VendorName + ': (' + ISNULL(dbo.pColorPalette.ColorName, 'NA') 
					  + ') ' + dbo.pStyleHeader.SizeClass AS SampleRequest
FROM         dbo.pSampleRequestBOMTrade WITH (NOLOCK) INNER JOIN
					  dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestBOMTrade.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
					  dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestBOMTrade.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
					  dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestBOMTrade.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
					  dbo.pColorPalette WITH (NOLOCK) ON dbo.pSampleRequestBOMTrade.ItemDim1Id = dbo.pColorPalette.ColorPaletteID OR dbo.pSampleRequestBOMTrade.ItemDim2Id = dbo.pColorPalette.ColorPaletteID OR dbo.pSampleRequestBOMTrade.ItemDim3Id = dbo.pColorPalette.ColorPaletteID
WHERE     (dbo.pSampleRequestBOMTrade.StyleID = @StyleId) AND (dbo.pSampleRequestBOMTrade.TradePartnerID = @TradePartnerId) AND 
					  (dbo.pSampleRequestBOMTrade.SampleRequestShare = 1)
ORDER BY dbo.pStyleHeader.SizeClass, dbo.uTradePartnerVendor.VendorName
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04284', GetDate())
GO
