IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerTemplateItemShare_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerTemplateItemShare_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerTemplateItemShare_UPDATE] 
	(@TradePartnerID UNIQUEIDENTIFIER)
AS

INSERT INTO uTradePartnerTemplateItemShare (TradePartnerID, TradePartnerTemplateItemID, PartnerAccessType)
SELECT @TradePartnerID, tpti.TradePartnerTemplateItemID, tpti.PartnerAccessType
FROM uTradePartner tp 
	INNER JOIN uTradePartnerTemplateItem tpti ON tp.TradePartnerTemplateID = tpti.TradePartnerTemplateID
WHERE tp.TradePartnerID = @TradePartnerID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06592', GetDate())
GO
