IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingStyle_QuoteItem_SELECT]'))
	DROP VIEW [dbo].[vwx_SourcingStyle_QuoteItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_QuoteItem_SELECT]
AS
SELECT DISTINCT 
                      '<img src=''../System/Icons/' + sqis.CustomIcon + ''' />' AS ImagePath, sqi.StyleQuoteItemID, sqi.StyleID, sqi.StyleQuoteItemNo, sqi.StyleQuoteItemShare, 
                      sqi.StyleQuoteItemStatusId, sqi.StyleQuoteVariationId, sqi.StyleQuoteID, sqi.StyleQuotaDutyID, sqi.StyleDevelopmentID, sqi.StyleQuoteTradePartnerID, 
                      sqi.StyleCostingID, sqi.StyleCostingType, sqi.StyleCostingFreightTypeID, sqi.TradePartnerID, sqi.TradePartnerVendorID, sqi.StyleQuoteItemCustomField1, 
                      sqi.StyleQuoteItemCustomField2, sqi.StyleQuoteItemCustomField3, sqi.StyleQuoteItemCustomField4, sqi.StyleQuoteItemCustomField5, 
                      sqi.StyleQuoteItemCustomField6, sqi.StyleQuoteItemCustomField8, sqi.StyleQuoteItemCustomField9, sqi.StyleQuoteItemCustomField10, 
                      sqi.StyleQuoteItemCustomField11, sqi.StyleQuoteItemCustomField12, sqi.StyleQuoteItemCustomField13, sqi.StyleQuoteItemCustomField14, 
                      sqi.StyleQuoteItemCustomField15, sqi.StyleQuoteItemCustomField16, sqi.StyleQuoteItemCustomField17, sqi.StyleQuoteItemCustomField18, 
                      sqi.StyleQuoteItemCustomField19, sqi.StyleQuoteItemCustomField7, sqi.StyleQuoteItemCustomField20, sqi.StyleQuoteItemCustomField21, 
                      sqi.StyleQuoteItemCustomField22, sqi.StyleQuoteItemCustomField23, sqi.StyleQuoteItemCustomField24, sqi.StyleQuoteItemCustomField25, 
                      sqi.StyleQuoteItemCustomField26, sqi.StyleQuoteItemCustomField27, sqi.StyleQuoteItemCustomField28, sqi.StyleQuoteItemCustomField29, 
                      sqi.StyleQuoteItemCustomField30, sqi.StyleCostingCustomField1, sqi.StyleCostingCustomField2, sqi.StyleCostingCustomField3, sqi.StyleCostingCustomField4, 
                      sqi.StyleCostingCustomField5, sqi.StyleCostingCustomField6, sqi.StyleCostingCustomField7, sqi.StyleCostingCustomField8, sqi.StyleCostingCustomField9, 
                      sqi.StyleCostingCustomField10, sqi.StyleCostingCustomField11, sqi.StyleCostingCustomField12, sqi.StyleCostingCustomField13, sqi.StyleCostingCustomField14, 
                      sqi.StyleCostingCustomField15, sqi.StyleCostingCustomField16, sqi.StyleCostingCustomField17, sqi.StyleCostingCustomField18, sqi.StyleCostingCustomField19, 
                      sqi.StyleCostingCustomField20, sqi.StyleCostingCustomField21, sqi.StyleCostingCustomField22, sqi.StyleCostingCustomField23, sqi.StyleCostingCustomField24, 
                      sqi.StyleCostingCustomField25, sqi.StyleCostingCustomField26, sqi.StyleCostingCustomField27, sqi.StyleCostingCustomField28, sqi.StyleCostingCustomField29, 
                      sqi.StyleCostingCustomField30, sqi.StyleCostingCustomField31, sqi.StyleCostingCustomField32, sqi.StyleCostingCustomField33, sqi.StyleCostingCustomField34, 
                      sqi.StyleCostingCustomField35, sh.StyleNo, COALESCE (scc.Custom, sh.SizeClass) AS SizeClass, COALESCE (sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
                      sc.StyleCategoryId, sh.DesignSketchID, sh.DesignSketchVersion, sh.DevelopmentID, sc.StyleCategory, sh.MaterialNo, sh.Description, sqi.StyleQuoteItemDueDate, 
                      sqi.MDate, sqi.StyleColorID, wfi.WorkFlowItemName, sqi.StyleSourcingID, sqi.SourcingHeaderID, sqi.StyleQuoteItemCustomField31, sqi.StyleSeasonYearID, 
                      ssy.SeasonYearID, ssy.StyleSeason + ' ' + ssy.StyleYear AS StyleSeasonYear, p.AgentID, p.AgentName, p.VendorID, p.VendorName, p.FactoryID, p.FactoryName,
                          (SELECT     SUM(ISNULL(PartnerTotal, '0.00')) AS Expr1
                            FROM          dbo.pSourcingQuotationBOMDetails
                            WHERE      (StyleQuoteItemID = sqi.StyleQuoteItemID)) AS PartnerCost,
                          (SELECT     SUM(ISNULL(PartnerTotal, '0.00')) AS Expr1
                            FROM          dbo.pSourcingQuotationBOMDetails AS pSourcingQuotationBOMDetails_1
                            WHERE      (StyleQuoteItemID = sqi.StyleQuoteItemID)) + (ISNULL(sqi.StyleQuoteItemCustomField8, '0.00') + ISNULL(sqi.StyleQuoteItemCustomField10, '0.00') 
                      + ISNULL(sqi.StyleQuoteItemCustomField12, '0.00') + ISNULL(sqi.StyleQuoteItemCustomField13, '0.00')) + ISNULL
                          ((SELECT     SUM(ISNULL(Amount, '0.00')) AS Expr1
                              FROM         dbo.pSourcingAdditionalCost
                              WHERE     (QuoteItemID = sqi.StyleQuoteItemID)), '0.00') AS PartnerExtendedCost, ISNULL
                          ((SELECT     SUM(ISNULL(Amount, '0.00')) AS Expr1
                              FROM         dbo.pSourcingAdditionalCost AS pSourcingAdditionalCost_1
                              WHERE     (QuoteItemID = sqi.StyleQuoteItemID)), '0.00') AS AdditionalCost, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) 
                      AS VariationName, CASE WHEN EXISTS
                          (SELECT     *
                            FROM          pStyleQuoteItemShare qis
                            WHERE      qis.StyleQouteItemID = sqi.StyleQuoteItemID AND qis.TradePartnerID IN (p.AgentID, p.VendorID, p.FactoryID)) THEN 1 ELSE 0 END AS IsShared, 
                      srh.SourcingName, srh.SourcingType, srh.Division AS SourcingDivisionID
FROM         dbo.pStyleQuoteItem AS sqi INNER JOIN
                      dbo.pSourcingHeader AS srh ON srh.SourcingHeaderID = sqi.SourcingHeaderID INNER JOIN
                      dbo.pSourcingTradePartner AS stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID INNER JOIN
                      dbo.pSourcingStyle AS ss ON sqi.StyleSourcingID = ss.SourcingStyleID INNER JOIN
                      dbo.pStyleHeader AS sh ON sqi.StyleID = sh.StyleID LEFT OUTER JOIN
                      dbo.vwx_TradePartnerRelationshipLevels_SEL AS p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID LEFT OUTER JOIN
                      dbo.pStyleDevelopmentItem AS sdi ON sqi.StyleID = sdi.StyleID LEFT OUTER JOIN
                      dbo.pStyleBOMDimension AS sbd ON sqi.StyleColorID = sbd.StyleBOMDimensionID LEFT OUTER JOIN
                      dbo.pWorkFlowItem AS wfi ON wfi.WorkFlowItemID = sbd.WorkFlowItemID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear AS ssy ON ssy.StyleSeasonYearID = sqi.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleCategory AS sc ON sh.StyleCategory = sc.StyleCategoryId LEFT OUTER JOIN
                      dbo.pStyleQuoteItemStatus AS sqis ON sqi.StyleQuoteItemStatusId = sqis.CustomKey LEFT OUTER JOIN
                      dbo.pSizeClass AS scc ON scc.CustomID = sh.SizeClassId LEFT OUTER JOIN
                      dbo.pSizeRange AS sr ON sr.CustomId = sh.SizeRangeId

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10199', GetUTCDate())
GO