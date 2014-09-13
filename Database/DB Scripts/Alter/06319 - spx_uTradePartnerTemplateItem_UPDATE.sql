IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_uTradePartnerTemplateItem_UPDATE] (
	@TradePartnerTemplateItemID UNIQUEIDENTIFIER
	, @CreatedBy NVARCHAR(50)
	, @Sort NVARCHAR(50)
	, @Shared BIT = 1
	, @CreatedDate NVARCHAR(50)
	)
AS
UPDATE uTradePartnerTemplateItem
SET MUser = @CreatedBy
	, MDate = @CreatedDate
	, Sort = @Sort
	, Shared = @Shared
WHERE (TradePartnerTemplateItemID = @TradePartnerTemplateItemID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06319', GetDate())
GO
