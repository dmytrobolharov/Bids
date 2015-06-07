IF OBJECT_ID(N'[dbo].[vwx_LinePlanItemCost_RollUp_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanItemCost_RollUp_SELECT]
GO

CREATE VIEW [dbo].[vwx_LinePlanItemCost_RollUp_SELECT]
AS
SELECT sch.StyleID, sch.StyleCostingTypeID, sch.StyleQuotaDutyID, sch.StyleCostingDate, sch.StyleCostingStatus, sch.StyleCostingCustomField1, 
       sch.StyleCostingCustomField2, sch.StyleCostingCustomField3, sch.StyleCostingCustomField4, sch.StyleCostingCustomField5, sch.StyleCostingCustomField6, 
       sch.StyleCostingCustomField7, sch.StyleCostingCustomField8, sch.StyleCostingCustomField9, sch.StyleCostingCustomField10, sch.StyleCostingCustomField11, 
       sch.StyleCostingCustomField12, sch.StyleCostingCustomField13, sch.StyleCostingCustomField14, sch.StyleCostingCustomField15, 
       sch.StyleCostingCustomField16, sch.StyleCostingCustomField17, sch.StyleCostingCustomField18, sch.StyleCostingCustomField19, 
       sch.StyleCostingCustomField20, sch.StyleCostingCustomField21, sch.StyleCostingCustomField22, sch.StyleCostingCustomField23, 
       sch.StyleCostingCustomField24, sch.StyleCostingCustomField25, sch.StyleCostingCustomField26, sch.StyleCostingCustomField27, 
       sch.StyleCostingCustomField28, sch.StyleCostingCustomField29, sch.StyleCostingCustomField30, sch.CUser, sch.CDate, sch.MUser, 
	   sch.MDate, sch.Active, sh.StyleNo, sh.Description, sh.StyleType, sh.StyleCategory, ssy.LinePlanID, ssy.LinePlanItemID, lpi.LinePlanRangeID, 
	   sh.MaterialNo, sh.MaterialName, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.CustomField5, sh.CustomField6, 
	   sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11 AS StyleStatus, sh.CustomField12, sh.CustomField13, 
	   sh.CustomField14, sh.CustomField15, sh.CustomField16, sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, sh.CustomField21, 
	   sh.CustomField22, sh.CustomField23, sh.CustomField24, sh.CustomField25, sh.CustomField26, sh.CustomField27, sh.CustomField28, sh.CustomField29, 
	   sh.CustomField30, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   lpsa.AttributeName, lpr.LinePlanAttributeText2 AS Brand, lpr.LinePlanAttributeText3 AS Category, ssy.SeasonYearID, sch.StyleCostingCustomField35,		--Comment #01, #02
       CASE WHEN sch.StyleCostingCustomField11 = '200' AND sch.Locked = 1 THEN 1 ELSE 0 END AS Locked, 
	   sch.StyleCostingHeaderID, tpv.VendorName AS MostLikelyVendor, tpvri.Margin,
	   lpr.LinePlanAttributeItemID1, lpr.LinePlanAttributeItemID2, lpr.LinePlanAttributeItemID3, lpr.LinePlanAttributeItemID4
FROM pLinePlanItem lpi WITH (NOLOCK)
INNER JOIN pStyleHeader sh WITH (NOLOCK) ON lpi.StyleID = sh.StyleID 
INNER JOIN pStyleSeasonYear ssy WITH (NOLOCK) ON ssy.LinePlanItemID = lpi.LinePlanItemID AND ssy.StyleID =  lpi.StyleID
INNER JOIN dbo.pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID
INNER JOIN dbo.pStyleCostingHeader sch WITH (NOLOCK) ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN pLinePlanRange lpr WITH (NOLOCK)  ON lpi.LinePlanRangeID = lpr.LinePlanRangeID		--Comment #01
LEFT JOIN pLinePlanStyleAttributeItem lpsai WITH (NOLOCK) ON lpsai.LinePlanStyleAttributeItemID = lpi.LinePlanStyleAttributeItemID
LEFT JOIN pLinePlanStyleAttribute lpsa WITH (NOLOCK) ON lpsa.LinePlanStyleAttributeID = lpsai.LinePlanStyleAttributeID	
LEFT JOIN uTradePartnerVendor tpv WITH (NOLOCK) ON tpv.TradePartnerVendorID = ssy.TradePartnerVendorID
LEFT JOIN pTradePartnerVendorRate tpvr WITH (NOLOCK) ON tpvr.TradePartnerVendorID = ssy.TradePartnerVendorID AND 
														tpvr.Season = sy.Season AND 
														tpvr.Year = sy.Year
LEFT JOIN pTradePartnerVendorRateItem tpvri WITH (NOLOCK) ON tpvr.TradePartnerVendorRateID = tpvri.TradePartnerVendorRateID	AND 
															 tpvri.StyleCategoryID = sh.StyleCategory 
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09440', GetDate())
GO
