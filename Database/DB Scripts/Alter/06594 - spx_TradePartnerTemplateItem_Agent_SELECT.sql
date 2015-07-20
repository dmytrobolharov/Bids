IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerTemplateItem_Agent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerTemplateItem_Agent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerTemplateItem_Agent_SELECT] 
	@TradePartnerTemplateID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER
AS

SELECT  p.TradePartnerTemplatePageID, p.TradePartnerTemplatePageName, p.TradePartnerTemplatePageURL, t.TradePartnerTemplateItemID 
FROM  uTradePartnerTemplateItem t INNER JOIN
	uTradePartnerTemplatePage p ON t.TradePartnerTemplatePageID = p.TradePartnerTemplatePageID INNER JOIN 
	uTradePartnerTemplateItemShare ti ON t.TradePartnerTemplateItemID = ti.TradePartnerTemplateItemID
WHERE t.TradePartnerTemplateID = @TradePartnerTemplateID AND ti.TradePartnerID = @TradePartnerID 
AND ti.PartnerAccessType > 0
ORDER BY t.Sort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06594', GetDate())
GO
