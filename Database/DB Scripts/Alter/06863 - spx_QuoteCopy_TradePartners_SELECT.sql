IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_QuoteCopy_TradePartners_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_QuoteCopy_TradePartners_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_QuoteCopy_TradePartners_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX)
AS
BEGIN
	DECLARE @SourcingHeaderID UNIQUEIDENTIFIER,
			@StyleID UNIQUEIDENTIFIER;
			
	SELECT @SourcingHeaderID = SourcingHeaderID, @StyleID = StyleID FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID	
	
	SELECT p.*, stp.SourcingTradePartnerID, stp.SourcingHeaderID, stp.TradePartnerLevelID
	INTO #tmpPartners
	FROM pSourcingTradePartner stp
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
	WHERE stp.SourcingHeaderID = @SourcingHeaderID
	--AND stp.SourcingTradePartnerID NOT IN (
	--	SELECT StyleQuoteTradePartnerID FROM pStyleQuoteItem WHERE SourcingHeaderID = @SourcingHeaderID AND StyleID = @StyleID
	--)
	
	EXEC('SELECT * FROM #tmpPartners ' + @SearchCond)
	
	DROP TABLE #tmpPartners
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06863', GetDate())
GO
