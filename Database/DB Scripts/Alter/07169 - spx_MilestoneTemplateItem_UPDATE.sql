IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItem_UPDATE]
	@MilestoneTemplateItemID UNIQUEIDENTIFIER,
	@WorkflowIDs nVARCHAR(MAX),
	@WorkflowStatusIDs nVARCHAR(MAX),
	@AssignedToIDs nVARCHAR(MAX),
	@NeedsToKnowIDs nVARCHAR(MAX),
	@UpdateSql NVARCHAR(MAX)
AS
BEGIN
	
	exec(@UpdateSql)
	
	-- empty item remove
	if EXISTS(SELECT * FROM pMilestoneTemplateItem WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID AND ISNULL(MilestoneTemplateItemName, '') = '')
	begin
		exec spx_MilestoneTemplateItem_REMOVE @MilestoneTemplateItemID
	end
	else
	begin	
		-- update workflows
		DELETE FROM pMilestoneTemplateItemWorkflow WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID		
		INSERT INTO pMilestoneTemplateItemWorkflow (MilestoneTemplateItemID, WorkflowID)
		SELECT @MilestoneTemplateItemID, value FROM dbo.fnx_Split(@WorkflowIDs, ',')
		
		-- update workflow statuses
		DELETE FROM pMilestoneTemplateItemWorkflowStatus WHERE MilestoneTemplateitemID = @MilestoneTemplateItemID
		INSERT INTO pMilestoneTemplateItemWorkflowStatus (MilestoneTemplateitemID, WorkflowStatusID)
		SELECT @MilestoneTemplateItemID, value FROM dbo.fnx_Split(@WorkflowStatusIDs, ',')
		
		-- update assigned to
		DELETE FROM pMilestoneTemplateItemAssignedTo WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID
		INSERT INTO pMilestoneTemplateItemAssignedTo (MilestoneTemplateitemID, AssignedToID)
		SELECT @MilestoneTemplateItemID, value FROM dbo.fnx_Split(@AssignedToIDs, ',')
		
		-- update needs to know
		DELETE FROM pMilestoneTemplateItemNeedsToKnow WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID
		INSERT INTO pMilestoneTemplateItemNeedsToKnow (MilestoneTemplateitemID, NeedsToKnowID)
		SELECT @MilestoneTemplateItemID, value FROM dbo.fnx_Split(@NeedsToKnowIDs, ',')
	end
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07169', GetDate())
GO
