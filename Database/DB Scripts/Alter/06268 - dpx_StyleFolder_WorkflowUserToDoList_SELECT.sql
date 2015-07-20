IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT] (@SeasonYearID UNIQUEIDENTIFIER = NULL, @UserGroupID UNIQUEIDENTIFIER = NULL, @WorkflowID UNIQUEIDENTIFIER = NULL)
AS
BEGIN
	CREATE TABLE #tmpUsers ([UserId] [int] NULL, [TeamID] [uniqueidentifier] NULL)
END

DECLARE @SERVERURL AS VARCHAR(500)

BEGIN
	SET @SERVERURL = (
			SELECT SettingValue
			FROM rReportSetting
			WHERE SettingType = 'plmOnServer'
			)
END

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN
	SELECT TOP 1 @SeasonYearID = SeasonYearID
	FROM pSeasonYear
	WHERE CurrentSeason = 1
END

IF (
		SELECT COUNT(*)
		FROM uGroup
		WHERE GroupID = @UserGroupID
		) = 0
BEGIN
	INSERT INTO #tmpUsers (UserId, TeamID)
	SELECT UserID, TeamID
	FROM Users
	WHERE TeamID = @UserGroupID
END
ELSE
BEGIN
	INSERT INTO #tmpUsers (UserId, TeamID)
	SELECT Users.UserId, Users.TeamID
	FROM Users
	INNER JOIN uUserGroup ON Users.TeamID = uUserGroup.TeamID
	WHERE uUserGroup.GroupID = @UserGroupID
END

BEGIN
	SELECT @SERVERURL + '/Style/Style_Redirect.aspx?SID=' + CAST(pStyleHeader.StyleID AS VARCHAR(40)) + '&P=' + CAST(pStyleWorkflow.WorkflowID AS VARCHAR(40)) AS PageUrl, pStyleHeader.*, pStyleSeasonYear.SeasonYearID, pStyleWorkflow.WorkStatus, pWorkflowStatus.WorkflowStatus, pStyleWorkflow.WorkflowID, DATEDIFF(day, pStyleWorkflow.WorkDue, GETDATE()) AS DaysLate, DATEDIFF(day, pStyleWorkflow.WorkStart, GETDATE()) AS DaysWork, STUFF((
				SELECT DISTINCT ', ' + MaterialNo
				FROM (
					SELECT MaterialNo, StyleID
					FROM pStyleBOM
					WHERE WorkflowID = '40000000-0000-0000-0000-000000000080' AND MainMaterial = 1
					
					UNION
					
					SELECT MaterialNo, StyleID
					FROM pStyleMaterials
					WHERE MainMaterial = 1
					) mat
				WHERE mat.StyleID = pStyleHeader.StyleID
				FOR XML PATH('')
				), 1, 2, '') AS Materials
	FROM pStyleHeader
	INNER JOIN pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID
	INNER JOIN pStyleWorkflow ON pStyleHeader.StyleID = pStyleWorkflow.StyleID
	INNER JOIN pWorkflowStatus ON pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID
	WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND pStyleWorkflow.WorkAssignedTo IN (
			SELECT UserID
			FROM #tmpUsers
			) AND pStyleWorkflow.WorkflowID = @WorkflowID
	ORDER BY DaysLate DESC, pStyleSeasonYear.SeasonYearID
END

DROP TABLE #tmpUsers
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06268', GetDate())
GO
