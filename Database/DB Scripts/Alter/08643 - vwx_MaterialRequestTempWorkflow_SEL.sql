IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialRequestTempWorkflow_SEL]'))
DROP VIEW [dbo].[vwx_MaterialRequestTempWorkflow_SEL]
GO


CREATE VIEW [dbo].[vwx_MaterialRequestTempWorkflow_SEL]
AS
SELECT   pMaterialRequestTempWorkflow.MaterialRequestTempWorkflowID, pMaterialRequestTempWorkflow.MaterialRequestGroupID,
		 pMaterialRequestTempWorkflow.MaterialRequestWorkflowID, pMaterialRequestTempWorkflow.MaterialRequestWorkflowTemplateItemID,
		 pMaterialRequestTempWorkflow.Days, pMaterialRequestTempWorkflow.RDays,  ISNULL(dbo.pMaterialRequestTempWorkflow.AssignedTo, 0) AS AssignedTo,
		 pMaterialRequestTempWorkflow.DueDate, pMaterialRequestTempWorkflow.PartnerTypeID,
		 pMaterialRequestSubmitStatus.StatusID, pMaterialRequestSubmitStatus.Status,
		 pMaterialRequestWorkflow.MaterialRequestWorkflow, 
			'<IMG src=''' + '../System/Icons/' + dbo.pMaterialRequestSubmitStatus.StatusIcon + '''>' AS StatusUrl, 
		 pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort AS Sort, 
		 0 as TACalTemplateTaskExists, NULL as TaskPlanStart
FROM   pMaterialRequestTempWorkflow
			INNER JOIN pMaterialRequestWorkflowTemplateItem ON pMaterialRequestTempWorkflow.MaterialRequestWorkflowTemplateItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID
			INNER JOIN pMaterialRequestSubmitStatus ON pMaterialRequestTempWorkflow.Status = pMaterialRequestSubmitStatus.StatusID
			INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestTempWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08643', GetDate())
GO
