IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TradePartnerTemplateItem_SEL]'))
DROP VIEW [dbo].[vwx_TradePartnerTemplateItem_SEL]
GO

CREATE VIEW [dbo].[vwx_TradePartnerTemplateItem_SEL]
AS
SELECT     dbo.uTradePartnerTemplateItem.TradePartnerTemplateItemID, dbo.uTradePartnerTemplateItem.TradePartnerTemplateID, 
                      dbo.uTradePartnerTemplatePage.TradePartnerTemplatePageID, dbo.uTradePartnerTemplatePage.TradePartnerTemplatePageName, 
                      dbo.uTradePartnerTemplatePage.TradePartnerTemplatePageDesc, dbo.uTradePartnerTemplateItem.CUser, dbo.uTradePartnerTemplateItem.CDate, 
                      dbo.uTradePartnerTemplateItem.MUser, dbo.uTradePartnerTemplateItem.MDate, dbo.uTradePartnerTemplateItem.Active, dbo.uTradePartnerTemplateItem.Sort, 
                      dbo.uTradePartnerTemplateItem.Shared, dbo.uTradePartnerTemplateItem.PartnerAccessType
FROM         dbo.uTradePartnerTemplateItem INNER JOIN
                      dbo.uTradePartnerTemplatePage ON dbo.uTradePartnerTemplateItem.TradePartnerTemplatePageID = dbo.uTradePartnerTemplatePage.TradePartnerTemplatePageID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06591', GetDate())
GO
