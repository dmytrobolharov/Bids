IF OBJECT_ID(N'[dbo].[dpx_SampleRequestWorkflow_ApprovedDate_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestWorkflow_ApprovedDate_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestWorkflow_ApprovedDate_SELECT]
(
	@DateTime datetime
)
AS

--Variables.
DECLARE @ShortStringDate nvarchar(10)
DECLARE @StringDateBegin nvarchar(25)
DECLARE @StringDateEnd nvarchar(25)

--Set date variable to a short date format.
SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)

--Set two variables to the beginning and end of the date specified.
SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'
SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998'

--Get approved samples for the specified date.
SELECT
	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
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
	AND	(pSampleRequestWorkflow.EndDate >= @StringDateBegin
		AND	pSampleRequestWorkflow.EndDate <= @StringDateEnd)
ORDER BY	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass),
	COALESCE(sr.SizeRangeCode, sh.SizeRange)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09564', GetDate())
GO
