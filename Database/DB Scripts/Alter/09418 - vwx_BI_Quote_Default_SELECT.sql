IF OBJECT_ID(N'[dbo].[vwx_BI_Quote_Default_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BI_Quote_Default_SELECT]
GO

CREATE VIEW [dbo].[vwx_BI_Quote_Default_SELECT]
AS
SELECT DISTINCT '<img src=''../System/Icons/' + sqis.CustomIcon + ''' />' AS ImagePath, sqi.StyleQuoteItemID, sqi.StyleID, 
       sqi.StyleQuoteItemNo, sqi.StyleQuoteItemStatusId, sqi.StyleQuoteVariationId, sqi.StyleQuoteID, sqi.StyleQuotaDutyID, 
       sqi.StyleDevelopmentID, sqi.StyleQuoteTradePartnerID, sqi.StyleCostingID, sqi.StyleCostingType, sqi.StyleCostingFreightTypeID, 
       sqi.TradePartnerID, sqi.TradePartnerVendorID, sqi.StyleQuoteItemCustomField1, sqi.StyleQuoteItemCustomField2, 
       sqi.StyleQuoteItemCustomField3, sqi.StyleQuoteItemCustomField4, sqi.StyleQuoteItemCustomField5, sqi.StyleQuoteItemCustomField6, 
       sqi.StyleQuoteItemCustomField8, sqi.StyleQuoteItemCustomField9, sqi.StyleQuoteItemCustomField10, sqi.StyleQuoteItemCustomField11, 
       sqi.StyleQuoteItemCustomField12, sqi.StyleQuoteItemCustomField13, sqi.StyleQuoteItemCustomField14, sqi.StyleQuoteItemCustomField15, 
       sqi.StyleQuoteItemCustomField16, sqi.StyleQuoteItemCustomField17, sqi.StyleQuoteItemCustomField18, sqi.StyleQuoteItemCustomField19, 
       sqi.StyleQuoteItemCustomField7, sqi.StyleQuoteItemCustomField20, sqi.StyleQuoteItemCustomField21, sqi.StyleQuoteItemCustomField22, 
       sqi.StyleQuoteItemCustomField23, sqi.StyleQuoteItemCustomField24, sqi.StyleQuoteItemCustomField25, sqi.StyleQuoteItemCustomField26, 
       sqi.StyleQuoteItemCustomField27, sqi.StyleQuoteItemCustomField28, sqi.StyleQuoteItemCustomField29, sqi.StyleQuoteItemCustomField30, 
       sqi.StyleCostingCustomField1, sqi.StyleCostingCustomField2, sqi.StyleCostingCustomField3, sqi.StyleCostingCustomField4, 
       sqi.StyleCostingCustomField5, sqi.StyleCostingCustomField6, sqi.StyleCostingCustomField7, sqi.StyleCostingCustomField8, 
       sqi.StyleCostingCustomField9, sqi.StyleCostingCustomField10, sqi.StyleCostingCustomField11, sqi.StyleCostingCustomField12, 
       sqi.StyleCostingCustomField13, sqi.StyleCostingCustomField14, sqi.StyleCostingCustomField15, sqi.StyleCostingCustomField16, 
       sqi.StyleCostingCustomField17, sqi.StyleCostingCustomField18, sqi.StyleCostingCustomField19, sqi.StyleCostingCustomField20, 
       sqi.StyleCostingCustomField21, sqi.StyleCostingCustomField22, sqi.StyleCostingCustomField23, sqi.StyleCostingCustomField24, 
       sqi.StyleCostingCustomField25, sqi.StyleCostingCustomField26, sqi.StyleCostingCustomField27, sqi.StyleCostingCustomField28, 
       sqi.StyleCostingCustomField29, sqi.StyleCostingCustomField30, sqi.StyleCostingCustomField31, sqi.StyleCostingCustomField32, 
       sqi.StyleCostingCustomField33, sqi.StyleCostingCustomField34, sqi.StyleCostingCustomField35, sh.StyleNo, 
       COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sh.MaterialNo, sh.Pc1, sqi.StyleQuoteItemDueDate, sqi.MDate, 
       sqi.StyleColorID, sqi.StyleSourcingID, sc.StyleColorID AS Expr1, sc.StyleColorName, sqi.StyleQuoteItemCustomField31, 
       sqi.StyleSeasonYearID, ssy.SeasonYearID, ssy.StyleSeason + ' ' + ssy.StyleYear AS StyleSeasonYear, sqifc.Margin, 
       sqifc.TotalLandCost
FROM pStyleQuoteItem sqi
INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID 
LEFT JOIN pStyleColorway sc ON sqi.StyleColorID = sc.StyleColorID 
LEFT JOIN pStyleQuoteItemFreightCost sqifc ON sqi.StyleQuoteItemID = sqifc.StyleQuoteItemId 
LEFT JOIN pStyleSeasonYear ssy ON sqi.StyleSeasonYearID = ssy.StyleSeasonYearID 
LEFT JOIN pStyleQuoteItemStatus sqis ON sqi.StyleQuoteItemStatusId = sqis.CustomKey
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09418', GetDate())
GO
