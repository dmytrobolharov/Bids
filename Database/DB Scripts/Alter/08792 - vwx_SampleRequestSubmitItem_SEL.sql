IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitItem_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestSubmitItem_SEL]
GO


CREATE VIEW [dbo].[vwx_SampleRequestSubmitItem_SEL]
AS
	SELECT pSampleRequestSubmit.* , 
		pSampleRequestWorkflow.FinalDate, 
		CASE WHEN rt.TACalRefTaskId IS NULL THEN pSampleRequestWorkflow.SampleWorkflowFinalDate ELSE tt.TaskPlanEnd END AS SampleWorkflowFinalDate, 
		pSampleRequestSubmitStatus.Status AS StatusName
	FROM pSampleRequestSubmit
		INNER JOIN	pSampleRequestSubmitStatus ON pSampleRequestSubmit.Status = pSampleRequestSubmitStatus.StatusID
		INNER JOIN	pSampleRequestWorkflow ON pSampleRequestSubmit.SampleRequestWorkflowID = pSampleRequestWorkflow.SampleRequestWorkflowID 
		INNER JOIN	pSampleWorkflow ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
		LEFT JOIN pTACalReference r
				INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
				INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
			ON r.ReferenceId = pSampleRequestSubmit.SampleRequestTradeID AND pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08792', GetDate())
GO
