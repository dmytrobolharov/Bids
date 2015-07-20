IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleToDo_Workflow_PieChart_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleToDo_Workflow_PieChart_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleToDo_Workflow_PieChart_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER 
	, @UserGroupID UNIQUEIDENTIFIER 
	, @WorkflowID UNIQUEIDENTIFIER
	, @DivisionID UNIQUEIDENTIFIER
	, @StyleTypeID INT = NULL
	, @StyleCategoryID UNIQUEIDENTIFIER = NULL
	, @StyleStatusID NVARCHAR(5) = NULL
)
AS
BEGIN
	CREATE TABLE #tmpUsers (UserId INT NULL, TeamID UNIQUEIDENTIFIER NULL)

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID
		FROM pSeasonYear WHERE CurrentSeason = 1

	IF (SELECT COUNT(*) FROM uGroup WHERE GroupID = @UserGroupID) = 0
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT UserID, TeamID FROM Users WHERE TeamID = @UserGroupID
	ELSE
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT Users.UserId, Users.TeamID
		FROM Users INNER JOIN uUserGroup ON Users.TeamID = uUserGroup.TeamID
		WHERE uUserGroup.GroupID = @UserGroupID

	BEGIN
		SELECT COUNT(sw.StyleWorkflowID) AS COUNT
			, sw.WorkStatus
			, ws.WorkflowStatus
		FROM pStyleHeader sh
			INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			INNER JOIN pStyleWorkflow sw ON sh.StyleID = sw.StyleID AND (sw.StyleSeasonYearID = ssy.StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL)
			INNER JOIN pWorkflow w ON w.WorkflowID = sw.WorkflowID
			INNER JOIN pWorkflowStatus ws ON sw.WorkStatus = ws.WorkflowStatusID
			INNER JOIN #tmpUsers tu ON sw.WorkAssignedTo = tu.UserId
			LEFT JOIN xCustom8 xc ON sh.CustomField3 = xc.Custom
		WHERE ssy.SeasonYearID = @SeasonYearID
			AND sw.WorkflowID = @WorkflowID	
			AND sw.WorkflowID = @WorkflowID
			AND sh.DivisionID = @DivisionID
			AND (sh.StyleType = @StyleTypeID OR @StyleTypeID IS NULL)
			AND (sh.StyleCategory = @StyleCategoryID OR @StyleCategoryID IS NULL)
			AND (ISNULL(xc.CustomKey, '-1') = @StyleStatusID OR @StyleStatusID IS NULL)			
		GROUP BY 
			sw.WorkStatus
			, ws.WorkflowStatus
			, sw.WorkSort
		ORDER BY sw.WorkSort
	END

	DROP TABLE #tmpUsers

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08833', GetDate())
GO
