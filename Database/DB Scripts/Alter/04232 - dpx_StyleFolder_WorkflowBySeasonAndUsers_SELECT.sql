IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowBySeasonAndUsers_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeasonAndUsers_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeasonAndUsers_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
	, @UserGroupID uniqueidentifier = NULL
)
AS

BEGIN
CREATE TABLE #tmpUsers
(
	[UserId] [int] NULL
	, [TeamID] [uniqueidentifier] NULL
)
END

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END

IF (SELECT COUNT(*) FROM uGroup WHERE GroupID = @UserGroupID) = 0
BEGIN
	INSERT INTO #tmpUsers (UserId, TeamID) SELECT UserID, TeamID FROM Users WHERE TeamID = @UserGroupID
END
ELSE
BEGIN
	INSERT INTO #tmpUsers (UserId, TeamID) SELECT Users.UserId, Users.TeamID FROM Users INNER JOIN uUserGroup ON Users.TeamID = uUserGroup.TeamID WHERE uUserGroup.GroupID = @UserGroupID
END

BEGIN
SELECT TOP (100) PERCENT COUNT(*) AS COUNT
	, dbo.pStyleSeasonYear.SeasonYearID
	, dbo.pWorkflow.Workflow
	, dbo.pWorkflow.WorkflowID
	, dbo.pStyleWorkflow.WorkStatus
	, dbo.pWorkflowStatus.WorkflowStatus
FROM dbo.pStyleHeader
	INNER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
	INNER JOIN dbo.pStyleWorkflow ON dbo.pStyleHeader.StyleID = dbo.pStyleWorkflow.StyleID
	INNER JOIN dbo.pWorkflowStatus ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
	INNER JOIN dbo.pWorkflow ON dbo.pStyleWorkflow.WorkflowID = dbo.pWorkflow.WorkflowID
WHERE
	pStyleSeasonYear.SeasonYearID = @SeasonYearID
	AND pStyleWorkflow.WorkAssignedTo IN (SELECT UserID FROM #tmpUsers)
GROUP BY
	dbo.pStyleSeasonYear.SeasonYearID
	, dbo.pWorkflow.WorkflowID
	, dbo.pWorkflow.Workflow
	, dbo.pStyleWorkflow.WorkStatus
	, dbo.pWorkflowStatus.WorkflowStatus
ORDER BY
	dbo.pStyleSeasonYear.SeasonYearID
END

DROP TABLE #tmpUsers

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04232', GetDate())
GO
