IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestBOMSubmitItem_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]
GO


CREATE VIEW [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]
AS
	SELECT pSampleRequestSubmitBOM.*, 
		pSampleRequestWorkflowBOM.FinalDate, 
		CASE WHEN rt.TACalRefTaskId IS NULL THEN pSampleRequestWorkflowBOM.SampleWorkflowFinalDate ELSE tt.TaskPlanEnd END AS SampleWorkflowFinalDate, 
		pSampleRequestSubmitStatus.Status AS 'StatusName'
	FROM pSampleRequestSubmitBOM 
		INNER JOIN	pSampleRequestSubmitStatus ON pSampleRequestSubmitBOM.Status = pSampleRequestSubmitStatus.StatusID
		INNER JOIN	pSampleRequestWorkflowBOM ON pSampleRequestSubmitBOM.SampleRequestWorkflowID = pSampleRequestWorkflowBOM.SampleRequestWorkflowID 
		INNER JOIN	pSampleWorkflow ON pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
		LEFT JOIN pTACalReference r
				INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
				INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
			ON r.ReferenceId = pSampleRequestSubmitBOM.SampleRequestTradeID AND pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08793', GetDate())
GO
