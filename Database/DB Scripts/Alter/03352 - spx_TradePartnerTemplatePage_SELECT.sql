IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerTemplatePage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerTemplatePage_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerTemplatePage_SELECT] 
(   
	@TradePartnerTemplateID uniqueidentifier
)
AS

BEGIN

SELECT  p.TradePartnerTemplatePageID, p.TradePartnerTemplatePageName, p.TradePartnerTemplatePageURL, t.TradePartnerTemplateItemID FROM  uTradePartnerTemplateItem t INNER JOIN 
        uTradePartnerTemplatePage p ON t.TradePartnerTemplatePageID = p.TradePartnerTemplatePageID WHERE t.TradePartnerTemplateID = @TradePartnerTemplateID
        Order BY t.Sort
       
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03352'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03352', GetDate())

END

GO
