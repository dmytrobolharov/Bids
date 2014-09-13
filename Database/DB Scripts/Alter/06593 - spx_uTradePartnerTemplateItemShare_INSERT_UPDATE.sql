IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerTemplateItemShare_INSERT_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerTemplateItemShare_INSERT_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_uTradePartnerTemplateItemShare_INSERT_UPDATE]
	@TradePartnerID UNIQUEIDENTIFIER
	, @TradePartnerTemplateItemID UNIQUEIDENTIFIER
	, @AccessType INT
AS

IF EXISTS (SELECT * FROM uTradePartnerTemplateItemShare WHERE TradePartnerID=@TradePartnerID AND TradePartnerTemplateItemID=@TradePartnerTemplateItemID)
	UPDATE uTradePartnerTemplateItemShare SET PartnerAccessType=@AccessType WHERE TradePartnerID=@TradePartnerID AND TradePartnerTemplateItemID=@TradePartnerTemplateItemID
ELSE
	INSERT INTO uTradePartnerTemplateItemShare (TradePartnerID, TradePartnerTemplateItemID, PartnerAccessType)
	VALUES (@TradePartnerID, @TradePartnerTemplateItemID, @AccessType)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06593', GetDate())
GO
