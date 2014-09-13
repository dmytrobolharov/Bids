/****** Object:  StoredProcedure [dbo].[spx_TACalendar_ImageWorkflowReferences_Progress_UPDATE]    Script Date: 08/14/2014 12:00:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_ImageWorkflowReferences_Progress_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_ImageWorkflowReferences_Progress_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_ImageWorkflowReferences_Progress_UPDATE]    Script Date: 08/14/2014 12:00:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TACalendar_ImageWorkflowReferences_Progress_UPDATE]
	@ImageWorkflowTemplateItemID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @TACalTemplateTaskID UNIQUEIDENTIFIER
	DECLARE @CountAll INT
	DECLARE @CountFinished INT

	DECLARE CursorTasks CURSOR SCROLL FOR 
	SELECT TACalTemplateTaskId 
	FROM vwx_TACalTemplateTask_ReferenceFromImage_SELECT 
	WHERE WorkflowId=@ImageWorkflowTemplateItemID
	AND ImageID=@ImageID

	OPEN CursorTasks

	FETCH NEXT FROM CursorTasks INTO @TACalTemplateTaskID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @CountAll = COUNT(*) FROM vwx_TACalTemplateTask_ReferenceFromImage_SELECT WHERE TACalTemplateTaskId = @TACalTemplateTaskID
		SELECT @CountFinished = COUNT(*) FROM vwx_TACalTemplateTask_ReferenceFromImage_SELECT WHERE TACalTemplateTaskId = @TACalTemplateTaskID AND Ended = 1
		
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
VALUES ('DB_Version', '6.0.0000', '08845', GetDate())
GO
