IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartner_Agent_AccessType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartner_Agent_AccessType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TradePartner_Agent_AccessType_SELECT] 
	@TradePartnerTemplateItemID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER
AS

SELECT ISNULL(PartnerAccessType, 0) AS PartnerAccessType FROM 
	uTradePartnerTemplateItemShare
WHERE TradePartnerTemplateItemID = @TradePartnerTemplateItemID AND TradePartnerID = @TradePartnerID 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06590', GetDate())
GO
