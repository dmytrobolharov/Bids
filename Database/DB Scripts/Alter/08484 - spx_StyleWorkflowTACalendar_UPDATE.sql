IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowTACalendar_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowTACalendar_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowTACalendar_UPDATE] (
	@TaskRevisedlStart date,
	@TaskRevisedEnd date,
	@TACalRefTaskId uniqueidentifier
	)
AS
BEGIN
		UPDATE pTACalReferenceTask SET  TaskRevisedlStart = @TaskRevisedlStart, TaskRevisedEnd=@TaskRevisedEnd WHERE TACalRefTaskId = @TACalRefTaskId
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08484', GetDate())
GO

