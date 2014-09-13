IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerProductType_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerProductType_Add]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_VendorTradePartnerProductType_Add]
(
@StyleCategoryId uniqueidentifier,
@TradePartnerId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
as

IF (SELECT COUNT(StyleCategoryId) FROM uTradePartnerProductType WITH (NOLOCK) 
WHERE StyleCategoryId = @StyleCategoryId AND TradePartnerId = @TradePartnerId ) = 0
	BEGIN
		 INSERT INTO uTradePartnerProductType
        		 (StyleCategoryId, TradePartnerId, Active, Sort,  CUser, CDate, MUser, MDate)
		VALUES (@StyleCategoryId, @TradePartnerId, 1, 0,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03286'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03286', GetDate())

END
GO