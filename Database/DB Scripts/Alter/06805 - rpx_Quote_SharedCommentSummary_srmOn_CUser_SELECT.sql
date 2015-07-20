IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Quote_SharedCommentSummary_srmOn_CUser_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Quote_SharedCommentSummary_srmOn_CUser_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Quote_SharedCommentSummary_srmOn_CUser_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT DISTINCT sqc.CTeamID, sqc.CUser
	FROM
		pStyleQuoteItem sqi
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		INNER JOIN pStyleQuoteItemShare sqisa ON sqi.StyleQuoteItemID = sqisa.StyleQouteItemID AND sqisa.TradePartnerID = @TradePartnerID
		INNER JOIN pStyleQuoteComment sqc ON sqi.StyleQuoteItemID = sqc.StyleQuoteItemID AND sqc.CommentType = 'S'
	ORDER BY sqc.CUser
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06805', GetDate())
GO