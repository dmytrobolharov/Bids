IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromStyle_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromStyle_CREATE]
GO

CREATE PROCEDURE [dbo].[spx_TACalReferenceFromStyle_CREATE](
 @TACalTemplateID uniqueidentifier,
 @StyleID uniqueidentifier,
 @CUser nvarchar(100),
 @CDate datetime
)

AS 

DECLARE @FolderID integer
DECLARE @TACalReferenceId uniqueidentifier = newid()

SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Style Folder')
--add TACAlReference to current style
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @StyleID, @CUser, @CDate, @CUser, @CDate, 1)


DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pTACalTemplate INNER JOIN
pStyleSeasonYear ON pStyleSeasonYear.SeasonYearID = pTACalTemplate.SeasonYearId AND pStyleSeasonYear.StyleID = @styleID
 WHERE TACalTemplateId = @TACalTemplateID

INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pStyleWorkflow sw ON sw.WorkflowID = tw.WorkflowId AND sw.StyleID=@StyleID
where tw.WorkflowFolder='STYLE' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 AND (sw.StyleSeasonYearID = @StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL) and sw.StyleSet =1


INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
where tw.WorkflowFolder='STYLE TECHPACK' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1


UPDATE pStyleWorkflow SET pStyleWorkflow.WorkAssignedTo = u.UserID
FROM pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
LEFT JOIN vwx_UserGroupDropDown_SEL u ON tt.TaskAssignedToId = u.TeamID
where tw.WorkflowFolder='STYLE' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
AND (pStyleWorkflow.StyleSeasonYearID = @StyleSeasonYearID OR pStyleWorkflow.StyleSeasonYearID IS NULL) and pStyleWorkflow.StyleSet =1 
AND pStyleWorkflow.WorkflowID = tw.WorkflowId and pStyleWorkflow.StyleID = @StyleID AND (pStyleWorkflow.WorkAssignedTo = 0 OR pStyleWorkflow.WorkAssignedTo IS NULL)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08535', GetDate())
GO