IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_StatusByStyleType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_StatusByStyleType_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_StatusByStyleType_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
)

AS

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END



SELECT  COUNT(*) AS COUNT, dbo.pSampleRequestSubmitStatus.StatusID, dbo.pSampleRequestSubmitStatus.Status, 
      dbo.pStyleType.StyleTypeDescription, dbo.pStyleType.StyleTypeID, dbo.pStyleSeasonYear.SeasonYearID
FROM dbo.pStyleType INNER JOIN
      dbo.pStyleHeader ON dbo.pStyleType.StyleTypeID = dbo.pStyleHeader.StyleType INNER JOIN
      (SELECT SampleRequestTradeID, Status FROM dbo.pSampleRequestWorkflow UNION SELECT SampleRequestTradeID, Status FROM dbo.pSampleRequestWorkflowBOM) AS pSampleRequestWorkflow INNER JOIN
      dbo.pSampleRequestSubmitStatus ON pSampleRequestWorkflow.Status = dbo.pSampleRequestSubmitStatus.StatusID INNER JOIN
      (SELECT SampleRequestTradeID, StyleID, StyleSeasonYearID FROM dbo.pSampleRequestTrade UNION SELECT SampleRequestTradeID, StyleID, StyleSeasonYearID FROM dbo.pSampleRequestBOMTrade) AS pSampleRequestTrade ON 
      pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN
      dbo.pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID ON 
      dbo.pStyleHeader.StyleID = pSampleRequestTrade.StyleID
WHERE (dbo.pStyleSeasonYear.SeasonYearID = @SeasonYearID)
GROUP BY dbo.pSampleRequestSubmitStatus.Status, dbo.pSampleRequestSubmitStatus.StatusID, dbo.pStyleSeasonYear.SeasonYearID, 
      dbo.pStyleType.StyleTypeDescription, dbo.pStyleType.StyleTypeID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06886', GetDate())
GO
