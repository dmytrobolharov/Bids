IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_SampleRequestWorkflowSchedule_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowSchedule_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowSchedule_SELECT]
(@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@StyleColorID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier)
AS 

SELECT
	pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
	pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.StyleID, 
	pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleSet, 
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
FROM  pSampleRequestWorkflow 
	INNER JOIN pSampleWorkflow ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN pSampleRequestSubmitStatus ON pSampleRequestSubmitStatus.StatusID = pSampleRequestWorkflow.Status
	INNER JOIN pSampleRequestSubmit ON pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID AND pSampleRequestWorkflow.Submit = pSampleRequestSubmit.Submit
	LEFT JOIN pTACalReference r
			INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
			INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
		ON r.ReferenceId = @SampleRequestTradeID AND pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId
WHERE (pSampleRequestWorkflow.StyleID = @StyleID) AND (pSampleRequestWorkflow.StyleSet = @StyleSet) 
AND (pSampleRequestWorkflow.StyleColorID = @StyleColorID) AND (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
ORDER BY pSampleWorkflow.SampleWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08525', GetDate())
GO
