IF OBJECT_ID(N'[dbo].[vwx_Quote_SharedCommentSummary_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Quote_SharedCommentSummary_SELECT]
GO

CREATE VIEW [dbo].[vwx_Quote_SharedCommentSummary_SELECT]
AS
SELECT (SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(ISNULL(i.ImageID, '00000000-0000-0000-0000-000000000000'), ISNULL(i.Version, '1'), N'200') AS Expr1) AS FilePath, 
       tp.TradePartnerName AS AgentName, tp.TradePartnerID, sqi.StyleQuoteItemID, sqi.StyleQuoteItemNo, sqis.Custom AS QuoteItemStatus, sh.StyleNo, 
       sh.StyleID, sh.Description AS StyleDescription, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName, 
       LOWER(sh.StyleCategory) AS StyleCategory, sqc.StyleQuoteComment AS Comment, sqc.MUser, sqc.MDate, 
	   CASE WHEN EXISTS(SELECT * FROM Users u WHERE u.TeamID = sqc.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn, 
	   sqi.SourcingHeaderID, sqi.TradePartnerVendorID, sdi.StyleDevelopmentID, sqi.StyleSourcingID, 
       sqi.StyleQuoteItemShare, sqi.StyleQuoteItemStatusId
FROM pStyleQuoteItem sqi
INNER JOIN uTradePartner tp ON sqi.TradePartnerID = tp.TradePartnerID 
INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID 
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID 
INNER JOIN pStyleQuoteComment sqc ON sqi.StyleQuoteItemID = sqc.StyleQuoteItemID AND sqc.CommentType = 'S' 
LEFT JOIN pStyleQuoteItemStatus sqis ON sqi.StyleQuoteItemStatusId = sqis.CustomKey 
LEFT JOIN hImage i ON sh.DesignSketchID = i.ImageID AND sh.DesignSketchVersion = i.Version
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09458', GetDate())
GO
