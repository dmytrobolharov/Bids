IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TradePartnerVendorRate_SEL]'))
DROP VIEW [dbo].[vwx_TradePartnerVendorRate_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_TradePartnerVendorRate_SEL]
AS
SELECT     dbo.pTradePartnerVendorRate.TradePartnerVendorRateID, dbo.pTradePartnerVendorRate.TradePartnerVendorID, dbo.pTradePartnerVendorRate.Season, 
                      dbo.pTradePartnerVendorRate.Year, dbo.pTradePartnerVendorRate.CUser, dbo.pTradePartnerVendorRate.CDate, dbo.pTradePartnerVendorRate.MUser, 
                      dbo.pTradePartnerVendorRate.MDate, dbo.pTradePartnerVendorRate.Active, dbo.pTradePartnerVendorRate.ExchangeRate, 
                      dbo.pTradePartnerVendorRate.CurrencyType, dbo.uTradePartnerVendor.VendorName
FROM         dbo.pTradePartnerVendorRate LEFT OUTER JOIN
                      dbo.uTradePartnerVendor ON dbo.pTradePartnerVendorRate.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03815', GetDate())
GO
