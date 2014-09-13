/****** Object:  StoredProcedure [dbo].[spx_PlanningFlashEditWithPermission_SELECT]    Script Date: 06/04/2014 15:27:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningFlashEditWithPermission_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningFlashEditWithPermission_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_PlanningFlashEditWithPermission_SELECT]    Script Date: 06/04/2014 15:27:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_PlanningFlashEditWithPermission_SELECT]	
	@PlanningTypeID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM pPlanningFlashEdit flash
	INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 22, @PlanningTypeId) access 
	ON access.WorkflowId = flash.PlanningFlashEditId
	WHERE flash.PlanningFlashEditActive = 1
		AND (access.PermissionCreate = 1 OR access.PermissionRoleId = 3)
	ORDER BY flash.PlanningFlashEditSort
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07875', GetDate())
GO