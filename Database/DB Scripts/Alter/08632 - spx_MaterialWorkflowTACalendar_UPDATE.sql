IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowTACalendar_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowTACalendar_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowTACalendar_UPDATE]
	@TaskRevisedlStart date,
	@TaskRevisedEnd date,
	@TACalRefTaskId uniqueidentifier
AS

	IF @TaskRevisedlStart = ''
		SET @TaskRevisedlStart = NULL
			
	IF @TaskRevisedEnd = ''
		SET @TaskRevisedEnd = NULL
	
	UPDATE pTACalReferenceTask 
	SET TaskRevisedlStart = @TaskRevisedlStart, 
		TaskRevisedEnd = @TaskRevisedEnd
	WHERE TACalRefTaskId = @TACalRefTaskId


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08632', GetDate())
GO
