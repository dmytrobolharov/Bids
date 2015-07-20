IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_UPDATE](
@TradePartnerTemplateItemID uniqueidentifier,
@CreatedBy nvarchar(50),
@Sort nvarchar(50),
@CreatedDate nvarchar(50))
AS 
UPDATE    uTradePartnerTemplateItem
SET  CUser = @CreatedBy, CDate = @CreatedDate, MUser = @CreatedBy, MDate = @CreatedDate, 
Sort = @Sort WHERE     (TradePartnerTemplateItemID = @TradePartnerTemplateItemID)
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03255'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03255', GetDate())

END
GO