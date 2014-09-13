IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_AgentVendor_DEFAULT]'))
DROP VIEW [dbo].[vwx_Sourcing_AgentVendor_DEFAULT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*ORDER BY dbo.uTradePartner.TradePartnerName*/
CREATE VIEW [dbo].[vwx_Sourcing_AgentVendor_DEFAULT]
AS
SELECT     dbo.uTradePartnerVendor.TradePartnerVendorID, dbo.uTradePartner.TradePartnerID, dbo.pSourcingAgentVendor.SourcingTradePartnerID, 
                      dbo.pSourcingAgentVendor.SourcingHeaderID, dbo.uTradePartner.TradePartnerCode, dbo.uTradePartner.TradePartnerName, dbo.uTradePartnerVendor.VendorCode, 
                      dbo.uTradePartnerVendor.VendorName, dbo.uTradePartner.Active AS TradePartnerActive, dbo.uTradePartnerVendor.Active AS TradePartnerVendorActive, 
                      dbo.pStyleQuoteItem.StyleSourcingID
FROM         dbo.pSourcingAgentVendor INNER JOIN
                      dbo.uTradePartnerVendor ON dbo.pSourcingAgentVendor.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
                      dbo.uTradePartner ON dbo.uTradePartner.TradePartnerID = dbo.uTradePartnerVendor.TradePartnerID LEFT OUTER JOIN
                      dbo.pStyleQuoteItem ON dbo.uTradePartnerVendor.TradePartnerVendorID = dbo.pStyleQuoteItem.TradePartnerVendorID AND 
                      dbo.pSourcingAgentVendor.SourcingHeaderID = dbo.pStyleQuoteItem.SourcingHeaderID
WHERE     (dbo.uTradePartner.Active = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04195', GetDate())
GO
