/****** Object:  StoredProcedure [dbo].[spx_TACalendarTemplateTasksDep_SELECT]    Script Date: 05/13/2014 18:47:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendarTemplateTasksDep_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendarTemplateTasksDep_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendarTemplateTasksDep_SELECT]    Script Date: 05/13/2014 18:47:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_TACalendarTemplateTasksDep_SELECT]
	@TACalTemplateTaskID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT stuff(
	(SELECT ',' + CAST(a.taskID AS NVARCHAR(5)) FROM 
		(select tsk2.taskID from pTACalTemplateTask tsk 
		inner join pTACalTemplateTaskdep tskdep on tskdep.TACalTemplateTaskChildId = tsk.TACalTemplateTaskId
		inner join pTACalTemplateTask tsk2 on tsk2.TACalTemplateTaskId = tskdep.TACalTemplateTaskParentId
		where tsk.TACalTemplateTaskId = @TACalTemplateTaskID) a ORDER BY a.TaskId
FOR XML PATH('')), 1, 1, '')
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07605', GetDate())
GO