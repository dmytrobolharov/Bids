IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Quote_SharedCommentSummary_SELECT]'))
DROP VIEW [dbo].[vwx_Quote_SharedCommentSummary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_Quote_SharedCommentSummary_SELECT]
AS
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(ISNULL(hImage.ImageID,'00000000-0000-0000-0000-000000000000'), ISNULL(hImage.[Version],'1'), '200')) AS FilePath
	, uTradePartner.TradePartnerName AS AgentName
	, uTradePartner.TradePartnerID
	, pStyleQuoteItem.StyleQuoteItemID
	, pStyleQuoteItem.StyleQuoteItemNo
	, pStyleQuoteItemStatus.Custom as QuoteItemStatus
	, pStyleHeader.StyleNo
	, pStyleHeader.StyleID
	, pStyleHeader.Description AS StyleDescription
	, pStyleHeader.SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName
	, LOWER(pStyleHeader.StyleCategory) AS StyleCategory
	, pStyleQuoteComment.StyleQuoteComment AS Comment
	, pStyleQuoteComment.MUser
	, pStyleQuoteComment.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pStyleQuoteComment.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
FROM
	pStyleQuoteItem
	INNER JOIN uTradePartner ON pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID
	INNER JOIN pStyleHeader ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID
	INNER JOIN pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	INNER JOIN pStyleQuoteComment ON pStyleQuoteItem.StyleQuoteItemID = pStyleQuoteComment.StyleQuoteItemID
		AND pStyleQuoteComment.CommentType = 'S'
	LEFT JOIN pStyleQuoteItemStatus ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey
	LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID
		AND pStyleHeader.DesignSketchVersion = hImage.Version

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04504', GetDate())
GO
