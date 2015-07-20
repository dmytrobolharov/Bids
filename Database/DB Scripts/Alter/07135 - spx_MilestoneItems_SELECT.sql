IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItems_SELECT]
	@MilestoneID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT * FROM pMilestoneItem WHERE MilestoneID = @MilestoneID ORDER BY Sort
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07135', GetDate())
GO
