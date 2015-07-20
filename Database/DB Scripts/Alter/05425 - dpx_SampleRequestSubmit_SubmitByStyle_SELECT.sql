IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_SubmitByStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_SubmitByStyle_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_SubmitByStyle_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL,
	@TradePartnerID uniqueidentifier
)

AS

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END

CREATE TABLE #tempStyleSeasonYear(
	StyleID uniqueidentifier,
	SeasonYearID uniqueidentifier
)

INSERT INTO #tempStyleSeasonYear (StyleID, SeasonYearID)
SELECT StyleID, SeasonYearID FROM pStyleSeasonYear 
WHERE SeasonYearID = @SeasonYearID

SELECT TOP (100) PERCENT COUNT(*) AS COUNT, dbo.pSampleWorkflow.SampleWorkflow, 
	CASE WHEN pSampleRequestSubmitStatus.StatusID = 0 AND srw.Submit <> 1 
		THEN 1
		ELSE pSampleRequestSubmitStatus.StatusID
	END AS StatusID, 
	
	CASE WHEN pSampleRequestSubmitStatus.StatusID = 0 AND srw.Submit <> 1 
		THEN 'Resubmit'
		ELSE pSampleRequestSubmitStatus.Status
	END AS Status, dbo.pStyleHeader.StyleNo, 	
	dbo.pStyleHeader.Description,  srw.Submit, srw.SampleWorkflowID, 
	dbo.pStyleHeader.StyleID
FROM (
	SELECT TradePartnerID, Submit, Status, StyleId, SampleWorkflowID FROM pSampleRequestWorkflow
	UNION ALL
	SELECT TradePartnerID, Submit, Status, StyleId, SampleWorkflowID FROM pSampleRequestWorkflowBOM
) srw
INNER JOIN dbo.pSampleWorkflow ON srw.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID
INNER JOIN dbo.pSampleRequestSubmitStatus ON srw.Status = dbo.pSampleRequestSubmitStatus.StatusID 
INNER JOIN dbo.pStyleHeader ON srw.StyleID = dbo.pStyleHeader.StyleID
WHERE srw.StyleId IN (SELECT StyleID FROM #tempStyleSeasonYear) AND  (srw.TradePartnerID = @TradePartnerID)
GROUP BY 
	dbo.pSampleWorkflow.SampleWorkflow, 
	dbo.pSampleRequestSubmitStatus.Status, 
	dbo.pSampleRequestSubmitStatus.StatusID, 
	srw.TradePartnerID, 
	dbo.pStyleHeader.StyleNo, 
	srw.Submit, 
	srw.SampleWorkflowID,
	dbo.pStyleHeader.Description, 
	dbo.pStyleHeader.StyleID
ORDER BY pStyleHeader.StyleNo, srw.SampleWorkflowID

DROP TABLE #tempStyleSeasonYear

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05425', GetDate())
GO
