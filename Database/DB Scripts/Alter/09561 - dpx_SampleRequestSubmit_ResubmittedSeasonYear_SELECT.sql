IF OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_ResubmittedSeasonYear_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_ResubmittedSeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_ResubmittedSeasonYear_SELECT]
(
	@Season nvarchar(200),
	@Year nvarchar(200)
)
AS

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

--Get records of samples that have been resubmitted for the specified season and/or year.
IF((@Season IS NULL OR @Season = '') AND (@Year IS NULL OR @Year = ''))	--Look for all resubmitted samples.
	BEGIN	
		INSERT INTO #tempResubmittedSamples(
			SampleRequestWorkflowID,
			StyleID,
			SampleRequestTradeID,
			SampleWorkflowID,
			Status,
			Submit)
		SELECT
			pSampleRequestWorkflow.SampleRequestWorkflowID,
			pSampleRequestWorkflow.StyleID,
			pSampleRequestWorkflow.SampleRequestTradeID,
			pSampleRequestWorkflow.SampleWorkflowID,
			pSampleRequestWorkflow.Status,
			pSampleRequestWorkflow.Submit
		FROM	pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
		WHERE	Submit > 1
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NULL OR @Year = ''))	--Look for all approved samples just by season.
	BEGIN	
		INSERT INTO #tempResubmittedSamples(
			SampleRequestWorkflowID,
			StyleID,
			SampleRequestTradeID,
			SampleWorkflowID,
			Status,
			Submit)
		SELECT
			pSampleRequestWorkflow.SampleRequestWorkflowID,
			pSampleRequestWorkflow.StyleID,
			pSampleRequestWorkflow.SampleRequestTradeID,
			pSampleRequestWorkflow.SampleWorkflowID,
			pSampleRequestWorkflow.Status,
			pSampleRequestWorkflow.Submit
		FROM	pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
		WHERE	Submit > 1
			AND	(sh.CustomField2 = @Season)
	END
ELSE IF((@Season IS NULL OR @Season = '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all approved samples just by year.
	BEGIN	
		INSERT INTO #tempResubmittedSamples(
			SampleRequestWorkflowID,
			StyleID,
			SampleRequestTradeID,
			SampleWorkflowID,
			Status,
			Submit)
		SELECT
			pSampleRequestWorkflow.SampleRequestWorkflowID,
			pSampleRequestWorkflow.StyleID,
			pSampleRequestWorkflow.SampleRequestTradeID,
			pSampleRequestWorkflow.SampleWorkflowID,
			pSampleRequestWorkflow.Status,
			pSampleRequestWorkflow.Submit
		FROM	pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
		WHERE	Submit > 1
			AND	(sh.CustomField4 = @Year)
	END
ELSE IF((@Season IS NOT NULL AND @Season <> '') AND (@Year IS NOT NULL AND @Year <> ''))	--Look for all approved samples by season and year.
	BEGIN	
		INSERT INTO #tempResubmittedSamples(
			SampleRequestWorkflowID,
			StyleID,
			SampleRequestTradeID,
			SampleWorkflowID,
			Status,
			Submit)
		SELECT
			pSampleRequestWorkflow.SampleRequestWorkflowID,
			pSampleRequestWorkflow.StyleID,
			pSampleRequestWorkflow.SampleRequestTradeID,
			pSampleRequestWorkflow.SampleWorkflowID,
			pSampleRequestWorkflow.Status,
			pSampleRequestWorkflow.Submit
		FROM	pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
		WHERE	Submit > 1
			AND	(sh.CustomField2 = @Season)
			AND	(sh.CustomField4 = @Year)
	END

--Set the last submitted number to one less than the current submit number.
UPDATE	#tempResubmittedSamples
SET	LastSubmittedNumber = Submit - 1

--Get resubmitted samples for the season/year items.
SELECT
	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.CustomField2 AS Season,
	sh.CustomField4 AS [Year],
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
ORDER BY		sh.CustomField4,
	sh.CustomField2,
	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass),
	COALESCE(sr.SizeRangeCode, sh.SizeRange)

--Drop Temp tables.
DROP TABLE #tempResubmittedSamples

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09561', GetDate())
GO
