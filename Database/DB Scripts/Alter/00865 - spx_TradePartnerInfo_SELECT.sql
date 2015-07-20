    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerInfo_SELECT]
GO
    
CREATE PROCEDURE spx_TradePartnerInfo_SELECT
AS  
SELECT TradePartnerID AS TeamID, TradePartnerCode + ' - ' + TradepartnerName AS FullName FROM uTradePartner 
WHERE Active = 1 AND SrmOnAccess = 1 
Order BY TradepartnerName 

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '865', GetDate())

GO
