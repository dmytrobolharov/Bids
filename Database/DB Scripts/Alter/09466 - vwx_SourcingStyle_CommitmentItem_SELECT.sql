IF OBJECT_ID(N'[dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]
AS
SELECT DISTINCT '<img src=''../System/Icons/' + sqis.CustomIcon + ''' />' AS ImagePath, sci.StyleQuoteItemID, sci.StyleID, 
       sci.StyleQuoteItemNo, sci.StyleQuoteItemShare, sci.StyleQuoteItemStatusId, sci.StyleQuoteVariationId, sci.StyleQuoteID, 
       sci.StyleQuotaDutyID, sci.StyleDevelopmentID, sci.StyleQuoteTradePartnerID, sci.StyleCostingID, sci.StyleCostingType, 
	   sci.StyleCostingFreightTypeID, sci.TradePartnerID, sci.TradePartnerVendorID, sci.StyleQuoteItemCustomField1, 
       sci.StyleQuoteItemCustomField2, sci.StyleQuoteItemCustomField3, sci.StyleQuoteItemCustomField4, sci.StyleQuoteItemCustomField5, 
       sci.StyleQuoteItemCustomField6, sci.StyleQuoteItemCustomField8, sci.StyleQuoteItemCustomField9, sci.StyleQuoteItemCustomField10, 
       sci.StyleQuoteItemCustomField11, sci.StyleQuoteItemCustomField12, sci.StyleQuoteItemCustomField13, sci.StyleQuoteItemCustomField14, 
       sci.StyleQuoteItemCustomField15, sci.StyleQuoteItemCustomField16, sci.StyleQuoteItemCustomField17, sci.StyleQuoteItemCustomField18, 
       sci.StyleQuoteItemCustomField19, sci.StyleQuoteItemCustomField7, sci.StyleQuoteItemCustomField20, sci.StyleQuoteItemCustomField21, 
       sci.StyleQuoteItemCustomField22, sci.StyleQuoteItemCustomField23, sci.StyleQuoteItemCustomField24, sci.StyleQuoteItemCustomField25, 
       sci.StyleQuoteItemCustomField26, sci.StyleQuoteItemCustomField27, sci.StyleQuoteItemCustomField28, sci.StyleQuoteItemCustomField29, 
       sci.StyleQuoteItemCustomField30, sci.StyleCostingCustomField1, sci.StyleCostingCustomField2, sci.StyleCostingCustomField3, 
       sci.StyleCostingCustomField4, sci.StyleCostingCustomField5, sci.StyleCostingCustomField6, sci.StyleCostingCustomField7, 
       sci.StyleCostingCustomField8, sci.StyleCostingCustomField9, sci.StyleCostingCustomField10, sci.StyleCostingCustomField11, 
       sci.StyleCostingCustomField12, sci.StyleCostingCustomField13, sci.StyleCostingCustomField14, sci.StyleCostingCustomField15, 
       sci.StyleCostingCustomField16, sci.StyleCostingCustomField17, sci.StyleCostingCustomField18, sci.StyleCostingCustomField19, 
       sci.StyleCostingCustomField20, sci.StyleCostingCustomField21, sci.StyleCostingCustomField22, sci.StyleCostingCustomField23, 
       sci.StyleCostingCustomField24, sci.StyleCostingCustomField25, sci.StyleCostingCustomField26, sci.StyleCostingCustomField27, 
       sci.StyleCostingCustomField28, sci.StyleCostingCustomField29, sci.StyleCostingCustomField30, sci.StyleCostingCustomField31, 
       sci.StyleCostingCustomField32, sci.StyleCostingCustomField33, sci.StyleCostingCustomField34, sci.StyleCostingCustomField35, 
	   sh.StyleNo, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sc.StyleCategoryID, sh.DesignSketchID, sh.DesignSketchVersion, 
	   sh.DevelopmentID, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sc.StyleCategory, sh.MaterialNo, sci.SourcingCommitmentItemID, 
       sci.StyleCommitmentNo, sh.Description, sci.StyleQuoteItemDueDate, sci.MDate, sci.StyleColorID, wfi.WorkFlowItemName, 
       sci.StyleSourcingID, sci.SourcingHeaderID, sci.StyleQuoteItemCustomField31, sci.StyleSeasonYearID, ssy.SeasonYearID, 
       ssy.StyleSeason + ' ' + ssy.StyleYear AS StyleSeasonYear, p.AgentID, p.AgentName, p.VendorID, p.VendorName, p.FactoryID, 
       p.FactoryName, srh.SourcingName, srh.SourcingType
FROM pSourcingCommitmentItem sci
INNER JOIN pSourcingHeader srh ON srh.SourcingHeaderID = sci.SourcingHeaderID 
INNER JOIN pSourcingTradePartner AS stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID 
INNER JOIN pSourcingStyle ss ON sci.StyleSourcingID = ss.SourcingStyleID 
INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID 
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL AS p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID 
LEFT JOIN pStyleBOMDimension sbd ON sci.StyleColorID = sbd.StyleBOMDimensionID 
LEFT JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = sbd.WorkFlowItemID 
LEFT JOIN pStyleSeasonYear ssy ON ssy.StyleSeasonYearID = sci.StyleSeasonYearID 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN pStyleQuoteItemStatus sqis ON sci.StyleQuoteItemStatusId = sqis.CustomKey
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09466', GetDate())
GO
