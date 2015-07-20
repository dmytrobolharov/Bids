IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_SampleRequestBOMWorkflowSchedule_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_SampleRequestBOMWorkflowSchedule_SELECT]
GO


CREATE  PROCEDURE [dbo].[spx_TACal_SampleRequestBOMWorkflowSchedule_SELECT]
(@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@ItemDim1Id nvarchar(100) = null,
@ItemDim2Id nvarchar(100) = null,
@ItemDim3Id nvarchar(100) = null,
@SampleRequestTradeID uniqueidentifier)
AS 

if @ItemDim1Id = ''
begin
	set @ItemDim1Id = null
end 
if @ItemDim2Id = ''
begin
	set @ItemDim2Id = null
end 
if @ItemDim3Id = ''
begin
	set @ItemDim3Id = null
end 



SELECT
	pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
	pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.StyleID, 
	pSampleRequestWorkflow.ItemDim1Id,pSampleRequestWorkflow.ItemDim2Id,pSampleRequestWorkflow.ItemDim3Id, 
	pSampleRequestWorkflow.StyleSet, 
	CASE 
		WHEN pSampleRequestWorkflow.Status = 0  AND pSampleRequestWorkflow.Submit > 1 THEN 1
		ELSE pSampleRequestWorkflow.Status
	END 
	AS Status,  
	pSampleRequestWorkflow.Submit, pSampleRequestWorkflow.TechPackID, pSampleRequestWorkflow.StartDate, 
	pSampleRequestWorkflow.DueDate, pSampleRequestWorkflow.EndDate, pSampleWorkflow.SampleWorkflow, 
	pSampleWorkflow.SampleWorkflowSort, pSampleWorkflow.GroupName, pSampleRequestWorkflow.AssignedTo, 
	pSampleRequestWorkflow.SubmitDays, pSampleRequestWorkflow.ResubmitDays ,
	ISNULL(pSampleRequestWorkflow.SampleWorkflowFinalDate, pSampleRequestWorkflow.DueDate) AS SampleWorkflowFinalDate,
	pSampleRequestSubmitStatus.ApprovedType, pSampleRequestSubmitStatus.Status as StatusName, 
	pSampleRequestWorkflow.SampleWorkflowPartnerTypeID,
	r.TACalTemplateId, rt.TACalRefTaskId, tt.TACalTemplateTaskId,
	tt.TaskPlanStart as PlannedStart, tt.TaskPlanEnd as PlannedEnd, 
	rt.TaskRevisedlStart as RevisedStart, rt.TaskRevisedEnd as RevisedEnd,
	pSampleRequestSubmit.StartDate AS ActualStart, pSampleRequestSubmit.EndDate AS ActualEnd
FROM  pSampleRequestWorkflowBOM pSampleRequestWorkflow 
	INNER JOIN pSampleWorkflow ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN pSampleRequestSubmitStatus ON pSampleRequestSubmitStatus.StatusID = pSampleRequestWorkflow.Status
	INNER JOIN pSampleRequestSubmitBOM pSampleRequestSubmit ON pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID AND pSampleRequestWorkflow.Submit = pSampleRequestSubmit.Submit
	LEFT JOIN pTACalReference r
			INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
			INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
		ON r.ReferenceId = @SampleRequestTradeID AND pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId
WHERE (pSampleRequestWorkflow.StyleID = @StyleID) AND (pSampleRequestWorkflow.StyleSet = @StyleSet) 
AND (pSampleRequestWorkflow.ItemDim1Id = @ItemDim1Id) 
AND (pSampleRequestWorkflow.ItemDim2Id = @ItemDim2Id) 
AND (pSampleRequestWorkflow.ItemDim3Id = @ItemDim3Id) 
AND (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
ORDER BY pSampleWorkflow.SampleWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08547', GetDate())
GO
