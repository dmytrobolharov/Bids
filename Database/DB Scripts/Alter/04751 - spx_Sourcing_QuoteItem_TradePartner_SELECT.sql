/****** Object:  StoredProcedure [dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]    Script Date: 01/11/2013 18:27:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]    Script Date: 01/11/2013 18:27:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @SourcingHeaderID UNIQUEIDENTIFIER,
			@SourcingTradePartnerID UNIQUEIDENTIFIER;
			
	SELECT @SourcingHeaderID = SourcingHeaderID, @SourcingTradePartnerID = StyleQuoteTradePartnerID 
	FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

	SELECT * FROM pSourcingTradePartner stp
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
	WHERE stp.SourcingTradePartnerID = @SourcingTradePartnerID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04751', GetDate())
GO
