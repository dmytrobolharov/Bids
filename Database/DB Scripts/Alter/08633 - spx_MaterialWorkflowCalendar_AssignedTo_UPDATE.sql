IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowCalendar_AssignedTo_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowCalendar_AssignedTo_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowCalendar_AssignedTo_UPDATE]
	@TaskAssignedToId int,
	@MaterialWorkflowPageID uniqueidentifier
AS

	UPDATE pMaterialWorkflowPage 
	SET WorkAssignedTo = @TaskAssignedToId 
	WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08633', GetDate())
GO
