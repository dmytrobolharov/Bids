IF OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_ReceivedSeasonYear_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_ReceivedSeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_ReceivedSeasonYear_SELECT]
(
	@Season nvarchar(200),
	@Year nvarchar(200)
)
AS

--Get received samples for the specified season and/or year.
IF((@Season IS NULL OR @Season = '') AND (@Year IS NULL OR @Year = ''))	--Look for all received samples.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestSubmit.Submit,
			pSampleRequestSubmit.RecDate,
			pSampleRequestSubmit.RecBy
		FROM	pSampleRequestSubmit
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestSubmit.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON	(pSampleRequestSubmit.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestSubmit.RecDate IS NOT NULL
				AND	pSampleRequestSubmit.RecDate <> '')
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NULL OR @Year = ''))	--Look for all received samples just by season.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestSubmit.Submit,
			pSampleRequestSubmit.RecDate,
			pSampleRequestSubmit.RecBy
		FROM	pSampleRequestSubmit
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestSubmit.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON	(pSampleRequestSubmit.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestSubmit.RecDate IS NOT NULL
				AND	pSampleRequestSubmit.RecDate <> '')
			AND	(sh.CustomField2 = @Season)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NULL OR @Season = '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all received samples just by year.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestSubmit.Submit,
			pSampleRequestSubmit.RecDate,
			pSampleRequestSubmit.RecBy
		FROM	pSampleRequestSubmit
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestSubmit.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON	(pSampleRequestSubmit.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestSubmit.RecDate IS NOT NULL
				AND	pSampleRequestSubmit.RecDate <> '')
			AND	(sh.CustomField4 = @Year)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all received samples by season and year.
	BEGIN	
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestSubmit.Submit,
			pSampleRequestSubmit.RecDate,
			pSampleRequestSubmit.RecBy
		FROM	pSampleRequestSubmit
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestSubmit.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON	(pSampleRequestSubmit.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestSubmit.RecDate IS NOT NULL
				AND	pSampleRequestSubmit.RecDate <> '')
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
VALUES ('DB_Version', '6.1.0000', '09558', GetDate())
GO
