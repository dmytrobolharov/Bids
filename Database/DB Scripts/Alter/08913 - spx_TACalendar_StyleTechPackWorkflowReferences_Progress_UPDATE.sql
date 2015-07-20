/****** Object:  StoredProcedure [dbo].[spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE]    Script Date: 08/20/2014 19:14:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE]    Script Date: 08/20/2014 19:14:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE]
	@StyleID UNIQUEIDENTIFIER = NULL,
	@StyleSeasonYearID UNIQUEIDENTIFIER = NULL,
	@TACalTemplateID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	DECLARE @TACalTemplateTaskID UNIQUEIDENTIFIER
	DECLARE @CountAll INT
	DECLARE @CountFinished INT

	DECLARE CursorTasks CURSOR SCROLL FOR 
	SELECT DISTINCT tt.TACalTemplateTaskID FROM pTACalTemplateTask tt 
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId AND UPPER(tw.WorkflowFolder) = 'STYLE TECHPACK'
	LEFT JOIN pTACalReferenceTask crt 
		INNER JOIN pTACalReference cr ON cr.TACalReferenceId = crt.TACalReferenceId
	ON crt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	WHERE (cr.TACalTemplateId = @TACalTemplateID OR @TACalTemplateID IS NULL) 
	AND (cr.ReferenceId = @StyleID OR @StyleID IS NULL)
	OPEN CursorTasks

	FETCH NEXT FROM CursorTasks INTO @TACalTemplateTaskID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @CountAll = COUNT(*) FROM vwx_TACalTemplateTask_ReferenceFromStyleTechPack_SELECT WHERE TACalTemplateTaskId = @TACalTemplateTaskID
		SELECT @CountFinished = COUNT(*) FROM vwx_TACalTemplateTask_ReferenceFromStyleTechPack_SELECT WHERE TACalTemplateTaskId = @TACalTemplateTaskID AND Ended = 1
		
		IF @CountAll = 0
			UPDATE pTACalTemplateTask SET TaskProgress = CAST(1 AS DECIMAL) WHERE TACalTemplateTaskId = @TACalTemplateTaskID
		ELSE
			UPDATE pTACalTemplateTask SET TaskProgress = CAST(@CountFinished AS DECIMAL)/CAST(@CountAll AS DECIMAL) WHERE TACalTemplateTaskId = @TACalTemplateTaskID
			
		FETCH NEXT FROM CursorTasks INTO @TACalTemplateTaskID
	END

	CLOSE CursorTasks
	DEALLOCATE CursorTasks
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08913', GetDate())
GO
