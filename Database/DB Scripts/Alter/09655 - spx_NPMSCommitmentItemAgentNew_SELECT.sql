IF OBJECT_ID(N'[dbo].[spx_NPMSCommitmentItemAgentNew_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_NPMSCommitmentItemAgentNew_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSCommitmentItemAgentNew_SELECT] (
@TradePartnerId UNIQUEIDENTIFIER , 
@Top INT ,
@Total INT OUTPUT 
)
AS 


DECLARE @SQLString nvarchar(4000)
DECLARE @ParmDefinition nvarchar(500)


SELECT @Total = COUNT(*)
FROM pSourcingCommitmentItem ci WITH (NOLOCK)
	inner join pStyleQuoteItem qi WITH (NOLOCK) on qi.StyleQuoteItemID = ci.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis WITH (NOLOCK) ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND @TradePartnerId = qis.TradePartnerID
	INNER JOIN pStyleHeader sh  WITH (NOLOCK) ON qi.StyleID = sh.StyleID 	
	LEFT JOIN pSourcingTradePartner stp WITH (NOLOCK) ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
WHERE 
	@TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID) 
	and ci.SourcingCommitmentItemID not in(select hc.CommitmentItemId from hCommitmentHistory hc where TeamId=@TradePartnerId)
	

IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 

SET @SQLString = @SQLString + ' ci.*, qi.CDate, sh.StyleID, sh.StyleNo, 
        sh.Description, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, '''' as VendorName, qi.TradePartnerID, 
        '''' as VendorCode
FROM pSourcingCommitmentItem ci WITH (NOLOCK)
	inner join pStyleQuoteItem qi WITH (NOLOCK) on qi.StyleQuoteItemID = ci.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis WITH (NOLOCK) ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND @pTradePartnerId = qis.TradePartnerID
	INNER JOIN pStyleHeader sh  WITH (NOLOCK) ON qi.StyleID = sh.StyleID 	
	LEFT JOIN pSourcingTradePartner stp WITH (NOLOCK) ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE 
	@pTradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID) 
	and ci.SourcingCommitmentItemID not in(select hc.CommitmentItemId from hCommitmentHistory hc where TeamId=@pTradePartnerId)
ORDER BY ci.CDate DESC'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'
EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09655', GetDate())
GO
