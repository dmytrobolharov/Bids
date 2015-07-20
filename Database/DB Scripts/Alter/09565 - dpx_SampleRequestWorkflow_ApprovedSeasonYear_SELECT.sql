IF OBJECT_ID(N'[dbo].[dpx_SampleRequestWorkflow_ApprovedSeasonYear_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestWorkflow_ApprovedSeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestWorkflow_ApprovedSeasonYear_SELECT]
(
	@Season nvarchar(200),
	@Year nvarchar(200)
)
AS

--Get approved samples for the specified season and/or year.
IF((@Season IS NULL OR @Season = '') AND (@Year IS NULL OR @Year = ''))	--Look for all approved samples.
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
			pSampleRequestWorkflow.EndDate
		FROM	pSampleRequestWorkflow
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON (pSampleRequestWorkflow.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 2
				OR	pSampleRequestWorkflow.Status = 3)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NULL OR @Year = ''))	--Look for all approved samples just by season.
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
			pSampleRequestWorkflow.EndDate
		FROM	pSampleRequestWorkflow
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON (pSampleRequestWorkflow.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 2
				OR	pSampleRequestWorkflow.Status = 3)
			AND	(sh.CustomField2 = @Season)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NULL OR @Season = '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all approved samples just by year.
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
			pSampleRequestWorkflow.EndDate
		FROM	pSampleRequestWorkflow
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON	(pSampleRequestWorkflow.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 2
				OR	pSampleRequestWorkflow.Status = 3)
			AND	(sh.CustomField4 = @Year)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.CustomField4,
			sh.CustomField2,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all approved samples by season and year.
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
			pSampleRequestWorkflow.EndDate
		FROM	pSampleRequestWorkflow
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID)
			INNER JOIN pStyleHeader sh ON (pSampleRequestWorkflow.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 2
				OR	pSampleRequestWorkflow.Status = 3)
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
VALUES ('DB_Version', '6.1.0000', '09565', GetDate())
GO
