IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMCommitmentItemAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMCommitmentItemAgent_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_NPMCommitmentItemAgent_SELECT] (
	@StyleId uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@SeasonYearId uniqueidentifier = NULL
)
AS 

IF @SeasonYearId IS NULL
BEGIN

	SELECT 'N/A' AS ColorName, qi.StyleQuoteItemID, qi.SourcingCommitmentItemID, 
          qi.StyleQuoteItemNo, qi.StyleQuoteItemShare, qi.StyleQuoteItemStatusId, 
          qi.StyleCommitmentNo,
          qi.StyleQuoteVariationId, qi.StyleQuoteID, qi.StyleQuotaDutyID, qi.StyleDevelopmentID, 
          qi.StyleID, qi.StyleQuoteTradePartnerID, qi.StyleCostingID, qi.StyleCostingType, 
          qi.StyleCostingFreightTypeID, qi.TradePartnerID, qi.TradePartnerVendorID, 
          qi.StyleQuoteItemDueDate, qi.StyleQuoteItemApprovedBy, qi.StyleQuoteItemApprovedDate, 
          qi.StyleQuoteItemCustomField1, qi.StyleQuoteItemCustomField2, qi.StyleQuoteItemCustomField3, 
          qi.StyleQuoteItemCustomField4, qi.StyleQuoteItemCustomField5, qi.StyleQuoteItemCustomField6, 
          qi.StyleQuoteItemCustomField7, qi.StyleQuoteItemCustomField8, qi.StyleQuoteItemCustomField9, 
          qi.StyleQuoteItemCustomField10, qi.StyleQuoteItemCustomField11, qi.StyleQuoteItemCustomField12, 
          qi.StyleQuoteItemCustomField13, qi.StyleQuoteItemCustomField14, qi.StyleQuoteItemCustomField15, 
          qi.StyleQuoteItemCustomField16, qi.StyleQuoteItemCustomField17, qi.StyleQuoteItemCustomField18, 
          qi.StyleQuoteItemCustomField19, qi.StyleQuoteItemCustomField20, qi.StyleQuoteItemCustomField21, 
          qi.StyleQuoteItemCustomField22, qi.StyleQuoteItemCustomField23, qi.StyleQuoteItemCustomField24, 
          qi.StyleQuoteItemCustomField25, qi.StyleQuoteItemCustomField26, qi.StyleQuoteItemCustomField27, 
          qi.StyleQuoteItemCustomField28, qi.StyleQuoteItemCustomField29, qi.StyleQuoteItemCustomField30, 
          qi.StyleQuoteItemCustomField31, qi.StyleQuoteItemNotes, qi.StyleCostingCustomField1, 
          qi.StyleCostingCustomField2, qi.StyleCostingCustomField3, qi.StyleCostingCustomField4, 
          qi.StyleCostingCustomField5, qi.StyleCostingCustomField6, qi.StyleCostingCustomField7, 
          qi.StyleCostingCustomField8, qi.StyleCostingCustomField9, qi.StyleCostingCustomField10, 
          qi.StyleCostingCustomField11, qi.StyleCostingCustomField12, qi.StyleCostingCustomField13, 
          qi.StyleCostingCustomField14, qi.StyleCostingCustomField15, qi.StyleCostingCustomField16, 
          qi.StyleCostingCustomField17, qi.StyleCostingCustomField18, qi.StyleCostingCustomField19, 
          qi.StyleCostingCustomField20, qi.StyleCostingCustomField21, qi.StyleCostingCustomField22, 
          qi.StyleCostingCustomField23, qi.StyleCostingCustomField24, qi.StyleCostingCustomField25, 
          qi.StyleCostingCustomField26, qi.StyleCostingCustomField27, qi.StyleCostingCustomField28, 
          qi.StyleCostingCustomField29, qi.StyleCostingCustomField30, qi.StyleCostingCustomField31, 
          qi.StyleCostingCustomField32, qi.StyleCostingCustomField33, qi.StyleCostingCustomField34, 
          qi.StyleCostingCustomField35, qi.CUser, qi.CDate, qi.MUser, qi.MDate, 
          qi.QuoteFolderSort, qi.AgentView, qi.StyleColorID, qi.StyleSourcingID, (sh.Season + ' ' + sh.Year) as SeasonYearName, 
          tprl.*
	FROM  pSourcingCommitmentItem qi
	INNER JOIN pStyleQuoteItem qii on qii.StyleQuoteItemID = qi.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND qis.TradePartnerID = @TradePartnerID
	INNER JOIN pSourcingHeader sh ON qi.SourcingHeaderID = sh.SourcingHeaderID
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID 
	WHERE qi.StyleID = @StyleId				
	ORDER BY qi.StyleQuoteItemNo DESC
	
