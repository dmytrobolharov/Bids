IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerTemplate_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerTemplate_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_uTradePartnerTemplate_DELETE]
(@TradePartnerTemplateId uniqueidentifier)
AS 

DELETE FROM uTradePartnerTemplateItem
WHERE  (TradePartnerTemplateId = @TradePartnerTemplateId)

DELETE FROM uTradePartnerTemplate
WHERE     (TradePartnerTemplateId = @TradePartnerTemplateId)

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03256'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03256', GetDate())

END
GO