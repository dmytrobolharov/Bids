IF OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_ResubmittedDate_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_ResubmittedDate_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_ResubmittedDate_SELECT]
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

--Create Temp table.
CREATE TABLE #tempResubmittedSamples
(
	TableRow int identity(1,1),
	SampleRequestWorkflowID uniqueidentifier,
	StyleID uniqueidentifier,
	SampleRequestTradeID uniqueidentifier,
	SampleWorkflowID nvarchar(5),
	Status int,
	Submit int,
	LastSubmittedNumber int
)

--Get records of samples that have been resubmitted.
INSERT INTO #tempResubmittedSamples(
	SampleRequestWorkflowID,
	StyleID,
	SampleRequestTradeID,
	SampleWorkflowID,
	Status,
	Submit)
SELECT
	SampleRequestWorkflowID,
	StyleID,
	SampleRequestTradeID,
	SampleWorkflowID,
	Status,
	Submit
FROM	pSampleRequestWorkflow
WHERE	Submit > 1

--Set the last submitted number to one less than the current submit number.
UPDATE	#tempResubmittedSamples
SET	LastSubmittedNumber = Submit - 1

--Get resubmitted samples for the specified date.
SELECT
	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
	COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
	pSampleRequestSubmitStatus.Status,
	pSampleRequestSubmit.MDate
FROM	pSampleRequestSubmit
	INNER JOIN #tempResubmittedSamples ON	(pSampleRequestSubmit.SampleRequestWorkflowID = #tempResubmittedSamples.SampleRequestWorkflowID
											AND	pSampleRequestSubmit.StyleID = #tempResubmittedSamples.StyleID
											AND	pSampleRequestSubmit.SampleRequestTradeID = #tempResubmittedSamples.SampleRequestTradeID
											AND	pSampleRequestSubmit.SampleWorkflowID = #tempResubmittedSamples.SampleWorkflowID
											AND	pSampleRequestSubmit.Submit <= #tempResubmittedSamples.LastSubmittedNumber)
	LEFT OUTER JOIN pSampleRequestSubmitStatus ON 	(pSampleRequestSubmit.Status = pSampleRequestSubmitStatus.StatusID)
	INNER JOIN pStyleHeader sh ON	(pSampleRequestSubmit.StyleID = sh.StyleID)
	LEFT OUTER JOIN uTradePartner ON	(pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID)
	LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE	(pSampleRequestSubmit.Status = 1)
	AND	(pSampleRequestSubmit.MDate >= @StringDateBegin
		AND	pSampleRequestSubmit.MDate <= @StringDateEnd)
ORDER BY	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass),
	COALESCE(sr.SizeRangeCode, sh.SizeRange)

--Drop Temp tables.
DROP TABLE #tempResubmittedSamples

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09560', GetDate())
GO
