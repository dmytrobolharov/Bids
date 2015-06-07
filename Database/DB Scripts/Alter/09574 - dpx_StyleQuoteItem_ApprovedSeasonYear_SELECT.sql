IF OBJECT_ID(N'[dbo].[dpx_StyleQuoteItem_ApprovedSeasonYear_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_StyleQuoteItem_ApprovedSeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleQuoteItem_ApprovedSeasonYear_SELECT]
(
	@Season nvarchar(200),
	@Year nvarchar(200)
)
AS

--Get approved quotes for the specified season and/or year.
IF((@Season IS NULL OR @Season = '') AND (@Year IS NULL OR @Year = ''))	--Look for all approved quotes.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NULL OR @Year = ''))	--Look for all approved quotes just by season.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(sh.CustomField2 = @Season)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NULL OR @Season = '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all approved quotes just by year.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(sh.CustomField4 = @Year)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all approved quotes by season and year.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(sh.CustomField2 = @Season)
			AND	(sh.CustomField4 = @Year)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09574', GetDate())
GO
