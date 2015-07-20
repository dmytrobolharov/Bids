IF OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
AS
SELECT sh.StyleID, sh.StyleNo, sh.Description, sh.CustomField14, sh.MaterialName, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.StyleType, 
	   sh.SizeClassId, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
	   sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   sy.Season, sy.Year, g.AttributeName, sh.StyleCategory, e.StyleCategory AS 'ProductCategoryName', 
	   ssy.StyleSeasonyearID, ssy.SeasonYearID,
       (SELECT tp.TradePartnerName + ', '
        FROM pStyleSourcing ss
		LEFT JOIN uTradePartner tp ON tp.TradePartnerID = ss.TradePartnerID
        WHERE ss.StyleID = sh.StyleID 
		FOR XML PATH('')) AS TradePartnerName,
       (SELECT tpv.VendorName + ', '
        FROM pStyleSourcing ss 
		LEFT JOIN uTradePartnerVendor tpv ON tpv.TradePartnerVendorID = ss.TradePartnerVendorID
        WHERE ss.StyleID = sh.StyleID
		FOR XML PATH('')) AS VendorName,
	   dbo.fnx_GetStreamingImageHTML(sh.DesignSketchID, sh.DesignSketchVersion, 50, '') AS ImagePath, 
	   dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion, 150) AS DataListImagePath
FROM pStyleHeader sh 
INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = sh.StyleID 
INNER JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID 
LEFT JOIN pLinePlanItem f ON f.LinePlanItemID = ssy.LinePlanItemID 
LEFT JOIN pLinePlanStyleAttributeItem g ON g.LinePlanStyleAttributeItemID = f.LinePlanStyleAttributeItemID 
LEFT JOIN pStyleCategory e ON e.StyleCategoryId = sh.StyleCategory
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10314', GetUTCDate())
GO
