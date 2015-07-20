/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItems_SELECT]    Script Date: 03/29/2013 13:29:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItems_SELECT]
	@MilestoneTemplateID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM pMilestoneTemplateItem WHERE MilestoneTemplateID = @MilestoneTemplateID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05444', GetDate())
GO
