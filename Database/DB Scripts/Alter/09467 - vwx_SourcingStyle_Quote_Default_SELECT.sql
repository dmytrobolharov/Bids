IF OBJECT_ID(N'[dbo].[vwx_SourcingStyle_Quote_Default_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SourcingStyle_Quote_Default_SELECT]
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_Quote_Default_SELECT]
AS
SELECT DISTINCT TOP (100) PERCENT '<img src=''../System/Icons/' + sqis.CustomIcon + ''' />' AS ImagePath, sqi.StyleQuoteItemID, 
       sqi.StyleID, sqi.StyleQuoteItemNo, sqi.StyleQuoteItemShare, sqi.StyleQuoteItemStatusId, sqi.StyleQuoteVariationId, sqi.StyleQuoteID, 
	   sqi.StyleQuotaDutyID, sqi.StyleDevelopmentID, sqi.StyleQuoteTradePartnerID, sqi.StyleCostingID, sqi.StyleCostingType, 
       sqi.StyleCostingFreightTypeID, sqi.TradePartnerID, sqi.TradePartnerVendorID, sqi.StyleQuoteItemCustomField1, sqi.StyleQuoteItemCustomField2, 
	   sqi.StyleQuoteItemCustomField3, sqi.StyleQuoteItemCustomField4, sqi.StyleQuoteItemCustomField5, sqi.StyleQuoteItemCustomField6, 
       sqi.StyleQuoteItemCustomField8, sqi.StyleQuoteItemCustomField9, sqi.StyleQuoteItemCustomField10, sqi.StyleQuoteItemCustomField11, 
	   sqi.StyleQuoteItemCustomField12, sqi.StyleQuoteItemCustomField13, sqi.StyleQuoteItemCustomField14, sqi.StyleQuoteItemCustomField15, 
	   sqi.StyleQuoteItemCustomField16, sqi.StyleQuoteItemCustomField17, sqi.StyleQuoteItemCustomField18, sqi.StyleQuoteItemCustomField19, 
       sqi.StyleQuoteItemCustomField7, sqi.StyleQuoteItemCustomField20, sqi.StyleQuoteItemCustomField21, sqi.StyleQuoteItemCustomField22, 
	   sqi.StyleQuoteItemCustomField23, sqi.StyleQuoteItemCustomField24, sqi.StyleQuoteItemCustomField25, sqi.StyleQuoteItemCustomField26, 
	   sqi.StyleQuoteItemCustomField27, sqi.StyleQuoteItemCustomField28, sqi.StyleQuoteItemCustomField29, sqi.StyleQuoteItemCustomField30, 
       sqi.StyleCostingCustomField1, sqi.StyleCostingCustomField2, sqi.StyleCostingCustomField3, sqi.StyleCostingCustomField4, sqi.StyleCostingCustomField5, 
	   sqi.StyleCostingCustomField6, sqi.StyleCostingCustomField7, sqi.StyleCostingCustomField8, sqi.StyleCostingCustomField9, 
       sqi.StyleCostingCustomField10, sqi.StyleCostingCustomField11, sqi.StyleCostingCustomField12, sqi.StyleCostingCustomField13, 
	   sqi.StyleCostingCustomField14, sqi.StyleCostingCustomField15, sqi.StyleCostingCustomField16, sqi.StyleCostingCustomField17, 
	   sqi.StyleCostingCustomField18, sqi.StyleCostingCustomField19, sqi.StyleCostingCustomField20, sqi.StyleCostingCustomField21, 
       sqi.StyleCostingCustomField22, sqi.StyleCostingCustomField23, sqi.StyleCostingCustomField24, sqi.StyleCostingCustomField25, 
	   sqi.StyleCostingCustomField26, sqi.StyleCostingCustomField27, sqi.StyleCostingCustomField28, sqi.StyleCostingCustomField29, 
	   sqi.StyleCostingCustomField30, sqi.StyleCostingCustomField31, sqi.StyleCostingCustomField32, sqi.StyleCostingCustomField33, 
       sqi.StyleCostingCustomField34, sqi.StyleCostingCustomField35, sqi.StyleQuoteItem_EcomUnits, sqi.StyleQuoteItem_EcomPriceUnit, 
       sh.StyleNo, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sc.StyleCategory, sh.MaterialNo, sh.Description, 
	   sqi.StyleQuoteItemDueDate, sqi.MDate, sqi.StyleColorID, wfi.WorkFlowItemName, sqi.StyleSourcingID, sqi.SourcingHeaderID, 
	   sqi.StyleQuoteItemCustomField31, sqi.StyleSeasonYearID, ssy.SeasonYearID, ssy.StyleSeason + ' ' + ssy.StyleYear AS StyleSeasonYear,
       (SELECT SUM(ISNULL(PartnerTotal, '0.00')) AS Expr1
        FROM pSourcingQuotationBOMDetails
        WHERE (StyleQuoteItemID = sqi.StyleQuoteItemID)) AS PartnerCost,
       (SELECT SUM(ISNULL(PartnerTotal, '0.00')) AS Expr1
        FROM pSourcingQuotationBOMDetails AS pSourcingQuotationBOMDetails_1
        WHERE (StyleQuoteItemID = sqi.StyleQuoteItemID)) 
		+ (ISNULL(sqi.StyleQuoteItemCustomField8, '0.00') 
        + ISNULL(sqi.StyleQuoteItemCustomField10, '0.00') 
		+ ISNULL(sqi.StyleQuoteItemCustomField12, '0.00') 
        + ISNULL(sqi.StyleQuoteItemCustomField13, '0.00')) + 
		ISNULL((SELECT SUM(ISNULL(Amount, '0.00')) AS Expr1
                FROM pSourcingAdditionalCost
                WHERE (QuoteItemID = sqi.StyleQuoteItemID)), '0.00') AS PartnerExtendedCost, 
	   sqi.StyleCostingScenarioItemID, sqi.TechPack, sqi.StyleSKUItemID, TACal.TACalTemplateId AS CalendarID
FROM pStyleQuoteItem sqi
INNER JOIN pSourcingHeader srh ON sqi.SourcingHeaderID = srh.SourcingHeaderID 
INNER JOIN pSourcingStyle ss ON sqi.StyleSourcingID = ss.SourcingStyleID 
INNER JOIN pSourcingTradePartner stp ON sqi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID 
INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID 
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pStyleBOMDimension sbd ON sqi.StyleColorID = sbd.StyleBOMDimensionID 
LEFT JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = sbd.WorkFlowItemID 
LEFT JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN pStyleQuoteItemStatus sqis ON sqi.StyleQuoteItemStatusId = sqis.CustomKey 
LEFT JOIN (
		   SELECT ct.TACalTemplateId, cr.ReferenceId, ct.SeasonYearId 
		   FROM pTACalTemplate ct 
		   INNER JOIN pTACalReference cr ON ct.TACalTemplateId = cr.TACalTemplateId AND cr.TACalReferenceTypeId = 19
		  ) AS TaCal ON TaCal.SeasonYearId = ssy.SeasonYearID AND TACal.ReferenceId = sqi.StyleQuoteItemID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09467', GetDate())
GO
