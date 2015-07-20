IF OBJECT_ID(N'[dbo].[rpx_Quote_SharedCommentSummary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Quote_SharedCommentSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Quote_SharedCommentSummary_SELECT]
	@TradePartnerID nVARCHAR(MAX)
	, @CUser nVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(ISNULL(hImage.ImageID, '00000000-0000-0000-0000-000000000000'), ISNULL(hImage.Version, '1'), N'200') AS Expr1) AS FilePath
		, SUBSTRING(ISNULL('/' + tpm.AgentName, '') + ISNULL('/' + tpm.VendorName, '') + ISNULL('/' + tpm.FactoryName, ''), 2, 1000) AS AgentName
		, sqi.TradePartnerID
		, sqi.StyleQuoteItemID
		, sqi.StyleQuoteItemNo
		, sqis.Custom AS QuoteItemStatus
		, sh.StyleNo
		, sh.StyleID
		, sh.Description AS StyleDescription
		, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
		, LOWER(sh.StyleCategory) AS StyleCategory
		, sqc.StyleQuoteComment AS Comment
		, sqc.MUser
		, sqc.MDate
		, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = sqc.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
		, sqi.SourcingHeaderID
		, sqi.StyleDevelopmentID
		, sqi.StyleSourcingID
		, CASE
			WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare qis WHERE qis.StyleQouteItemID = sqi.StyleQuoteItemID AND qis.TradePartnerID = tpm.AgentID) THEN 1
			WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare qis WHERE qis.StyleQouteItemID = sqi.StyleQuoteItemID AND qis.TradePartnerID = tpm.VendorID) THEN 1
			WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare qis WHERE qis.StyleQouteItemID = sqi.StyleQuoteItemID AND qis.TradePartnerID = tpm.FactoryID) THEN 1
			ELSE 0
		  END AS StyleQuoteItemShare
		, sqi.StyleQuoteItemStatusId
		, tpm.TradePartnerRelationshipLevelID as RelationshipLevelID
	FROM
		pStyleQuoteItem sqi
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID	
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID
		INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pStyleQuoteComment sqc ON sqi.StyleQuoteItemID = sqc.StyleQuoteItemID AND sqc.CommentType = 'S'
		LEFT OUTER JOIN pStyleQuoteItemStatus sqis ON sqi.StyleQuoteItemStatusId = sqis.CustomKey
		LEFT OUTER JOIN hImage ON sh.DesignSketchID = hImage.ImageID AND sh.DesignSketchVersion = hImage.Version
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
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
		AND sqc.CTeamID IN (SELECT value FROM dbo.fnx_Split(@CUser, ','))
	ORDER BY
		StyleNo
		, AgentName
		, StyleQuoteItemNo DESC
		, MDate DESC
		
	SET NOCOUNT OFF;	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09607', GetDate())
GO
