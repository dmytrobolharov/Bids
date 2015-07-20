IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItem_UPDATE]
	@MilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowIDs nVARCHAR(MAX),
	@WorkflowStatusIDs nVARCHAR(MAX),
	@AssignedToIDs nVARCHAR(MAX),
	@UpdateSql NVARCHAR(MAX)
AS
BEGIN
	
	exec(@UpdateSql)
	
	-- empty item remove
	if EXISTS(SELECT * FROM pMilestoneItem WHERE MilestoneItemID = @MilestoneItemID AND ISNULL(MilestoneItemName, '') = '')
	begin
		exec spx_MilestoneItem_REMOVE @MilestoneItemID
	end
	else
	begin	
		-- update workflows
		DELETE FROM pMilestoneItemWorkflow WHERE MilestoneItemID = @MilestoneItemID		
		INSERT INTO pMilestoneItemWorkflow (MilestoneItemID, WorkflowID)
		SELECT @MilestoneItemID, value FROM dbo.fnx_Split(@WorkflowIDs, ',')
		
		-- update workflow statuses
		DELETE FROM pMilestoneItemWorkflowStatus WHERE MilestoneItemID = @MilestoneItemID
		INSERT INTO pMilestoneItemWorkflowStatus (MilestoneItemID, WorkflowStatusID)
		SELECT @MilestoneItemID, value FROM dbo.fnx_Split(@WorkflowStatusIDs, ',')
		
		-- update workflow statuses
		DELETE FROM pMilestoneItemAssignedTo WHERE MilestoneItemID = @MilestoneItemID
		INSERT INTO pMilestoneItemAssignedTo (MilestoneItemID, AssignedToID)
		SELECT @MilestoneItemID, value FROM dbo.fnx_Split(@AssignedToIDs, ',')
	end
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07132', GetDate())
GO
