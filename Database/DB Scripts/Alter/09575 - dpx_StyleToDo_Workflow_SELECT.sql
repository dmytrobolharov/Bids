IF OBJECT_ID(N'[dbo].[dpx_StyleToDo_Workflow_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_StyleToDo_Workflow_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleToDo_Workflow_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @UserGroupID UNIQUEIDENTIFIER
	, @WorkflowID UNIQUEIDENTIFIER
	, @DivisionID UNIQUEIDENTIFIER
	, @StyleTypeID INT = NULL
	, @StyleCategoryID UNIQUEIDENTIFIER = NULL
	, @StyleStatusID NVARCHAR(5) = NULL
	, @WorkStatus NVARCHAR(5) = NULL
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

	SELECT DISTINCT
		sh.StyleNo
		, sh.StyleID
		, sh.Description
		, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
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
		LEFT JOIN xCustom8 xc ON sh.CustomField3 = xc.Custom
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE ssy.SeasonYearID = @SeasonYearID
		AND sw.WorkflowID = @WorkflowID
		AND sh.DivisionID = @DivisionID
		AND (sh.StyleType = @StyleTypeID OR @StyleTypeID IS NULL)
		AND (sh.StyleCategory = @StyleCategoryID OR @StyleCategoryID IS NULL)
		AND (ISNULL(xc.CustomKey, '-1') = @StyleStatusID OR @StyleStatusID IS NULL)
		AND (sw.WorkStatus = @WorkStatus OR @WorkStatus IS NULL)
		ORDER BY DaysLate DESC, ssy.SeasonYearID

	DROP TABLE #tmpUsers

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09575', GetDate())
GO
