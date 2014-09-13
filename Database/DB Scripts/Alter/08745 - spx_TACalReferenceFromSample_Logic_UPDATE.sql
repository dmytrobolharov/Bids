IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromSample_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromSample_Logic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromSample_Logic_UPDATE](
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS 

DECLARE @CalReferences TABLE(
	ROW INT IDENTITY(1, 1),
	TACalReferenceId UNIQUEIDENTIFIER,
	TACalTemplateId UNIQUEIDENTIFIER)
	
INSERT INTO @CalReferences(TACalReferenceId, TACalTemplateId)
SELECT TACalReferenceId, TACalTemplateId 
FROM pTACalReference WHERE ReferenceId = @SampleRequestTradeID

DECLARE @ROW INT = 1,
		@TOTAL INT = (SELECT COUNT(*) FROM @CalReferences)
		
WHILE @ROW <= @TOTAL
BEGIN
	DECLARE @TACalReferenceId UNIQUEIDENTIFIER,
			@TACalTemplateId UNIQUEIDENTIFIER
	SELECT @TACalReferenceId = TACalReferenceId,
		@TACalTemplateId = TACalTemplateId
	FROM @CalReferences WHERE ROW = @ROW


	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, 
		TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	SELECT @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, 
		NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
	FROM pTACalTemplateTask tt
		INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
		LEFT JOIN pTACalReferenceTask rt ON tt.TACalTemplateTaskId = rt.TACalTemplateTaskId AND rt.TACalReferenceId = @TACalReferenceId
	WHERE tw.WorkflowFolder = 'SAMPLE REQUEST' and tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1 
	AND rt.TACalReferenceId IS NULL
	AND tw.WorkflowId IN (
	SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM  pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
							 pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
							 WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
	UNION
	SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM pSampleRequestWorkflowBOM WITH (NOLOCK) INNER JOIN
							 pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
							 WHERE     (pSampleRequestWorkflowBOM.SampleRequestTradeID = @SampleRequestTradeID)
	) 

	
	IF EXISTS(SELECT * FROM pSampleRequestBOMTrade WHERE SampleRequestTradeID = @SampleRequestTradeID)
	BEGIN
		UPDATE srw SET AssignedTo = ug.UserID
		FROM pSampleRequestWorkflowBOM srw
		INNER JOIN pSampleWorkflow ON srw.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
		INNER JOIN pTACalReferenceTask rt 
			INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId 
			ON pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId AND rt.TACalReferenceId = @TACalReferenceId
		INNER JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
		WHERE srw.SampleRequestTradeID = @SampleRequestTradeID 
			AND (srw.AssignedTo IS NULL OR srw.AssignedTo = 0)
	END
	ELSE
	BEGIN
		UPDATE srw SET AssignedTo = ug.UserID
		FROM pSampleRequestWorkflow srw
		INNER JOIN pSampleWorkflow ON srw.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
		INNER JOIN pTACalReferenceTask rt 
			INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId 
			ON pSampleWorkflow.SampleWorkflowGUID = tw.WorkflowId AND rt.TACalReferenceId = @TACalReferenceId
		INNER JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
		WHERE srw.SampleRequestTradeID = @SampleRequestTradeID 
			AND (srw.AssignedTo IS NULL OR srw.AssignedTo = 0)
	END

	SET @ROW = @ROW + 1
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08745', GetDate())
GO
