/****** Object:  StoredProcedure [dbo].[spx_NPMStyleQuoteItemAgentNew_SELECT]    Script Date: 01/24/2013 15:03:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMStyleQuoteItemAgentNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMStyleQuoteItemAgentNew_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMStyleQuoteItemAgentNew_SELECT]    Script Date: 01/24/2013 15:03:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_NPMStyleQuoteItemAgentNew_SELECT] (
@TradePartnerId UNIQUEIDENTIFIER , 
@Top INT ,
@Total INT OUTPUT 
)
AS 


DECLARE @SQLString nvarchar(4000)
DECLARE @ParmDefinition nvarchar(500)


SELECT @Total = COUNT(*)
FROM pStyleQuoteItem qi WITH (NOLOCK) 
	INNER JOIN pStyleQuoteItemShare qis WITH (NOLOCK) ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND @TradePartnerId = qis.TradePartnerID
	INNER JOIN pStyleHeader sh  WITH (NOLOCK) ON qi.StyleID = sh.StyleID 	
	LEFT JOIN pSourcingTradePartner stp WITH (NOLOCK) ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
WHERE 
	@TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID) AND qis.PartnerView = 0
	

IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 

SET @SQLString = @SQLString + ' qi.StyleQuoteItemID, qi.CDate, sh.StyleID, sh.StyleNo, qi.StyleQuoteItemNo,
        sh.Description, sh.SizeClass, '''' as VendorName, qi.TradePartnerID, 
        '''' as VendorCode
FROM pStyleQuoteItem qi WITH (NOLOCK) 
	INNER JOIN pStyleQuoteItemShare qis WITH (NOLOCK) ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND @pTradePartnerId = qis.TradePartnerID
	INNER JOIN pStyleHeader sh  WITH (NOLOCK) ON qi.StyleID = sh.StyleID 	
	LEFT JOIN pSourcingTradePartner stp WITH (NOLOCK) ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
WHERE 
	@pTradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID) AND qis.PartnerView = 0
ORDER BY qi.CDate DESC'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'
EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04873', GetDate())
GO