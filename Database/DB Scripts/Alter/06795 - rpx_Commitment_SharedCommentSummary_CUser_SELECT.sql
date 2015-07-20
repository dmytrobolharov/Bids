IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Commitment_SharedCommentSummary_CUser_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_CUser_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_CUser_SELECT]
	@TradePartnerID nVARCHAR(MAX)
AS
BEGIN
	SELECT DISTINCT scc.CTeamID, scc.CUser
	FROM
		pSourcingCommitmentItem sci
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		INNER JOIN pSourcingCommitmentComment scc ON sci.SourcingCommitmentItemID = scc.SourcingCommitmentItemID AND scc.CommentType = 'S'
	WHERE
		stp.TradePartnerLevelID IN (
			SELECT
				TradePartnerRelationshipLevelID
			FROM
				vwx_TradePartnerRelationshipLevels_SEL tpl
			WHERE
				tpl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
				OR tpl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
				OR tpl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 
		)
	ORDER BY scc.CUser
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06795', GetDate())
GO