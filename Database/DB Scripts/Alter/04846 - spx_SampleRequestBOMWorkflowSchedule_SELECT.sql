IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflowSchedule_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSchedule_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSchedule_SELECT]
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
	pSampleRequestWorkflow.SampleWorkflowPartnerTypeID
FROM  pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK)
	INNER JOIN pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN pSampleRequestSubmitStatus ON pSampleRequestSubmitStatus.StatusID = pSampleRequestWorkflow.Status
WHERE (pSampleRequestWorkflow.StyleID = @StyleID) AND (pSampleRequestWorkflow.StyleSet = @StyleSet) 
AND (pSampleRequestWorkflow.ItemDim1Id = @ItemDim1Id) 
AND (pSampleRequestWorkflow.ItemDim2Id = @ItemDim2Id) 
AND (pSampleRequestWorkflow.ItemDim3Id = @ItemDim3Id) 
AND (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
ORDER BY pSampleWorkflow.SampleWorkflowSort



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04846', GetDate())
GO
