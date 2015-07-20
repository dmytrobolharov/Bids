/****** Object:  StoredProcedure [dbo].[spx_SampleRequestHistory_SELECT]    Script Date: 05/21/2013 14:05:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestHistory_SELECT]    Script Date: 05/21/2013 14:05:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestHistory_SELECT]
(@TeamId uniqueidentifier)
AS

/* 
SELECT     pSampleRequestTrade.SampleRequestTradeID, pStyleHeader.StyleID, pStyleHeader.StyleNo, pStyleHeader.Description, hSampleHistory.CDate, 
                      uTradePartnerVendor.VendorCode
FROM         pSampleRequestTrade WITH (NOLOCK) INNER JOIN
                      pStyleHeader WITH (NOLOCK) ON pSampleRequestTrade.StyleID = pStyleHeader.StyleID INNER JOIN
                      hSampleHistory WITH (NOLOCK) ON pSampleRequestTrade.SampleRequestTradeID = hSampleHistory.SampleRequestTradeId INNER JOIN
                      uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestTrade.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE pSampleRequestTrade.StyleId IN (SELECT StyleId FROM hSampleHistory WITH (NOLOCK) WHERE TeamID = @TeamID) 
ORDER BY hSampleHistory.CDate DESC
*/

/*
select  a.SampleRequestTradeID , a.StyleID , b.StyleNo , b.Description , a.CDate,  d.VendorCode
FROM hSampleHistory a WITH (NOLOCK)  INNER JOIN pStyleHeader b WITH (NOLOCK) ON  a.StyleID = b.StyleID  
INNER JOIN pSampleRequestTrade c WITH (NOLOCK) ON c.SampleRequestTradeID   = a.SampleRequestTradeID 
INNER JOIN   uTradePartnerVendor d WITH (NOLOCK) ON  d.TradePartnerVendorID = c.TradePartnerVendorID
WHERE  TeamID = @TeamId
ORDER BY a.CDate DESC
*/

select  a.SampleRequestTradeID , a.StyleID ,  d.StyleNo ,  d.Description , a.CDate,   c.VendorCode
FROM hSampleHistory  a WITH (NOLOCK) , pSampleRequestTrade b WITH (NOLOCK) ,  uTradePartnerVendor c WITH (NOLOCK)  , pStyleHeader d WITH (NOLOCK) 
where a.TeamID =  @TeamId
AND a.SampleRequestTradeID = b.SampleRequestTradeID 
AND b.TradepartnerVendorID  =  c.TradePartnerVendorID 
AND c.TradePartnerID = a.TeamID 
AND d.StyleID = a.StyleID 
UNION
select  a.SampleRequestTradeID , a.StyleID ,  d.StyleNo ,  d.Description , a.CDate,   c.VendorCode
FROM hSampleHistory  a WITH (NOLOCK) , pSampleRequestBOMTrade b WITH (NOLOCK) ,  uTradePartnerVendor c WITH (NOLOCK)  , pStyleHeader d WITH (NOLOCK) 
where a.TeamID =  @TeamId
AND a.SampleRequestTradeID = b.SampleRequestTradeID 
AND b.TradepartnerVendorID  =  c.TradePartnerVendorID 
AND c.TradePartnerID = a.TeamID 
AND d.StyleID = a.StyleID 

ORDER BY a.CDate DESC

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05707', GetDate())
GO
