/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceTask_UPDATE]    Script Date: 08/10/2014 11:33:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceTask_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceTask_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceTask_UPDATE]    Script Date: 08/10/2014 11:33:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceTask_UPDATE](
	@TACalTemplateTaskID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime
)

AS 

DECLARE @FolderID integer
DECLARE @TACalTemplateID uniqueidentifier
DECLARE @WorkFlowFolder nvarchar(200)

SELECT TOP 1 @FolderID = cr.TACalReferenceTypeId FROM pTACalTemplateTask tt
INNER JOIN pTACalReferenceTask rt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
WHERE tt.TACalTemplateTaskId=@TACalTemplateTaskID

SELECT @TACalTemplateID = TACalTemplateId FROM pTACalTemplateTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

select @WorkFlowFolder = tw.WorkflowFolder from pTACalTemplateTask tt 
INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
WHERE tt.TACalTemplateTaskId=@TACalTemplateTaskID
--delete all old references to current task
DELETE FROM pTACalReferenceTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @SeasonYearID = SeasonYearID FROM pTACalTemplate 
	WHERE TACalTemplateId = @TACalTemplateID
 
if UPPER(@WorkFlowFolder) = 'STYLE'
begin

 
INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pStyleWorkflow sw ON sw.WorkflowID = tw.WorkflowId AND sw.StyleID=cr.ReferenceId
INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = cr.ReferenceId and ssy.SeasonYearID = @SeasonYearID
INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId 
where tw.WorkflowFolder='STYLE' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = sh.IntroSeasonYearID) OR (tt.CarryOver = 1 AND @SeasonYearId <> sh.IntroSeasonYearID)) AND (sw.StyleSeasonYearID = ssy.StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL) and sw.StyleSet =1 and tt.TACalTemplateTaskId = @TACalTemplateTaskID 

end



if UPPER(@WorkFlowFolder) = 'STYLE TECHPACK'
begin

INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = cr.ReferenceId and ssy.SeasonYearID = @SeasonYearID
INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId 
where tw.WorkflowFolder='STYLE TECHPACK' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = sh.IntroSeasonYearID) OR (tt.CarryOver = 1 AND @SeasonYearId <> sh.IntroSeasonYearID))
end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08706', GetDate())
GO