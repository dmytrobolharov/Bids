/****** Object:  StoredProcedure [dbo].[spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE]    Script Date: 09/19/2014 14:43:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE]    Script Date: 09/19/2014 14:43:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE]
	@MaterialTemplatePageID UNIQUEIDENTIFIER = NULL,
	@MaterialID UNIQUEIDENTIFIER = NULL,
	@TACalTemplateID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	DECLARE @TACalTemplateTaskID UNIQUEIDENTIFIER
	DECLARE @CountAll INT
	DECLARE @CountFinished INT

	DECLARE CursorTasks CURSOR SCROLL FOR 
	SELECT DISTINCT tt.TACalTemplateTaskID FROM pTACalTemplateTask tt 
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId AND UPPER(tw.WorkflowFolder) = 'MATERIAL'
	LEFT JOIN pTACalReferenceTask crt 
		INNER JOIN pTACalReference cr ON cr.TACalReferenceId = crt.TACalReferenceId
	ON crt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	WHERE (tt.TACalTemplateId = @TACalTemplateID OR @TACalTemplateID IS NULL) 
	AND (cr.ReferenceId = @MaterialID OR @MaterialID IS NULL)
	AND (tw.WorkflowId = @MaterialTemplatePageID OR @MaterialTemplatePageID IS NULL)

	OPEN CursorTasks

	FETCH NEXT FROM CursorTasks INTO @TACalTemplateTaskID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @CountAll = COUNT(*) FROM vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT WHERE TACalTemplateTaskId = @TACalTemplateTaskID
		SELECT @CountFinished = COUNT(*) FROM vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT WHERE TACalTemplateTaskId = @TACalTemplateTaskID AND Ended = 1
		
		IF @CountAll = 0
			UPDATE pTACalTemplateTask SET TaskProgress = CAST(0 AS DECIMAL) WHERE TACalTemplateTaskId = @TACalTemplateTaskID
		ELSE
			UPDATE pTACalTemplateTask SET TaskProgress = CAST(@CountFinished AS DECIMAL)/CAST(@CountAll AS DECIMAL) WHERE TACalTemplateTaskId = @TACalTemplateTaskID
			
		-- Updating the parent "event" of this task
		EXEC spx_TACalendar_EventProgress_UPDATE @TACalTemplateTaskID
			
		FETCH NEXT FROM CursorTasks INTO @TACalTemplateTaskID
	END

	CLOSE CursorTasks
	DEALLOCATE CursorTasks
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09123', GetDate())
GO