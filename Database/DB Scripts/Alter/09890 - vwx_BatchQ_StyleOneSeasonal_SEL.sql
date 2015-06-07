IF OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
AS
SELECT DISTINCT TOP (100) PERCENT sh.StyleID, ssy.SeasonYearID, sh.StyleNo, sh.Description, sh.StyleCategory, sc.StyleCategory AS 'ProductCategoryName', 
       sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
	   sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	  sh.MaterialNo, sh.MaterialName, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4,
	  sh.CustomField5, sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField15, sh.CustomField14,
	  sh.CustomField13, sh.CustomField12, sh.CustomField11, sh.CustomField10, sh.CustomField9, sh.CustomField16,
	  sh.CustomField30, sh.CustomField29, sh.CustomField28, sh.CustomField27, sh.CustomField26, sh.CustomField25,
	  sh.CustomField24, sh.CustomField23, sh.CustomField22, sh.CustomField21, sh.CustomField20, sh.CustomField19,
	  sh.CustomField18, sh.CustomField17, sh.CustomField31, sh.CustomField32, sh.CustomField33, sh.CustomField34,
	  sh.CustomField35, sh.CustomField36, sh.CustomField37, sh.CustomField38, sh.CustomField39, sh.CustomField40,  sh.StyleType,
	  '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(sh.DesignSketchVersion AS NVARCHAR(5)) + '&IID=' + CAST(sh.DesignSketchID AS NVARCHAR(40)) + '" \>' AS ImagePath,
	  '../System/Control/ImageStream.ashx?S=150&V=' + CAST(sh.DesignSketchVersion AS NVARCHAR(5)) + '&IID=' + CAST(sh.DesignSketchID AS NVARCHAR(40)) AS DataListImagePath,
	  (SELECT tp.TradePartnerName + ', '
	   FROM pStyleSourcing ss (NOLOCK)
	   LEFT OUTER JOIN uTradePartner tp (NOLOCK) ON ss.TradePartnerID = tp.TradePartnerID
	   WHERE ss.StyleID = sh.StyleID FOR XML PATH('')) AS TradePartnerName, 
	  (SELECT tpv.VendorName + ', '
	   FROM pStyleSourcing ss (NOLOCK) 
	   LEFT OUTER JOIN uTradePartnerVendor tpv (NOLOCK) ON ss.TradePartnerVendorID = tpv.TradePartnerVendorID
	   WHERE ss.StyleID = sh.StyleID FOR XML PATH('')) AS VendorName, 
	   sy.Season, sy.Year, lpsai.AttributeName
FROM pStyleHeader sh (NOLOCK)
INNER JOIN pStyleSeasonYear ssy (NOLOCK) ON sh.StyleID = ssy.StyleID
LEFT JOIN pStyleColorwaySeasonYear scsy (NOLOCK) ON ssy.StyleSeasonYearID = scsy.StyleSeasonYearID
LEFT JOIN pStyleCategory sc (NOLOCK) ON sc.StyleCategoryId = sh.StyleCategory 
LEFT JOIN pSizeClass scc (NOLOCK) ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
LEFT JOIN pSeasonYear sy (NOLOCK) ON ssy.SeasonYearID = sy.SeasonYearID
LEFT JOIN pLinePlanItem lpi (NOLOCK) ON lpi.LinePlanItemID = ssy.LinePlanItemID
LEFT JOIN pLinePlanStyleAttributeItem lpsai (NOLOCK) ON lpsai.LinePlanStyleAttributeItemID = lpi.LinePlanStyleAttributeItemID
WHERE EXISTS (SELECT StyleID FROM dbo.pStyleSeasonYear ssy 
			  WHERE ssy.StyleID = sh.StyleID
			  GROUP BY ssy.StyleID
		      HAVING COUNT(*) = 1) AND 
	  sc.Active = 1 AND scc.Active = 1
ORDER BY sh.StyleNo



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09890', GetDate())
GO
