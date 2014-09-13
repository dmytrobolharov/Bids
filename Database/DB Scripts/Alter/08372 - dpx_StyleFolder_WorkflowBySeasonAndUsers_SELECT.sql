IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowBySeasonAndUsers_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeasonAndUsers_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeasonAndUsers_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @UserGroupID UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	CREATE TABLE #tmpUsers (UserId INT NULL, TeamID UNIQUEIDENTIFIER NULL)

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	IF (SELECT COUNT(*) FROM uGroup WHERE GroupID = @UserGroupID) = 0
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT UserID, TeamID FROM Users WHERE TeamID = @UserGroupID
	ELSE
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT Users.UserId, Users.TeamID FROM Users
			INNER JOIN uUserGroup ON Users.TeamID = uUserGroup.TeamID
		WHERE uUserGroup.GroupID = @UserGroupID
		UNION
		SELECT WorkflowGroupID AS UserId, GroupID AS TeamID
		FROM uGroup
		WHERE GroupID = @UserGroupID

	SELECT TOP (100) PERCENT COUNT(*) AS COUNT
		, ssy.SeasonYearID
		, w.Workflow
		, w.WorkflowID
		, sw.WorkStatus
		, ws.WorkflowStatus
	FROM pStyleHeader sh
	INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
	INNER JOIN pStyleWorkflow sw ON sh.StyleID = sw.StyleID AND (sw.StyleSeasonYearID = ssy.StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL)
	INNER JOIN pWorkflowStatus ws ON sw.WorkStatus = ws.WorkflowStatusID
	INNER JOIN pWorkflow w ON sw.WorkflowID = w.WorkflowID
	INNER JOIN #tmpUsers tu ON sw.WorkAssignedTo = tu.UserId
	WHERE ssy.SeasonYearID = @SeasonYearID
	GROUP BY ssy.SeasonYearID
		, w.WorkflowID
		, w.Workflow
		, sw.WorkStatus
		, ws.WorkflowStatus
	ORDER BY ssy.SeasonYearID

	DROP TABLE #tmpUsers
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08372', GetDate())
GO