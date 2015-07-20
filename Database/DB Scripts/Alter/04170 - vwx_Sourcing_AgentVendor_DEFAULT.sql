

/****** Object:  View [dbo].[vwx_Sourcing_AgentVendor_DEFAULT]    Script Date: 10/12/2012 15:45:17 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_AgentVendor_DEFAULT]'))
DROP VIEW [dbo].[vwx_Sourcing_AgentVendor_DEFAULT]
GO


/****** Object:  View [dbo].[vwx_Sourcing_AgentVendor_DEFAULT]    Script Date: 10/12/2012 15:45:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_Sourcing_AgentVendor_DEFAULT]
AS
SELECT     dbo.uTradePartnerVendor.TradePartnerVendorID, dbo.uTradePartner.TradePartnerID, dbo.pSourcingAgentVendor.SourcingTradePartnerID, dbo.pSourcingAgentVendor.SourcingHeaderID,  dbo.uTradePartner.TradePartnerCode, 
                      dbo.uTradePartner.TradePartnerName, dbo.uTradePartnerVendor.VendorCode, dbo.uTradePartnerVendor.VendorName, 
                      dbo.uTradePartner.Active AS TradePartnerActive, dbo.uTradePartnerVendor.Active AS TradePartnerVendorActive
FROM   dbo.pSourcingAgentVendor inner JOIN 
dbo.uTradePartnerVendor on pSourcingAgentVendor.TradePartnerVendorID=uTradePartnerVendor.TradePartnerVendorID
INNER JOIN
dbo.uTradePartner ON dbo.uTradePartner.TradePartnerID = dbo.uTradePartnerVendor.TradePartnerID
WHERE     (dbo.uTradePartner.Active = 1)
--ORDER BY dbo.uTradePartner.TradePartnerName



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04170', GetDate())
GO