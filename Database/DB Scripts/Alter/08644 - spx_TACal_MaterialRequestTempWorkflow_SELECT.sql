IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_MaterialRequestTempWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_MaterialRequestTempWorkflow_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TACal_MaterialRequestTempWorkflow_SELECT]
	@MaterialRequestGroupID UNIQUEIDENTIFIER
	, @TACalTemplateID UNIQUEIDENTIFIER
AS
BEGIN

SELECT   pMaterialRequestTempWorkflow.MaterialRequestTempWorkflowID, pMaterialRequestTempWorkflow.MaterialRequestGroupID,
		 pMaterialRequestTempWorkflow.MaterialRequestWorkflowID, pMaterialRequestTempWorkflow.MaterialRequestWorkflowTemplateItemID,
		 pMaterialRequestTempWorkflow.Days, pMaterialRequestTempWorkflow.RDays,  ISNULL(dbo.pMaterialRequestTempWorkflow.AssignedTo, 0) AS AssignedTo,
		 pMaterialRequestTempWorkflow.DueDate, pMaterialRequestTempWorkflow.PartnerTypeID,
		 pMaterialRequestSubmitStatus.StatusID, pMaterialRequestSubmitStatus.Status,
		 pMaterialRequestWorkflow.MaterialRequestWorkflow, 
			'<IMG src=''' + '../System/Icons/' + dbo.pMaterialRequestSubmitStatus.StatusIcon + '''>' AS StatusUrl, 
			pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort AS Sort,
		 CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN 1 ELSE 0 END AS TACalTemplateTaskExists, 
		 tt.TaskPlanStart
FROM    pMaterialRequestTempWorkflow
			INNER JOIN pMaterialRequestWorkflowTemplateItem ON pMaterialRequestTempWorkflow.MaterialRequestWorkflowTemplateItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID
			INNER JOIN pMaterialRequestSubmitStatus ON pMaterialRequestTempWorkflow.Status = pMaterialRequestSubmitStatus.StatusID
			INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestTempWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
			LEFT JOIN dbo.pTACalTemplateTask tt WITH (NOLOCK)
				INNER JOIN dbo.pTATaskWorkflow tw WITH (NOLOCK) ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'MATERIAL REQUEST'
			ON tt.TACalTemplateId = @TACalTemplateID AND pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId
WHERE pMaterialRequestTempWorkflow.MaterialRequestGroupID = @MaterialRequestGroupID
ORDER BY Sort
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08644', GetDate())
GO
