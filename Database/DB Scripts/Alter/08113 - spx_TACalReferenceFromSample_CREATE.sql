/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSample_CREATE]    Script Date: 06/27/2014 16:11:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromSample_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromSample_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSample_CREATE]    Script Date: 06/27/2014 16:11:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromSample_CREATE](
	@TACalTemplateID uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime
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
                         WHERE     (pSampleRequestWorkflowBOM.SampleRequestTradeID = @SampleRequestTradeID)) 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08113', GetDate())
GO