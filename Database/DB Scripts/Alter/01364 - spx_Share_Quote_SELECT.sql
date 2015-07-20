IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Share_Quote_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Share_Quote_SELECT]
GO


CREATE PROCEDURE  dbo.spx_Share_Quote_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS

    SELECT  '<img src="../System/Icons/icon_quote.gif" />' AS IconPath,
		b.StyleNo + ' (' + b.SizeClass + ') ' +  b.Description AS Style,
		a.StyleQuoteItemID, a.CDate, a.TradePartnerID,  b.StyleID, b.StyleNo,  b.Description, b.SizeClass, b.DevelopmentId
	FROM pStyleQuoteItem a WITH(NOLOCK) 
		INNER JOIN pStyleHeader b WITH(NOLOCK)  ON a.StyleID = b.StyleID
	WHERE a.TradePartnerID = @TradePartnerID  
		AND a.StyleQuoteItemShare = 1 
	ORDER BY a.CDate 
	

  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01364', GetDate())
GO

    