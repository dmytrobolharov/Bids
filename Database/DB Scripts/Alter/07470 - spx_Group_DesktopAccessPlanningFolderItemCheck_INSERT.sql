IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessPlanningFolderItemCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessPlanningFolderItemCheck_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessPlanningFolderItemCheck_INSERT] (
	@AccessPlanningId UNIQUEIDENTIFIER,
	@AccessRoleId INT,
	@PlanningTypeID UNIQUEIDENTIFIER,
	@GroupID UNIQUEIDENTIFIER,
	@CreatedBy NVARCHAR(200),
	@CreatedDate DATETIME
)
AS


BEGIN
	
	EXEC spx_Group_DesktopAccessPlanningFolderCheck_INSERT
			@GroupID, @CreatedBy, @CreatedDate
	
END


BEGIN
	
	DECLARE @TempWorkflowAccess TABLE
	(
		PlanningItemID UNIQUEIDENTIFIER,
		PlanningItemName NVARCHAR(500),
		PlanningItemDescription NVARCHAR(500),
		PlanningItemSort INT,
		Child nVARCHAR(2)
	)

	INSERT INTO @TempWorkflowAccess
	EXEC spx_PlanningFolderItem_SELECT @PlanningTypeID

	
	INSERT INTO sAccessGroupPlanningFolderItem (AccessPlanningID, PlanningTypeID, PlanningItemID, AccessRoleId, GroupID, CUser, CDate, MUser, MDate)
	SELECT @AccessPlanningId, @PlanningTypeID, PlanningItemID, @AccessRoleId, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM @TempWorkflowAccess 
	WHERE PlanningItemID NOT IN( SELECT PlanningItemID FROM sAccessGroupPlanningFolderItem WHERE GroupID = @GroupID AND PlanningTypeID = @PlanningTypeID )

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07470', GetDate())
GO