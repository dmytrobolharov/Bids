IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @UserGroupID UNIQUEIDENTIFIER = NULL
	, @WorkflowID UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	CREATE TABLE #tmpUsers (UserId INT NULL, TeamID UNIQUEIDENTIFIER NULL)

	DECLARE @SERVERURL AS nVARCHAR(500)
	SELECT @SERVERURL = SettingValue FROM rReportSetting WHERE SettingType = 'plmOnServer'

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	IF (SELECT COUNT(*) FROM uGroup WHERE GroupID = @UserGroupID) = 0
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT UserID, TeamID FROM Users WHERE TeamID = @UserGroupID
	ELSE
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT Users.UserId, Users.TeamID
		FROM Users INNER JOIN uUserGroup ON Users.TeamID = uUserGroup.TeamID
		WHERE uUserGroup.GroupID = @UserGroupID

	BEGIN
		SELECT DISTINCT @SERVERURL + '/Style/Style_Redirect.aspx?SID=' + CAST(sh.StyleID AS nVARCHAR(40)) + '&P=' + CAST(sw.WorkflowID AS nVARCHAR(40)) AS PageUrl
			, sh.*
			, ssy.SeasonYearID
			, sw.WorkStatus
			, ws.WorkflowStatus
			, sw.WorkflowID
			, DATEDIFF(day, sw.WorkDue, GETDATE()) AS DaysLate
			, DATEDIFF(day, sw.WorkStart, GETDATE()) AS DaysWork
			, STUFF((
					SELECT DISTINCT ', ' + MaterialNo
					FROM (
						SELECT MaterialNo, sbom.StyleID
						FROM pStyleBOM sbom
							INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = sbom.StyleID AND ssy.SeasonYearID = @SeasonYearID
							INNER JOIN pStyleBOMDimension sbd ON sbom.StyleBOMDimensionId = sbd.StyleBOMDimensionID
							INNER JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID AND ssy.StyleSeasonYearID = wfi.StyleSeasonYearID						
						WHERE sw.WorkflowID = '40000000-0000-0000-0000-000000000080' AND MainMaterial = 1
						UNION
						SELECT MaterialNo, StyleID
						FROM pStyleMaterials
						WHERE MainMaterial = 1
						) mat
					WHERE mat.StyleID = sh.StyleID
					FOR XML PATH('')
					), 1, 2, '') AS Materials
		FROM pStyleHeader sh
			INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			INNER JOIN pStyleWorkflow sw ON sh.StyleID = sw.StyleID AND (sw.StyleSeasonYearID = ssy.StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL)
			INNER JOIN pWorkflowStatus ws ON sw.WorkStatus = ws.WorkflowStatusID
			INNER JOIN #tmpUsers tu ON sw.WorkAssignedTo = tu.UserId
		WHERE ssy.SeasonYearID = @SeasonYearID AND sw.WorkflowID = @WorkflowID
		ORDER BY DaysLate DESC, ssy.SeasonYearID
	END

	DROP TABLE #tmpUsers

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06791', GetDate())
GO
