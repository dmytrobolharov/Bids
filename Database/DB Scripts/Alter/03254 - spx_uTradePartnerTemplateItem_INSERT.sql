IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerTemplateItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [spx_uTradePartnerTemplateItem_INSERT]
(@TradePartnerTemplatePageID uniqueidentifier,
@TradePartnerTemplateID uniqueidentifier,
@Sort int,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)

AS


IF (SELECT  COUNT(TradePartnerTemplatePageID)  FROM  uTradePartnerTemplateItem WITH (NOLOCK) WHERE TradePartnerTemplateID = @TradePartnerTemplateID AND TradePartnerTemplatePageID = @TradePartnerTemplatePageID) = 0 

	BEGIN

   	 INSERT  INTO uTradePartnerTemplateItem(TradePartnerTemplateID, TradePartnerTemplatePageID, Sort, Active, Cuser, CDate, MUser, MDate)
	 VALUES  (@TradePartnerTemplateID, @TradePartnerTemplatePageID, isnull(@Sort,0), 1, @CreatedBy, @CreatedDate,@CreatedBy, @CreatedDate) 

	END

ELSE

	BEGIN

	UPDATE dbo.uTradePartnerTemplateItem SET Sort = isnull(@Sort,0), MUser=@CreatedBy, MDate=@CreatedDate WHERE 
	TradePartnerTemplateID = @TradePartnerTemplateID AND TradePartnerTemplatePageID = @TradePartnerTemplatePageID 

	END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03254'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03254', GetDate())

END
GO