IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_MaterialRequestSubmitWorkflow_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_MaterialRequestSubmitWorkflow_SEL]
GO


CREATE PROCEDURE [dbo].[spx_TACal_MaterialRequestSubmitWorkflow_SEL]
	@MaterialTradePartnerID UNIQUEIDENTIFIER
	, @MaterialTradePartnerColorID UNIQUEIDENTIFIER
	, @ShowOnlyTrackedPages int = 0
AS
BEGIN

SELECT pMaterialTradePartner.MaterialTradePartnerId, pMaterialTradePartner.SeasonYearID, 
          pMaterialTradePartner.MaterialRequestWorkflowTempID, pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID, 
          '<IMG src=''' + '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon + '''>' AS StatusUrl, 
          pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID, 
          pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID, pMaterialRequestSubmitWorkflow.MaterialID, 
          pMaterialRequestSubmitWorkflow.MaterialColorID, pMaterialRequestSubmitWorkflow.TradePartnerID, 
          pMaterialRequestSubmitWorkflow.TradePartnerVendorID, pMaterialRequestSubmitWorkflow.Submit, pMaterialRequestSubmitWorkflow.SubmitDays, 
          pMaterialRequestSubmitWorkflow.ResubmitDays, ISNULL(pMaterialRequestSubmitWorkflow.AssignedTo, 0) AS AssignedTo, 
          pMaterialRequestSubmitWorkflow.StartDate, pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate, 
          pMaterialRequestSubmitWorkflow.CUser, pMaterialRequestSubmitWorkflow.CDate, pMaterialRequestSubmitWorkflow.MUser, 
          pMaterialRequestSubmitWorkflow.MDate, pMaterialRequestSubmitWorkflow.TUser, pMaterialRequestSubmitWorkflow.TDate, 
          pMaterialRequestSubmitWorkflow.FinalDate, pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitStatus.StatusID, 
          pMaterialRequestSubmitStatus.Status, pMaterialRequestWorkflow.MaterialRequestWorkflowSort, pMaterialRequestSubmitWorkflow.Active, 
          pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowGroupID, pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort AS Sort, 
          pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors,
          pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID,
		  r.TACalTemplateId, rt.TACalRefTaskId, tt.TACalTemplateTaskId,
		  tt.TaskPlanStart as PlannedStart, tt.TaskPlanEnd as PlannedEnd, 
		  rt.TaskRevisedlStart as RevisedStart, rt.TaskRevisedEnd as RevisedEnd,
		  pMaterialRequestSubmitWorkflow.StartDate AS ActualStart, pMaterialRequestSubmitWorkflow.EndDate AS ActualEnd
FROM  pMaterialTradePartner 
			INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialTradePartner.MaterialTradePartnerId = pMaterialRequestSubmitWorkflow.MaterialTradePartnerID 
			INNER JOIN pMaterialRequestSubmitStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitStatus.StatusID 
			INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID 
			INNER JOIN pMaterialRequestWorkflowTemplateItem ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID 
			LEFT JOIN pTACalReference r
				INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
				INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
			ON r.ReferenceId = @MaterialTradePartnerID AND pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId
WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
		AND pMaterialRequestSubmitWorkflow.Active = 1
		AND ((@ShowOnlyTrackedPages = 1 AND rt.TACalRefTaskId IS NOT NULL) OR @ShowOnlyTrackedPages = 0)
ORDER BY MaterialRequestSubmitAllColors DESC, Sort

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08647', GetDate())
GO
