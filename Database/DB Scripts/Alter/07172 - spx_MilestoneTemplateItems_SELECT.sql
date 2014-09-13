IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItems_SELECT]
	@MilestoneTemplateID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT mti.* FROM pMilestoneTemplateItem mti
	LEFT JOIN pMilestoneTemplateItem mti2 ON mti.ParentID = mti2.MilestoneTemplateItemID
	WHERE mti.MilestoneTemplateID = @MilestoneTemplateID
	ORDER BY CASE WHEN mti.ParentID IS NULL THEN mti.SortOrder ELSE mti2.SortOrder END, mti.ParentID, mti.SortOrder
	
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07172', GetDate())
GO
