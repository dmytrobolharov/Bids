IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Commitment_SharedCommentSummary_srmOn_CContact_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_srmOn_CContact_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_srmOn_CContact_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT DISTINCT	scc.CContactID, ISNULL(ISNULL(tpc.FirstName, '') + ISNULL(tpc.LastName, ''),'NONAME') AS ContactName
	FROM
		pSourcingCommitmentItem sci
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		INNER JOIN pStyleQuoteItemShare sqisa ON sci.StyleQuoteItemID = sqisa.StyleQouteItemID AND sqisa.TradePartnerID = @TradePartnerID
		INNER JOIN pSourcingCommitmentComment scc ON sci.SourcingCommitmentItemID = scc.SourcingCommitmentItemID AND scc.CommentType = 'S'
		LEFT JOIN uTradePartnerContact tpc ON scc.CContactID = tpc.TradePartnerContactID
	WHERE scc.CContactID IS NOT NULL
	ORDER BY ISNULL(ISNULL(tpc.FirstName, '') + ISNULL(tpc.LastName, ''),'NONAME')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06809', GetDate())
GO
