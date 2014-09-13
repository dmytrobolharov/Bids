IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_SampleRequestWorkflowBOMTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowBOMTemp_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowBOMTemp_SELECT](
@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@SampleRequestGroupID uniqueidentifier,
@TACalTemplateID uniqueidentifier
)
AS 

SELECT     a.SampleRequestWorkflowID, a.SampleWorkflowID, a.SampleRequestGroupID, a.StyleID, 
           a.ItemDim1Id,a.ItemDim2Id,a.ItemDim3Id, a.StyleSet, a.Status, a.Submit, a.TechPackID, a.StartDate, 
           a.DueDate, a.EndDate, 
		   b.SampleWorkflow, b.SampleWorkflowSort, b.GroupName, 
		   a.AssignedTo,  a.SubmitDays, a.ResubmitDays , a.SampleWorkflowFinalDate, 
		   CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN 1 ELSE 0 END AS TACalTemplateTaskExists, 
		   tt.TaskPlanStart
FROM   dbo.pSampleRequestWorkflowBOMTemp a WITH (NOLOCK) INNER JOIN
       dbo.pSampleWorkflow b WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID 
        LEFT JOIN dbo.pTACalTemplateTask tt WITH (NOLOCK)
			INNER JOIN dbo.pTATaskWorkflow tw WITH (NOLOCK) ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'SAMPLE REQUEST'
		ON tt.TACalTemplateId = @TACalTemplateID AND b.SampleWorkflowGUID = tw.WorkflowId
WHERE  a.StyleID = @StyleID  
AND a.StyleSet = @StyleSet
AND a.ItemDim1Id = @ItemDim1Id
AND a.ItemDim2Id = @ItemDim2Id
AND a.ItemDim3Id = @ItemDim3Id
AND a.SampleRequestGroupID = @SampleRequestGroupID
ORDER BY b.SampleWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08463', GetDate())
GO
