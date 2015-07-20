IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_MaterialRequestSubmit_SubmitByAgent_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[dpx_MaterialRequestSubmit_SubmitByAgent_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_MaterialRequestSubmit_SubmitByAgent_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL,
	@TradePartnerID uniqueidentifier = NULL
)

AS

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END


BEGIN
	SELECT COUNT(*) AS COUNT, pMaterialRequestWorkflow.MaterialRequestWorkflow, 
	CASE WHEN pMaterialRequestSubmitStatus.StatusID = 0 AND 
		pMaterialRequestSubmitWorkflow.Submit <> 1 THEN 1 ELSE pMaterialRequestSubmitStatus.StatusID END AS StatusID, 
	CASE WHEN pMaterialRequestSubmitStatus.StatusID = 0 AND 
		pMaterialRequestSubmitWorkflow.Submit <> 1 THEN 'Resubmit' ELSE pMaterialRequestSubmitStatus.Status END AS Status,
		pMaterialRequestWorkflow.MaterialRequestWorkflowSort
		,pMaterialRequestWorkflow.MaterialRequestWorkflowId
	FROM pMaterialRequestSubmitWorkflow INNER JOIN
		pMaterialRequestWorkflow ON 
		pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
		pMaterialRequestSubmitStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitStatus.StatusID INNER JOIN
		pMaterialTradePartner ON 
		pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId
	WHERE (pMaterialTradePartner.SeasonYearID = @SeasonYearID)  AND  (dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerID)
	GROUP BY pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitStatus.Status, pMaterialRequestSubmitStatus.StatusID, 
		pMaterialRequestSubmitWorkflow.TradePartnerID, pMaterialRequestSubmitWorkflow.Submit, pMaterialRequestWorkflow.MaterialRequestWorkflowSort
		,pMaterialRequestWorkflow.MaterialRequestWorkflowId
	ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort, StatusID
END

--
--CREATE TABLE #tempStyleSeasonYear(
--	MaterialID uniqueidentifier,
--	SeasonYearID uniqueidentifier
--)
--
--INSERT INTO #tempStyleSeasonYear (MaterialID, SeasonYearID)
--SELECT MaterialID, SeasonYearID FROM pMaterialSeasonYear 
--WHERE SeasonYearID = @SeasonYearID
--
--SELECT COUNT(*) AS COUNT, pMaterialRequestWorkflow.MaterialRequestWorkflow, 
--	CASE WHEN pMaterialRequestSubmitStatus.StatusID = 0 AND pMaterialRequestSubmitWorkflow.Submit <> 1 THEN 1
--	ELSE pMaterialRequestSubmitStatus.StatusID
--	END AS StatusID, 
--	CASE WHEN pMaterialRequestSubmitStatus.StatusID = 0 AND pMaterialRequestSubmitWorkflow.Submit <> 1 THEN 'Resubmit'
--	ELSE pMaterialRequestSubmitStatus.Status
--	END AS Status
--FROM         pMaterialRequestSubmitWorkflow INNER JOIN
--                      pMaterialRequestWorkflow ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
--                      pMaterialRequestSubmitStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitStatus.StatusID
--WHERE pMaterialRequestSubmitWorkflow.MaterialID IN (SELECT MaterialID FROM #tempStyleSeasonYear) AND  (pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerID)
--GROUP BY pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitStatus.Status, pMaterialRequestSubmitStatus.StatusID, 
--                      pMaterialRequestSubmitWorkflow.TradePartnerID, pMaterialRequestSubmitWorkflow.Submit  
--ORDER BY pMaterialRequestSubmitStatus.StatusID
--
--
--DROP TABLE #tempStyleSeasonYear
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01454', GetDate())
GO