IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_StatusByAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_StatusByAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_StatusByAgent_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
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

SELECT  COUNT(*) AS COUNT, srw.TradePartnerID, dbo.uTradePartner.TradePartnerName, 
	CASE WHEN pSampleRequestSubmitStatus.StatusID = 0 AND srw.Submit <> 1 
		THEN 1
		ELSE pSampleRequestSubmitStatus.StatusID
	END AS StatusID, 
	
	CASE WHEN pSampleRequestSubmitStatus.StatusID = 0 AND srw.Submit <> 1 
		THEN 'Resubmit'
		ELSE pSampleRequestSubmitStatus.Status
	END AS Status
FROM  (
	SELECT TradePartnerID, Submit, Status, StyleId FROM pSampleRequestWorkflow
	UNION ALL
	SELECT TradePartnerID, Submit, Status, StyleId FROM pSampleRequestWorkflowBOM
) srw
INNER JOIN dbo.uTradePartner ON srw.TradePartnerID = dbo.uTradePartner.TradePartnerID 
INNER JOIN dbo.pSampleRequestSubmitStatus ON srw.Status = dbo.pSampleRequestSubmitStatus.StatusID
WHERE srw.StyleId IN (SELECT StyleID FROM #tempStyleSeasonYear)
GROUP BY 
	srw.TradePartnerID, 
	dbo.uTradePartner.TradePartnerName, 
	dbo.pSampleRequestSubmitStatus.Status, 
	dbo.pSampleRequestSubmitStatus.StatusID, 
	srw.Submit
ORDER BY TradePartnerName

DROP TABLE #tempStyleSeasonYear

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05423', GetDate())
GO
