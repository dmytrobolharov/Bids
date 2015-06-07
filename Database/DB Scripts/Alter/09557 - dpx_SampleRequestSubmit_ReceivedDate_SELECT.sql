IF OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_ReceivedDate_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_ReceivedDate_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_ReceivedDate_SELECT]
(
	@DateTime datetime
)
AS

--Variables.
DECLARE @ShortDateString nvarchar(10)
DECLARE @ShortDateStringBeginning nvarchar(25)
DECLARE @ShortDateStringEnd nvarchar(25)

--Set date variable to a short date format.
SET @ShortDateString = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)

--Set two variables to the beginning and end of the date specified.
SET @ShortDateStringBeginning = @ShortDateString + ' 00:00:00.000'
SET @ShortDateStringEnd = @ShortDateString + ' 23:59:59.998'

--Get received samples for the specified date.
SELECT
	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
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
WHERE	(pSampleRequestSubmit.RecDate >= @ShortDateStringBeginning
		AND	pSampleRequestSubmit.RecDate <= @ShortDateStringEnd)
ORDER BY	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass),
	COALESCE(sr.SizeRangeCode, sh.SizeRange)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09557', GetDate())
GO
