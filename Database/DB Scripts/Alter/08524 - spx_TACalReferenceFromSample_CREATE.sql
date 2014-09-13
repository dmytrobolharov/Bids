IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromSample_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromSample_CREATE]
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromSample_CREATE](
	@TACalTemplateID uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime,
	@ExistingSamplemRequest int = 0
)

AS 

DECLARE @FolderID integer
DECLARE @TACalReferenceId uniqueidentifier = newid()

SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Sample Folder')
--add TACAlReference to current style
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @SampleRequestTradeID, @CUser, @CDate, @CUser, @CDate, 1)


INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
where tw.WorkflowFolder='SAMPLE REQUEST' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
AND tw.WorkflowId in (
SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM  pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
                         WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
UNION
SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM pSampleRequestWorkflowBOM WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
                         WHERE     (pSampleRequestWorkflowBOM.SampleRequestTradeID = @SampleRequestTradeID)
) 

IF @ExistingSamplemRequest = 0
BEGIN
	-- set EnableSampleRequestPages = 1 if sample calendar config = TRUE
	DECLARE @Config NVARCHAR(50)
	SELECT @Config = AppSettingValue from sAppSetting where AppSettingKey = 'EnableSampleRequestPages' 

	DECLARE @Value INT = 0
	SELECT @Value = 
	CASE 
		WHEN UPPER(@Config) = UPPER('FALSE') THEN 0 
		WHEN UPPER(@Config) = UPPER('TRUE') THEN 1 
	END 

	UPDATE pSampleRequestBOMTrade SET EnableSampleRequestPages = @Value WHERE SampleRequestTradeID = @SampleRequestTradeID
	UPDATE pSampleRequestTrade SET EnableSampleRequestPages = @Value WHERE SampleRequestTradeID = @SampleRequestTradeID
END
ELSE
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

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08524', GetDate())
GO
