/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_CalendarReference_UPDATE]    Script Date: 08/21/2014 17:13:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_CalendarReference_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_CalendarReference_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_CalendarReference_UPDATE]    Script Date: 08/21/2014 17:13:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleWorkflow_CalendarReference_UPDATE] (
	@StyleID uniqueidentifier,
	@WorkflowTemplateID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime
	)
AS
BEGIN

	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
	from pTACalTemplateTask  tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
	INNER JOIN pTACalTemplate ct ON tt.TACalTemplateId = ct.TACalTemplateId
	INNER JOIN pStyleWorkflow sw ON sw.WorkflowID = tw.WorkflowId AND sw.StyleID=cr.ReferenceId
	INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = cr.ReferenceId and ssy.SeasonYearID = ct.SeasonYearId
	INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId 
	where tw.WorkflowFolder='STYLE' and sh.StyleID = @StyleID  
	and ((tt.New=1 AND ct.SeasonYearId = sh.IntroSeasonYearID) OR (tt.CarryOver = 1 AND ct.SeasonYearId <> sh.IntroSeasonYearID)) AND (sw.StyleSeasonYearID = ssy.StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL) 
	and sw.StyleSet =1 
	AND tt.TACalTemplateTaskId not in (select tempref.TACalTemplateTaskId from pTACalReferenceTask tempref where tempref.TACalReferenceId = cr.TACalReferenceId)

	delete rt from pTACalReferenceTask rt
	INNER JOIN pTACalReference cr ON rt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pTACalTemplateTask tt ON tt.TACalTemplateTaskId = rt.TACalTemplateTaskId
	iNNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	where cr.ReferenceId=@StyleID AND tw.WorkflowFolder='STYLE' and tw.WorkflowId not in (select sw.WorkflowId from vwx_StyleWorkflowCalendarItems sw WHERE sw.StyleID = @StyleID AND sw.WorkflowTemplateID = @WorkflowTemplateID )

	EXEC spx_TACalendar_StyleWorkflowReferences_Progress_UPDATE NULL, NULL, NULL, NULL
	EXEC spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE NULL, NULL, NULL

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08928', GetDate())
GO
