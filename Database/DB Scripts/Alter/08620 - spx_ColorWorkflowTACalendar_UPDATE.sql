IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorWorkflowTACalendar_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorWorkflowTACalendar_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ColorWorkflowTACalendar_UPDATE] (
	@TaskRevisedlStart DATE,
	@TaskRevisedEnd DATE,
	@TACalRefTaskId UNIQUEIDENTIFIER
)
AS 

BEGIN
	IF @TaskRevisedlStart = ''
	BEGIN
		SET @TaskRevisedlStart=NULL
	END
	
	IF @TaskRevisedEnd = ''
	BEGIN
		SET @TaskRevisedEnd=NULL
	END
	
	UPDATE pTACalReferenceTask SET TaskRevisedlStart = @TaskRevisedlStart, TaskRevisedEnd = @TaskRevisedEnd 
	WHERE TACalRefTaskId = @TACalRefTaskId
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08620', GetDate())
GO


