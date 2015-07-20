/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromStyle_CREATE]    Script Date: 08/21/2014 17:01:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromStyle_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromStyle_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromStyle_CREATE]    Script Date: 08/21/2014 17:01:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_TACalReferenceFromStyle_CREATE](
 @TACalTemplateID uniqueidentifier,
 @StyleID uniqueidentifier,
 @CUser nvarchar(100),
 @CDate datetime,
 @ForCreate int = 0
)

AS 
BEGIN

	DECLARE @FolderID integer
	DECLARE @TACalReferenceId UNIQUEIDENTIFIER = NEWID()

	SELECT @FolderID=PermissionFolderTypeId FROM sPermissionFolderType WHERE LOWER(PermissionFolderTypeName) = LOWER('Style Folder')
	--add TACAlReference to current style
	INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
	VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @StyleID, @CUser, @CDate, @CUser, @CDate, 1)


	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	DECLARE @SeasonYearId UNIQUEIDENTIFIER
	DECLARE @IntroSeasonYear UNIQUEIDENTIFIER
	SELECT @StyleSeasonYearID = StyleSeasonYearID, @SeasonYearId =  pTACalTemplate.SeasonYearId  FROM pTACalTemplate INNER JOIN
	pStyleSeasonYear ON pStyleSeasonYear.SeasonYearID = pTACalTemplate.SeasonYearId AND pStyleSeasonYear.StyleID = @styleID
	WHERE TACalTemplateId = @TACalTemplateID

	SELECT @IntroSeasonYear = IntroSeasonYearID FROM pStyleHeader WHERE StyleID = @StyleID


	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	INNER JOIN pStyleWorkflow sw ON sw.WorkflowID = tw.WorkflowId AND sw.StyleID=@StyleID
	where tw.WorkflowFolder='STYLE' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = @IntroSeasonYear) OR (tt.CarryOver = 1 AND @SeasonYearId <> @IntroSeasonYear)) AND (sw.StyleSeasonYearID = @StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL) and sw.StyleSet =1


	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	where tw.WorkflowFolder='STYLE TECHPACK' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = @IntroSeasonYear) OR (tt.CarryOver = 1 AND @SeasonYearId <> @IntroSeasonYear))
	--For Style bubles in TA Calendar update Assigned To

	UPDATE pStyleWorkflow SET pStyleWorkflow.WorkAssignedTo = u.UserID
	FROM pTACalTemplateTask  tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	LEFT JOIN vwx_UserGroupDropDown_SEL u ON tt.TaskAssignedToId = u.TeamID
	where tw.WorkflowFolder='STYLE' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
	AND (pStyleWorkflow.StyleSeasonYearID = @StyleSeasonYearID OR pStyleWorkflow.StyleSeasonYearID IS NULL) and pStyleWorkflow.StyleSet =1 
	AND pStyleWorkflow.WorkflowID = tw.WorkflowId and pStyleWorkflow.StyleID = @StyleID AND ((pStyleWorkflow.WorkAssignedTo = 0 OR pStyleWorkflow.WorkAssignedTo IS NULL) OR @ForCreate=1)

	--For TechPack buble in TA Calendar update Assigned To
	UPDATE pStyleTechPackStatus SET pStyleTechPackStatus.WorkAssignedTo = u.UserID
	FROM pTACalTemplateTask  tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	LEFT JOIN vwx_UserGroupDropDown_SEL u ON tt.TaskAssignedToId = u.TeamID
	where tw.WorkflowFolder='STYLE TECHPACK' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
	AND (pStyleTechPackStatus.StyleSeasonYearID = @StyleSeasonYearID OR pStyleTechPackStatus.StyleSeasonYearID IS NULL)
	AND pStyleTechPackStatus.StyleID = @StyleID AND (pStyleTechPackStatus.WorkAssignedTo = 0 OR pStyleTechPackStatus.WorkAssignedTo IS NULL)
	
	-- Updating correspondent calendar records
	EXEC spx_TACalendar_StyleWorkflowReferences_Progress_UPDATE NULL, @StyleID, NULL, @TACalTemplateID
	EXEC spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE @StyleID, NULL, @TACAlTemplateID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08929', GetDate())
GO
