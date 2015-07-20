/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplate_REMOVE]    Script Date: 03/29/2013 16:31:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplate_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplate_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplate_REMOVE]
	@MilestoneTemplateID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pMilestoneTemplateItemWorkflow WHERE MilestoneTemplateItemID IN (
		SELECT MilestoneTemplateItemID FROM pMilestoneTemplateItem WHERE MilestoneTemplateID = @MilestoneTemplateID
	)
	
	DELETE FROM pMilestoneTemplateItem WHERE MilestoneTemplateID = @MilestoneTemplateID
	
	DELETE FROM pMilestoneTemplate WHERE MilestoneTemplateID = @MilestoneTemplateID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05448', GetDate())
GO
