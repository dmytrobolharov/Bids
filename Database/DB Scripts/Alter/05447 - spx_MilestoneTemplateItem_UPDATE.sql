/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItem_UPDATE]    Script Date: 03/29/2013 16:13:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItem_UPDATE]
	@MilestoneTemplateItemID UNIQUEIDENTIFIER,
	@WorkflowIDs VARCHAR(MAX),
	@UpdateSql NVARCHAR(MAX)
AS
BEGIN
	
	exec(@UpdateSql)
	
	-- empty item
	if EXISTS(SELECT * FROM pMilestoneTemplateItem WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID AND ISNULL(MilestoneTemplateItemName, '') = '')
	begin
		exec spx_MilestoneTemplateItem_REMOVE @MilestoneTemplateItemID
	end
	else
	begin	
		DELETE FROM pMilestoneTemplateItemWorkflow WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID
		
		INSERT INTO pMilestoneTemplateItemWorkflow (MilestoneTemplateItemID, WorkflowID)
		SELECT @MilestoneTemplateItemID, value FROM dbo.fnx_Split(@WorkflowIDs, ',')
	end
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05447', GetDate())
GO
