IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialRequestSubmit_SEL]'))
DROP VIEW [dbo].[vwx_MaterialRequestSubmit_SEL]
GO


CREATE VIEW [dbo].[vwx_MaterialRequestSubmit_SEL]
AS
SELECT pMaterialRequestSubmit.*, 
	CASE WHEN rt.TACalRefTaskId IS NULL THEN pMaterialRequestSubmitWorkflow.SampleWorkflowFinalDate ELSE tt.TaskPlanEnd END AS SampleWorkflowFinalDate
FROM pMaterialRequestSubmit
	INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID
	INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
	LEFT JOIN pTACalReference r
			INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
			INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
		ON r.ReferenceId = pMaterialRequestSubmit.MaterialTradePartnerID AND pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08798', GetDate())
GO
