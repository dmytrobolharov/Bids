IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ShareStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ShareStatus_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ShareStatus_SELECT]
(
	@QuoteItemID uniqueidentifier,
	@TradePartnerID uniqueidentifier
)
AS
BEGIN
	SELECT COUNT(*) FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID AND TradePartnerId = @TradePartnerID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04808', GetDate())
GO
