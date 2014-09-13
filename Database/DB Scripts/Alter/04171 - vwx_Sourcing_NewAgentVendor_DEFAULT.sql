

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_NewAgentVendor_DEFAULT]'))
DROP VIEW [dbo].[vwx_Sourcing_NewAgentVendor_DEFAULT]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Sourcing_NewAgentVendor_DEFAULT]
AS
SELECT     TOP (100) PERCENT dbo.uTradePartnerVendor.TradePartnerVendorID, dbo.uTradePartner.TradePartnerID, dbo.uTradePartner.TradePartnerCode, 
                      dbo.uTradePartner.TradePartnerName, dbo.uTradePartnerVendor.VendorCode, dbo.uTradePartnerVendor.VendorName, 
                      dbo.uTradePartner.Active AS TradePartnerActive, dbo.uTradePartnerVendor.Active AS TradePartnerVendorActive
FROM         dbo.uTradePartner INNER JOIN
                      dbo.uTradePartnerVendor ON dbo.uTradePartner.TradePartnerID = dbo.uTradePartnerVendor.TradePartnerID
WHERE     (dbo.uTradePartner.Active = 1)
ORDER BY dbo.uTradePartner.TradePartnerName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04171', GetDate())
GO