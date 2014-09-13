IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningFlashEditWithPermission_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningFlashEditWithPermission_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningFlashEditWithPermission_SELECT]	
	@PlanningTypeID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM pPlanningFlashEdit flash
	INNER JOIN sAccessPlanningFolderItem access
	ON access.PlanningItemID = flash.PlanningFlashEditId AND access.TeamID = @TeamID AND access.PlanningTypeID = @PlanningTypeID
	WHERE flash.PlanningFlashEditActive = 1
		AND (access.AccessView = 1 OR access.AccessRoleId = 3)
	ORDER BY flash.PlanningFlashEditSort
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07475', GetDate())
GO