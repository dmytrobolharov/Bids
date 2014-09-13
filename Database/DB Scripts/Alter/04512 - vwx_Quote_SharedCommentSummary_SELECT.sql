IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Quote_SharedCommentSummary_SELECT]'))
DROP VIEW [dbo].[vwx_Quote_SharedCommentSummary_SELECT]
GO


/****** Object:  View [dbo].[vwx_Quote_SharedCommentSummary_SELECT]    Script Date: 11/30/2012 14:32:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Quote_SharedCommentSummary_SELECT]
AS
SELECT     (SELECT     TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(ISNULL(dbo.hImage.ImageID, '00000000-0000-0000-0000-000000000000'), 
                                              ISNULL(dbo.hImage.Version, '1'), N'200') AS Expr1) AS FilePath, dbo.uTradePartner.TradePartnerName AS AgentName, dbo.uTradePartner.TradePartnerID, 
                      dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleQuoteItem.StyleQuoteItemNo, dbo.pStyleQuoteItemStatus.Custom AS QuoteItemStatus, dbo.pStyleHeader.StyleNo, 
                      dbo.pStyleHeader.StyleID, dbo.pStyleHeader.Description AS StyleDescription, dbo.pStyleHeader.SizeClass, 
                      ISNULL(dbo.pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(dbo.pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName, 
                      LOWER(dbo.pStyleHeader.StyleCategory) AS StyleCategory, dbo.pStyleQuoteComment.StyleQuoteComment AS Comment, dbo.pStyleQuoteComment.MUser, 
                      dbo.pStyleQuoteComment.MDate, CASE WHEN EXISTS
                          (SELECT     *
                            FROM          Users u
                            WHERE      u.TeamID = pStyleQuoteComment.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn, dbo.pStyleQuoteItem.SourcingHeaderID, 
                      dbo.pStyleQuoteItem.TradePartnerVendorID, dbo.pStyleDevelopmentItem.StyleDevelopmentID, dbo.pStyleQuoteItem.StyleSourcingID, 
                      dbo.pStyleQuoteItem.StyleQuoteItemShare, dbo.pStyleQuoteItem.StyleQuoteItemStatusId
FROM         dbo.pStyleQuoteItem INNER JOIN
                      dbo.uTradePartner ON dbo.pStyleQuoteItem.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
                      dbo.pStyleHeader ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID INNER JOIN
                      dbo.pStyleQuoteComment ON dbo.pStyleQuoteItem.StyleQuoteItemID = dbo.pStyleQuoteComment.StyleQuoteItemID AND 
                      dbo.pStyleQuoteComment.CommentType = 'S' LEFT OUTER JOIN
                      dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey LEFT OUTER JOIN
                      dbo.hImage ON dbo.pStyleHeader.DesignSketchID = dbo.hImage.ImageID AND dbo.pStyleHeader.DesignSketchVersion = dbo.hImage.Version

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04512', GetDate())
GO 