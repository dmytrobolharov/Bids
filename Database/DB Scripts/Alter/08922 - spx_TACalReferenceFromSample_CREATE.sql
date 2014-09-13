/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSample_CREATE]    Script Date: 08/21/2014 15:57:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromSample_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromSample_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSample_CREATE]    Script Date: 08/21/2014 15:57:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_TACalReferenceFromSample_CREATE](
	@TACalTemplateID UNIQUEIDENTIFIER,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@ExistingRequest INT = 0
)
AS 
BEGIN
	DECLARE @FolderID INT
	DECLARE @TACalReferenceId UNIQUEIDENTIFIER = NEWID()

	SELECT @FolderID = PermissionFolderTypeId FROM sPermissionFolderType WHERE LOWER(PermissionFolderTypeName) = LOWER('Sample Folder')

	--add TACAlReference to current style
	INSERT INTO pTACalReference (TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
	VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @SampleRequestTradeID, @CUser, @CDate, @CUser, @CDate, 1)


	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, 
		TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	SELECT @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, 
		NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
	FROM pTACalTemplateTask tt
		INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	WHERE tw.WorkflowFolder = 'SAMPLE REQUEST' and tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1 
		AND tw.WorkflowId IN (
	SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM  pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
							 pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
							 WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
	UNION
	SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM pSampleRequestWorkflowBOM WITH (NOLOCK) INNER JOIN
							 pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
							 WHERE     (pSampleRequestWorkflowBOM.SampleRequestTradeID = @SampleRequestTradeID)
	) 

	IF @ExistingRequest = 1
	BEGIN
		-- update AssignedTo from calendar if it is empty
		UPDATE srw 
		SET AssignedTo = u.UserID
		FROM pSampleRequestWorkflowBOM srw
			INNER JOIN pSampleWorkflow ON srw.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			INNER JOIN pTACalReference r
					INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
					INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
					INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
				ON r.ReferenceId = @SampleRequestTradeID AND pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId
			LEFT JOIN vwx_UserGroupDropDown_SEL u ON rt.TaskAssignedToId = u.TeamID
		WHERE srw.SampleRequestTradeID = @SampleRequestTradeID AND (srw.AssignedTo = 0 OR srw.AssignedTo IS NULL)	
	END
	
	-- Updating corresponding calendars
	EXEC spx_TACalendar_SampleRequestWorkflowReferences_Progress_UPDATE @SampleRequestTradeID, NULL, @TACalTemplateID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08922', GetDate())
GO
