IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Commitment_SharedCommentSummary_srmOn_CUser_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_srmOn_CUser_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_srmOn_CUser_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT DISTINCT scc.CTeamID, scc.CUser
	FROM
		pSourcingCommitmentItem sci
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		INNER JOIN pStyleQuoteItemShare sqisa ON sci.StyleQuoteItemID = sqisa.StyleQouteItemID AND sqisa.TradePartnerID = @TradePartnerID
		INNER JOIN pSourcingCommitmentComment scc ON sci.SourcingCommitmentItemID = scc.SourcingCommitmentItemID AND scc.CommentType = 'S'
	ORDER BY scc.CUser
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06810', GetDate())
GO
