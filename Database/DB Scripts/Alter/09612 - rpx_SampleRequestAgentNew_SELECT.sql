IF OBJECT_ID(N'[dbo].[rpx_SampleRequestAgentNew_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_SampleRequestAgentNew_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestAgentNew_SELECT]
(@TradePartnerId nvarchar(50) )
AS 

SELECT dbo.pSampleRequestTrade.SampleRequestTradeID, dbo.pSampleRequestTrade.CDate, sh.StyleID, sh.StyleNo, 
    sh.Description, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, dbo.uTradePartnerVendor.VendorName, 
	dbo.pSampleRequestTrade.TradePartnerID, dbo.uTradePartnerVendor.VendorCode
FROM dbo.pStyleHeader sh 
INNER JOIN dbo.pSampleRequestTrade ON sh.StyleID = dbo.pSampleRequestTrade.StyleID 
INNER JOIN dbo.uTradePartnerVendor ON dbo.pSampleRequestTrade.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE (pSampleRequestTrade.TradePartnerID = @TradePartnerId) AND (pSampleRequestTrade.AgentView = 0) AND (pSampleRequestTrade.SampleRequestShare = 1)
ORDER BY uTradePartnerVendor.VendorCode, pSampleRequestTrade.CDate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09612', GetDate())
GO
