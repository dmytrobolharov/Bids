IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItem_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItem_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItem_REMOVE]
	@MilestoneItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pMilestoneItemAssignedTo WHERE MilestoneItemID = @MilestoneItemID
	DELETE FROM pMilestoneItemWorkflowStatus WHERE MilestoneItemID = @MilestoneItemID
	DELETE FROM pMilestoneItemWorkflow WHERE MilestoneItemID = @MilestoneItemID
	DELETE FROM pMilestoneItem WHERE MilestoneItemID = @MilestoneItemID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07137', GetDate())
GO
