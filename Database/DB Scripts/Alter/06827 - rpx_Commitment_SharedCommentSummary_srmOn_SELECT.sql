IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Commitment_SharedCommentSummary_srmOn_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_srmOn_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Commitment_SharedCommentSummary_srmOn_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER
	, @CUserID nVARCHAR(MAX)
	, @CContactID nVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(ISNULL(hImage.ImageID, '00000000-0000-0000-0000-000000000000'), ISNULL(hImage.Version, '1'), N'200') AS Expr1) AS FilePath
		, SUBSTRING(ISNULL('/' + tpm.AgentName, '') + ISNULL('/' + tpm.VendorName, '') + ISNULL('/' + tpm.FactoryName, ''), 2, 1000) AS AgentName
		, sci.TradePartnerID
		, sci.SourcingCommitmentItemID
		, sci.StyleCommitmentNo
		, sqis.Custom AS QuoteItemStatus
		, sh.StyleNo
		, sh.StyleID
		, sh.Description AS StyleDescription
		, sh.SizeClass
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
		, LOWER(sh.StyleCategory) AS StyleCategory
		, scc.SourcingCommitmentComment AS Comment
		, scc.MUser
		, scc.MDate
		, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = scc.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
		, sci.SourcingHeaderID
		, sci.StyleDevelopmentID
		, sci.StyleSourcingID
		, CASE
			WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare qis WHERE qis.StyleQouteItemID = sci.StyleQuoteItemID AND qis.TradePartnerID = tpm.AgentID) THEN 1
			WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare qis WHERE qis.StyleQouteItemID = sci.StyleQuoteItemID AND qis.TradePartnerID = tpm.VendorID) THEN 1
			WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare qis WHERE qis.StyleQouteItemID = sci.StyleQuoteItemID AND qis.TradePartnerID = tpm.FactoryID) THEN 1
			ELSE 0
		  END AS StyleQuoteItemShare
		, sci.StyleQuoteItemStatusId
		, tpm.TradePartnerRelationshipLevelID as RelationshipLevelID
		, sci.StyleQuoteItemID
	FROM
		pSourcingCommitmentItem sci
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID	
		INNER JOIN pStyleQuoteItemShare sqisa ON sci.StyleQuoteItemID = sqisa.StyleQouteItemID AND sqisa.TradePartnerID = @TradePartnerID
		INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID
		INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pSourcingCommitmentComment scc ON sci.SourcingCommitmentItemID = scc.SourcingCommitmentItemID AND scc.CommentType = 'S'
		LEFT OUTER JOIN pStyleQuoteItemStatus sqis ON sci.StyleQuoteItemStatusId = sqis.CustomKey
		LEFT OUTER JOIN hImage ON sh.DesignSketchID = hImage.ImageID AND sh.DesignSketchVersion = hImage.Version
	WHERE --scc.CTeamID = @TradePartnerID
		scc.CTeamID IN (SELECT value FROM dbo.fnx_Split(@CUserID, ','))
		OR scc.CContactID IN (SELECT value FROM dbo.fnx_Split(@CContactID, ','))
	ORDER BY
		StyleNo
		, AgentName
		, StyleQuoteItemNo DESC
		, MDate DESC
		
	SET NOCOUNT OFF;	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06827', GetDate())
GO
