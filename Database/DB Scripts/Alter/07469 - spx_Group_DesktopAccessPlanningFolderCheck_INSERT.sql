IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessPlanningFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessPlanningFolderCheck_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessPlanningFolderCheck_INSERT] (
@GroupID  uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

	INSERT INTO sAccessGroupPlanningFolder
		(PlanningTypeId, GroupID, CUser, CDate, MUser, MDate)
	SELECT PlanningTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pPlanningType
	WHERE Active = 1
	AND PlanningTypeID NOT IN (SELECT PlanningTypeID FROM sAccessGroupPlanningFolder WHERE GroupID = @GroupID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07469', GetDate())
GO