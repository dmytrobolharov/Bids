IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningHistory_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_PlanningHistory_SELECT]
GO
CREATE PROCEDURE [dbo].[spx_PlanningHistory_SELECT]
(
	@TeamID UNIQUEIDENTIFIER
) AS 
BEGIN
	DECLARE @DivisionFolderTypeID INT = 26
	
	SELECT 
		a.PlanningID,
		b.PlanningName,
		b.IntroSeasonYearID
	FROM pPlanningHistory a
		INNER JOIN pPlanning b on a.PlanningID = b.PlanningID
	WHERE a.TeamID = @TeamId
		AND b.PlanningID IN 
			(
				SELECT DISTINCT PD.PlanningID
				FROM pPlanningDivision PD
					INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamId, @DivisionFolderTypeID) P ON P.ProductTypeId = PD.DivisionID
				WHERE 
					P.PermissionView = 1 OR P.PermissionRoleId = 3
			)
	ORDER BY a.CDate DESC
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10217', GetUTCDate())
GO