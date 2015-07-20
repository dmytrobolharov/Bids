/****** Object:  StoredProcedure [dbo].[spx_TACalendar_EventProgress_UPDATE]    Script Date: 09/02/2014 11:38:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_EventProgress_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_EventProgress_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_EventProgress_UPDATE]    Script Date: 09/02/2014 11:38:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TACalendar_EventProgress_UPDATE]
	@TACalTemplateTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @TACalTemplateTaskID IS NULL
		RETURN
	
	-- Getting the info about current template task
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	DECLARE @TACurrentTaskWorkflowID UNIQUEIDENTIFIER
	DECLARE @CurrentLevel INT
	DECLARE @CurrentTaskID INT
	
	SELECT @CurrentLevel = [level], @CurrentTaskID = TaskId, @TACalTemplateID = TACalTemplateId , @TACurrentTaskWorkflowID = TaskWorkflowId
	FROM pTACalTemplateTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID
	
	IF @TACurrentTaskWorkflowID IS NULL -- If this task is "event", calculating it's progress as the average of the child events progress
	BEGIN
		DECLARE @NextNeighboringTaskID INT -- TaskID of the next non-child element (all elements between current and next task are "children".
		DECLARE @AvgTaskProgress DECIMAL(10, 6)
		
		SELECT TOP 1 @NextNeighboringTaskID = TaskId FROM pTACalTemplateTask 
		WHERE TACalTemplateId = @TACalTemplateID AND TaskId > @CurrentTaskID AND [level] <= @CurrentLevel
		ORDER BY TaskId
		
		IF @NextNeighboringTaskID IS NULL
			SELECT @NextNeighboringTaskID = (MAX(TaskID) + 1) FROM pTACalTemplateTask WHERE TACalTemplateId = @TACalTemplateID
		
		SELECT @AvgTaskProgress = AVG(ISNULL(TaskProgress, 0.00)) FROM pTACalTemplateTask
		WHERE TACalTemplateId = @TACalTemplateID AND TaskId > @CurrentTaskID AND TaskId < @NextNeighboringTaskID
		AND [level] = @CurrentLevel + 1
		
		IF NOT (@AvgTaskProgress IS NULL)
			UPDATE pTACalTemplateTask SET TaskProgress = @AvgTaskProgress WHERE TACalTemplateTaskId = @TACalTemplateTaskID
	END
	
	-- Getting the parent event
	DECLARE @ParentTemplateTaskID UNIQUEIDENTIFIER
	SELECT TOP 1 @ParentTemplateTaskID = TACalTemplateTaskId FROM pTACalTemplateTask
	WHERE TACalTemplateId = @TACalTemplateID AND [level] = @CurrentLevel - 1
	ORDER BY TaskId
	
	IF @ParentTemplateTaskID IS NOT NULL
		EXEC spx_TACalendar_EventProgress_UPDATE @ParentTemplateTaskID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09043', GetDate())
GO
