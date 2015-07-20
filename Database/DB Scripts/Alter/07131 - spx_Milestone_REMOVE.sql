IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Milestone_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Milestone_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_Milestone_REMOVE]
	@MilestoneID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pMilestoneItemWorkflow WHERE MilestoneItemID IN (
		SELECT MilestoneItemID FROM pMilestoneItem WHERE MilestoneID = @MilestoneID)
	DELETE FROM pMilestoneItemWorkflowStatus WHERE MilestoneItemID IN (
		SELECT MilestoneItemID FROM pMilestoneItem WHERE MilestoneID = @MilestoneID)
	DELETE FROM pMilestoneItemAssignedTo WHERE MilestoneItemID IN (
		SELECT MilestoneItemID FROM pMilestoneItem WHERE MilestoneID = @MilestoneID)
	
	DELETE FROM pMilestoneItem WHERE MilestoneID = @MilestoneID	
	DELETE FROM pMilestoneAssignedTo WHERE MilestoneID = @MilestoneID
	DELETE FROM pMilestone WHERE MilestoneID = @MilestoneID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07131', GetDate())
GO
