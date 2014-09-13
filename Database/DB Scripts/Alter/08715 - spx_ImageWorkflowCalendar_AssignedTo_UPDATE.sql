IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowCalendar_AssignedTo_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowCalendar_AssignedTo_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ImageWorkflowCalendar_AssignedTo_UPDATE] (
	@TaskAssignedToId int,
	@ImageWorkflowID uniqueidentifier,
	@ImageID uniqueidentifier
	)
AS	
		BEGIN
			UPDATE pImageWorkflowPage SET WorkAssignedTo = @TaskAssignedToId WHERE ImageWorkflowPageID = @ImageWorkflowID and ImageID=@ImageID
		END	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08715', GetDate())
GO

