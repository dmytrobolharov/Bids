IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_Agent_SELECT]'))
DROP VIEW [dbo].[vwx_BatchQ_Agent_SELECT]
GO

CREATE VIEW [dbo].[vwx_BatchQ_Agent_SELECT]
AS
SELECT TOP (100) PERCENT TradePartnerID, TradePartnerCode, TradePartnerName,
	Active AS TradePartnerActive, Country
FROM dbo.uTradePartner
WHERE Active = 1 AND SrmOnAccess = 1
ORDER BY TradePartnerName

  

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06916', GetDate())
GO
