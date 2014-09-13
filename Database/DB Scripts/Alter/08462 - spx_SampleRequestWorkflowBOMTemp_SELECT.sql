IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT](@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@SampleRequestGroupID uniqueidentifier)
AS 

SELECT     a.SampleRequestWorkflowID, a.SampleWorkflowID, a.SampleRequestGroupID, a.StyleID, 
           a.ItemDim1Id,a.ItemDim2Id,a.ItemDim3Id, a.StyleSet, a.Status, a.Submit, a.TechPackID, a.StartDate, 
           a.DueDate, a.EndDate, 
		   b.SampleWorkflow, b.SampleWorkflowSort, b.GroupName, 
		   a.AssignedTo,  a.SubmitDays, a.ResubmitDays , a.SampleWorkflowFinalDate,
		   0 as TACalTemplateTaskExists,
		   NULL as TaskPlanStart
FROM         dbo.pSampleRequestWorkflowBOMTemp a WITH (NOLOCK) INNER JOIN
                      dbo.pSampleWorkflow b WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE   a.StyleID = @StyleID  
AND a.StyleSet = @StyleSet
AND a.ItemDim1Id = @ItemDim1Id
AND a.ItemDim2Id = @ItemDim2Id
AND a.ItemDim3Id = @ItemDim3Id
AND a.SampleRequestGroupID = @SampleRequestGroupID
ORDER BY b.SampleWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08462', GetDate())
GO
