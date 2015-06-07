IF OBJECT_ID(N'[dbo].[spx_StyleQuoteItemAgentNew_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteItemAgentNew_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItemAgentNew_SELECT] (
@TradePartnerId UNIQUEIDENTIFIER , 
@Top INT ,
@Total INT OUTPUT 
)
AS 

DECLARE @SQLString nvarchar(4000)
DECLARE @ParmDefinition nvarchar(500)

SET @SQLString = 'SELECT @pTotal = COUNT(*)
FROM pStyleQuoteItem WITH (NOLOCK) INNER JOIN 
pStyleHeader  WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN 
uTradePartnerVendor  WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE  pStyleQuoteItem.TradePartnerID = @pTradePartnerId
AND pStyleQuoteItem.AgentView = 0
AND pStyleQuoteItem.StyleQuoteItemShare = 1'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'

EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId, 
		@pTotal = @Total OUTPUT


IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 

SET @SQLString = @SQLString + ' pStyleQuoteItem.*, pStyleHeader.StyleID, pStyleHeader.StyleNo, 
        pStyleHeader.Description, COALESCE(sc.Custom, pStyleHeader.SizeClass) AS SizeClass, 
		uTradePartnerVendor.VendorName, uTradePartnerVendor.VendorCode
FROM   pStyleQuoteItem  WITH (NOLOCK) INNER JOIN
pStyleHeader  WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN
uTradePartnerVendor  WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
LEFT JOIN pSizeClass sc ON sc.CustomID = pStyleHeader.SizeClassId
WHERE  pStyleQuoteItem.TradePartnerID = @pTradePartnerId
AND pStyleQuoteItem.AgentView = 0
AND pStyleQuoteItem.StyleQuoteItemShare = 1
ORDER BY pStyleQuoteItem.CDate DESC'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'
EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId


/*
MODIFIED:  July 25, 2008

SELECT     pStyleQuoteItem.StyleQuoteItemID, pStyleQuoteItem.CDate, pStyleHeader.StyleID, pStyleHeader.StyleNo, 
        pStyleHeader.Description, pStyleHeader.SizeClass, uTradePartnerVendor.VendorName, pStyleQuoteItem.TradePartnerID, 
        uTradePartnerVendor.VendorCode
FROM         pStyleQuoteItem WITH (NOLOCK) INNER JOIN
        pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN
        uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE     (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND (pStyleQuoteItem.AgentView = 0) AND (pStyleQuoteItem.StyleQuoteItemShare = 1)  
ORDER BY uTradePartnerVendor.VendorCode, pStyleQuoteItem.CDate

*/



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09818', GetDate())
GO
