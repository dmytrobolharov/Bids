/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItem_REMOVE]    Script Date: 03/29/2013 16:31:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItem_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItem_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItem_REMOVE]
	@MilestoneTemplateItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pMilestoneTemplateItemWorkflow WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID
	DELETE FROM pMilestoneTemplateItem WHERE MilestoneTemplateItemID = @MilestoneTemplateItemID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05446', GetDate())
GO
