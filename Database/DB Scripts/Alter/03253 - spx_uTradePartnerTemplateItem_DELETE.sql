IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerTemplateItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_DELETE]
(@TradePartnerTemplatePageID uniqueidentifier,
@TradePartnerTemplateID uniqueidentifier)
AS 
DELETE FROM uTradePartnerTemplateItem
WHERE  (TradePartnerTemplatePageID = @TradePartnerTemplatePageID) AND (TradePartnerTemplateID = @TradePartnerTemplateID)

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03253'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03253', GetDate())

END
GO