END
ELSE
BEGIN

	SELECT 'N/A' AS ColorName, qi.StyleQuoteItemID, qi.SourcingCommitmentItemID, 
          qi.StyleQuoteItemNo, qi.StyleQuoteItemShare, qi.StyleQuoteItemStatusId, 
          qi.StyleCommitmentNo,
          qi.StyleQuoteVariationId, qi.StyleQuoteID, qi.StyleQuotaDutyID, qi.StyleDevelopmentID, 
          qi.StyleID, qi.StyleQuoteTradePartnerID, qi.StyleCostingID, qi.StyleCostingType, 
          qi.StyleCostingFreightTypeID, qi.TradePartnerID, qi.TradePartnerVendorID, 
          qi.StyleQuoteItemDueDate, qi.StyleQuoteItemApprovedBy, qi.StyleQuoteItemApprovedDate, 
          qi.StyleQuoteItemCustomField1, qi.StyleQuoteItemCustomField2, qi.StyleQuoteItemCustomField3, 
          qi.StyleQuoteItemCustomField4, qi.StyleQuoteItemCustomField5, qi.StyleQuoteItemCustomField6, 
          qi.StyleQuoteItemCustomField7, qi.StyleQuoteItemCustomField8, qi.StyleQuoteItemCustomField9, 
          qi.StyleQuoteItemCustomField10, qi.StyleQuoteItemCustomField11, qi.StyleQuoteItemCustomField12, 
          qi.StyleQuoteItemCustomField13, qi.StyleQuoteItemCustomField14, qi.StyleQuoteItemCustomField15, 
          qi.StyleQuoteItemCustomField16, qi.StyleQuoteItemCustomField17, qi.StyleQuoteItemCustomField18, 
          qi.StyleQuoteItemCustomField19, qi.StyleQuoteItemCustomField20, qi.StyleQuoteItemCustomField21, 
          qi.StyleQuoteItemCustomField22, qi.StyleQuoteItemCustomField23, qi.StyleQuoteItemCustomField24, 
          qi.StyleQuoteItemCustomField25, qi.StyleQuoteItemCustomField26, qi.StyleQuoteItemCustomField27, 
          qi.StyleQuoteItemCustomField28, qi.StyleQuoteItemCustomField29, qi.StyleQuoteItemCustomField30, 
          qi.StyleQuoteItemCustomField31, qi.StyleQuoteItemNotes, qi.StyleCostingCustomField1, 
          qi.StyleCostingCustomField2, qi.StyleCostingCustomField3, qi.StyleCostingCustomField4, 
          qi.StyleCostingCustomField5, qi.StyleCostingCustomField6, qi.StyleCostingCustomField7, 
          qi.StyleCostingCustomField8, qi.StyleCostingCustomField9, qi.StyleCostingCustomField10, 
          qi.StyleCostingCustomField11, qi.StyleCostingCustomField12, qi.StyleCostingCustomField13, 
          qi.StyleCostingCustomField14, qi.StyleCostingCustomField15, qi.StyleCostingCustomField16, 
          qi.StyleCostingCustomField17, qi.StyleCostingCustomField18, qi.StyleCostingCustomField19, 
          qi.StyleCostingCustomField20, qi.StyleCostingCustomField21, qi.StyleCostingCustomField22, 
          qi.StyleCostingCustomField23, qi.StyleCostingCustomField24, qi.StyleCostingCustomField25, 
          qi.StyleCostingCustomField26, qi.StyleCostingCustomField27, qi.StyleCostingCustomField28, 
          qi.StyleCostingCustomField29, qi.StyleCostingCustomField30, qi.StyleCostingCustomField31, 
          qi.StyleCostingCustomField32, qi.StyleCostingCustomField33, qi.StyleCostingCustomField34, 
          qi.StyleCostingCustomField35, qi.CUser, qi.CDate, qi.MUser, qi.MDate, 
          qi.QuoteFolderSort, qi.AgentView, qi.StyleColorID, qi.StyleSourcingID, (sh.Season + ' ' + sh.Year) as SeasonYearName, 
          tprl.*
	FROM  pSourcingCommitmentItem qi
	INNER JOIN pStyleQuoteItem qii on qii.StyleQuoteItemID = qi.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND qis.TradePartnerID = @TradePartnerID
	INNER JOIN pSourcingHeader sh ON qi.SourcingHeaderID = sh.SourcingHeaderID
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID 
	LEFT OUTER JOIN pStyleSeasonYear ssy WITH (NOLOCK) ON qi.StyleSeasonYearID = ssy.StyleSeasonYearID
	LEFT OUTER JOIN pSeasonYear sy WITH (NOLOCK) ON ssy.SeasonYearID  = sy.SeasonYearID
	WHERE qi.StyleID = @StyleId AND sy.SeasonYearID = @SeasonYearId				
	ORDER BY qi.StyleQuoteItemNo DESC

END	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06828', GetDate())
GO
