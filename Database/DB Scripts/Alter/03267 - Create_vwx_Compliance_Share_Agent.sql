IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Compliance_Share_Agent]'))
DROP VIEW [dbo].[vwx_Compliance_Share_Agent]
GO


CREATE VIEW [dbo].[vwx_Compliance_Share_Agent]
AS
SELECT  Distinct TOP (100) PERCENT  dbo.uTradePartner.TradePartnerID ,dbo.uTradePartner.TradePartnerCode,dbo.uTradePartner.TradePartnerName,
			dbo.uTradePartner.Country,dbo.uTradePartner.Active AS TradePartnerActive
FROM         dbo.uTradePartner 
WHERE     (dbo.uTradePartner.Active = 1)
ORDER BY dbo.uTradePartner.TradePartnerName


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03267'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03267', GetDate())
END