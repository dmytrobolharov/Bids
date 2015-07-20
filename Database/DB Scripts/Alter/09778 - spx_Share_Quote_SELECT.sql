IF OBJECT_ID(N'[dbo].[spx_Share_Quote_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_Share_Quote_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_Share_Quote_SELECT](
	@TradePartnerID UNIQUEIDENTIFIER
)
AS

    SELECT  '<img src="../System/Icons/icon_quote.gif" />' AS IconPath,
		b.StyleNo + ' (' + COALESCE(sc.Custom, b.SizeClass) + ') ' +  b.Description AS Style,
		a.StyleQuoteItemID, a.CDate, a.TradePartnerID,  b.StyleID, b.StyleNo,  b.Description, 
		COALESCE(sc.Custom, b.SizeClass) AS SizeClass, b.DevelopmentId
	FROM pStyleQuoteItem a WITH(NOLOCK) 
		INNER JOIN pStyleHeader b WITH(NOLOCK)  ON a.StyleID = b.StyleID
		LEFT JOIN pSizeClass sc ON sc.Custom = b.SizeClass
	WHERE a.TradePartnerID = @TradePartnerID  
		AND a.StyleQuoteItemShare = 1 
	ORDER BY a.CDate 

 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09778', GetDate())
GO
