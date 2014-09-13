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
				SELECT ', ' + materials.MaterialNo FROM (
					SELECT sb.MaterialNo FROM pStyleBOM sb
					INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID
					INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
					WHERE sb.StyleID = sh.StyleID AND sb.MainMaterial = 1
					UNION
					SELECT sm.MaterialNo FROM pStyleMaterials sm
					WHERE sm.StyleID = sh.StyleID AND sm.MainMaterial = 1
				) materials
				FOR XML PATH('')), 1, 2, '') AS Materials
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
VALUES ('DB_Version', '0.5.0000', '07418', GetDate())
GO
