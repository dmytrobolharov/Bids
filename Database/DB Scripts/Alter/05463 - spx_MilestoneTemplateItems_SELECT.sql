/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItems_SELECT]    Script Date: 04/01/2013 17:53:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItems_SELECT]
	@MilestoneTemplateID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM pMilestoneTemplateItem WHERE MilestoneTemplateID = @MilestoneTemplateID ORDER BY SortOrder
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05463', GetDate())
GO