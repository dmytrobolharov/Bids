IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingHeader' and COLUMN_NAME = N'Locked')
       BEGIN 
            ALTER TABLE pStyleCostingHeader ADD Locked int NULL
       END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanItemCost_RollUp_SELECT]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_LinePlanItemCost_RollUp_SELECT]
GO


CREATE VIEW dbo.vwx_LinePlanItemCost_RollUp_SELECT
AS

SELECT				  a.StyleID, a.StyleCostingTypeID, a.StyleQuotaDutyID, a.StyleCostingDate, a.StyleCostingStatus, a.StyleCostingCustomField1, 
                      a.StyleCostingCustomField2, a.StyleCostingCustomField3, a.StyleCostingCustomField4, a.StyleCostingCustomField5, a.StyleCostingCustomField6, 
                      a.StyleCostingCustomField7, a.StyleCostingCustomField8, a.StyleCostingCustomField9, a.StyleCostingCustomField10, a.StyleCostingCustomField11, 
                      a.StyleCostingCustomField12, a.StyleCostingCustomField13, a.StyleCostingCustomField14, a.StyleCostingCustomField15, 
                      a.StyleCostingCustomField16, a.StyleCostingCustomField17, a.StyleCostingCustomField18, a.StyleCostingCustomField19, 
                      a.StyleCostingCustomField20, a.StyleCostingCustomField21, a.StyleCostingCustomField22, a.StyleCostingCustomField23, 
                      a.StyleCostingCustomField24, a.StyleCostingCustomField25, a.StyleCostingCustomField26, a.StyleCostingCustomField27, 
                      a.StyleCostingCustomField28, a.StyleCostingCustomField29, a.StyleCostingCustomField30, a.CUser, a.CDate, a.MUser, a.MDate, a.Active, b.StyleNo, 
                      b.Description, b.StyleType, b.StyleCategory, c.LinePlanID, c.LinePlanItemID, d.LinePlanRangeID, b.MaterialNo, b.MaterialName, b.CustomField1, 
                      b.CustomField2, b.CustomField3, b.CustomField4, b.CustomField5, b.CustomField6, b.CustomField7, b.CustomField8, b.CustomField9, 
                      b.CustomField10, b.CustomField11 AS StyleStatus, b.CustomField12, b.CustomField13, b.CustomField14, b.CustomField15, b.CustomField16, b.CustomField17, 
                      b.CustomField18, b.CustomField19, b.CustomField20, b.CustomField21, b.CustomField22, b.CustomField23, b.CustomField24, b.CustomField25, 
                      b.CustomField26, b.CustomField27, b.CustomField28, b.CustomField29, b.CustomField30, b.SizeClass, b.SizeRange, f.AttributeName
					  ,g.LinePlanAttributeText2 AS Brand, g.LinePlanAttributeText3 AS Category, c.SeasonYearID, a.StyleCostingCustomField35,		--Comment #01, #02
CASE  
	WHEN a.StyleCostingCustomField11 = '200' AND a.Locked = 1 THEN 1
	ELSE 0
END AS Locked, a.StyleCostingHeaderID, h.VendorName AS MostLikelyVendor, j.Margin,
	g.LinePlanAttributeItemID1, g.LinePlanAttributeItemID2, g.LinePlanAttributeItemID3, g.LinePlanAttributeItemID4
FROM  pLinePlanItem d WITH (NOLOCK)
	INNER JOIN pStyleHeader b WITH (NOLOCK) ON d.StyleID =  b.StyleID 
	INNER JOIN dbo.pStyleSeasonYear c WITH (NOLOCK) ON c.LinePlanItemID = d.LinePlanItemID AND c.StyleID =  d.StyleID
	INNER JOIN dbo.pSeasonYear c1 ON c1.SeasonYearID = c.SeasonYearID
	INNER JOIN dbo.pStyleCostingHeader a WITH (NOLOCK) ON a.StyleSeasonYearID = c.StyleSeasonYearID
	INNER JOIN pLinePlanRange g WITH (NOLOCK)  ON d.LinePlanRangeID = g.LinePlanRangeID		--Comment #01
	LEFT OUTER JOIN pLinePlanStyleAttributeItem e WITH (NOLOCK) ON e.LinePlanStyleAttributeItemID = d.LinePlanStyleAttributeItemID
	LEFT OUTER JOIN pLinePlanStyleAttribute f WITH (NOLOCK) ON f.LinePlanStyleAttributeID = e.LinePlanStyleAttributeID	
	LEFT OUTER JOIN dbo.uTradePartnerVendor h WITH (NOLOCK) ON h.TradePartnerVendorID = c.TradePartnerVendorID
	LEFT OUTER JOIN pTradePartnerVendorRate	i WITH (NOLOCK) ON i.TradePartnerVendorID = c.TradePartnerVendorID
		AND i.Season = c1.Season AND i.Year =  c1.Year
	LEFT OUTER JOIN pTradePartnerVendorRateItem	j WITH (NOLOCK) ON i.TradePartnerVendorRateID = j.TradePartnerVendorRateID
		AND J.StyleCategoryID = b.StyleCategory 


GO


