/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemPartners_REPLACE]    Script Date: 01/21/2013 17:32:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemPartners_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemPartners_REPLACE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemPartners_REPLACE]    Script Date: 01/21/2013 17:32:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleQuoteItemPartners_REPLACE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@TradePartnerIDChain VARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL
        
    -- add partners relation to the database        
	exec spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT		
	
    declare @SourcingTradePartnerID UNIQUEIDENTIFIER,
			@SourcingHeaderID UNIQUEIDENTIFIER = (SELECT SourcingHeaderID FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID)
    SELECT 
		@SourcingTradePartnerID = SourcingTradePartnerID
    FROM pSourcingTradePartner stp
    LEFT JOIN pStyleQuoteItem qi ON qi.SourcingHeaderID = stp.SourcingHeaderID
    WHERE qi.StyleQuoteItemID = @StyleQuoteItemID AND stp.TradePartnerLevelID = @TradePartnerRelationshipLevelID
    
    -- add partners relation to the sourcing
    if @SourcingTradePartnerID IS NULL
    begin
		declare @TradePartnerID UNIQUEIDENTIFIER = (SELECT TOP 1 value FROM dbo.fnx_Split(@TradePartnerIDChain, ',') ORDER BY position DESC)
		exec spx_Sourcing_TradePartner_INSERT @SourcingHeaderID, @TradePartnerID, @TradePartnerRelationshipLevelID		
		
		SELECT @SourcingTradePartnerID = SourcingTradePartnerID
		FROM pSourcingTradePartner stp
		LEFT JOIN pStyleQuoteItem qi ON qi.SourcingHeaderID = stp.SourcingHeaderID
		WHERE qi.StyleQuoteItemID = @StyleQuoteItemID AND stp.TradePartnerLevelID = @TradePartnerRelationshipLevelID
    end
    
    UPDATE pStyleQuoteItem SET StyleQuoteTradePartnerID = @SourcingTradePartnerID WHERE StyleQuoteItemID = @StyleQuoteItemID
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04816', GetDate())
GO
