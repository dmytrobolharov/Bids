IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowBOMTempWithAccessRestrictions_INSERT]
(@SampleWorkflowTempID uniqueidentifier,
@SampleScheduleType nvarchar(50),
@SampleRequestGroupID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@StyleSet2 nvarchar(50) = null,
@StyleSet3 nvarchar(50) = null,
@StyleSet4 nvarchar(50) = null,
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StartDate DateTime,
@EndDate DateTime,
@CreatedBy nvarchar(200),
@CreatedDate DateTime, 
@TeamID uniqueidentifier,
@TACalTemplateID uniqueidentifier
)
AS 

	UPDATE pSampleRequestSetItemTemp
	SET  SampleWorkflowTempID = @SampleWorkflowTempID, 
	SampleScheduleType = @SampleScheduleType, 
	StartDate = @StartDate,
	EndDate = @EndDate, 
	MUser = @CreatedBy, 
	MDate = @CreatedDate 
	WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestGroupID = @SampleRequestGroupID

	DELETE FROM pSampleRequestWorkflowBOMTemp WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestGroupID = @SampleRequestGroupID	

	INSERT INTO dbo.pSampleRequestWorkflowBOMTemp
		(SampleWorkflowTempItemID, SampleRequestGroupID, SampleWorkflowID, AssignedTo, Submit, 
		Status, SubmitDays, ResubmitDays, StyleID, StyleSet, ItemDim1Id,ItemDim2Id,ItemDim3Id, 
		CUser, MUser, CDate, MDate, SampleWorkflowFinalDate, StartDate, DueDate, SampleWorkflowPartnerTypeID)
	SELECT SampleWorkflowTempItemID, @SampleRequestGroupID, pSampleWorkflowItemTemplate.SampleWorkflowID, 
	CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN ug.UserID ELSE pSampleWorkflowItemTemplate.SampleWorkflowAssignedTo END AS AssignedTo, 
	1, 1, SampleWorkflowDays, SampleWorkflowRDays, @StyleID AS StyleID, @StyleSet AS StyleSet, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', 
	@CreatedBy AS CUser, @CreatedBy AS MUser, @CreatedDate AS Cdate, @CreatedDate AS MDate, 
	CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN tt.TaskPlanEnd ELSE NULL END AS SampleWorkflowFinalDate, 
	@StartDate AS StartDate, 
	CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN DATEADD(Day, SampleWorkflowDays, tt.TaskPlanStart) ELSE NULL END AS DueDate, 
	SampleWorkflowPartnerTypeID
	FROM pSampleWorkflowItemTemplate
		INNER JOIN pSampleWorkflow ON pSampleWorkflowItemTemplate.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
        LEFT JOIN pTACalTemplateTask tt 
			INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'SAMPLE REQUEST'
		ON tt.TACalTemplateId = @TACalTemplateID AND dbo.pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId
		LEFT JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
	WHERE (SampleWorkflowTempID = @SampleWorkflowTempID)
	ORDER BY pSampleWorkflowItemTemplate.SampleWorkflowSort	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08464', GetDate())
GO
