IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendar_AssignedTo_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendar_AssignedTo_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendar_AssignedTo_UPDATE] (
	@TaskAssignedToId int,
	@StyleWorkflowID uniqueidentifier
	)
AS
BEGIN
		UPDATE pStyleWorkflow SET WorkAssignedTo = @TaskAssignedToId WHERE StyleWorkflowID = @StyleWorkflowID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08482', GetDate())
GO

