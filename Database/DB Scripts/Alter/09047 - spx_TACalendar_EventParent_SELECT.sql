/****** Object:  StoredProcedure [dbo].[spx_TACalendar_EventParent_SELECT]    Script Date: 09/02/2014 13:21:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_EventParent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_EventParent_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_EventParent_SELECT]    Script Date: 09/02/2014 13:21:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_EventParent_SELECT]
	@TACalTemplateTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Getting the info about current template task
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	DECLARE @CurrentLevel INT
	
	SELECT @CurrentLevel = [level], @TACalTemplateID = TACalTemplateId
	FROM pTACalTemplateTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID
	
	-- Getting the parent event
	SELECT TOP 1 TACalTemplateTaskId FROM pTACalTemplateTask
	WHERE TACalTemplateId = @TACalTemplateID AND [level] = @CurrentLevel - 1
	ORDER BY TaskId
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09047', GetDate())
GO
