IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Style_WorkflowDueDate_Tracking_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Style_WorkflowDueDate_Tracking_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Style_WorkflowDueDate_Tracking_SELECT]
(
	@DateFrom datetime = NULL
	, @DateTo datetime = NULL
	, @Seasons nvarchar(max) = NULL
	, @Years nvarchar(max) = NULL
	, @UserGroup nvarchar(max)
)
AS

DECLARE @NumDaysToAlert int = 7

IF @DateFrom IS NULL or @DateFrom = '' SET @DateFrom = '1900-01-01T00:00:00.000'
IF @DateTo IS NULL or @DateTo = '' SET @DateTo= '2900-12-31T00:00:00.000'

CREATE TABLE #tmpSeason (Season nvarchar(50))
IF @Seasons IS NULL OR @Seasons = '' INSERT INTO #tmpSeason SELECT DISTINCT Custom FROM pSeason WHERE Active = 1 
ELSE INSERT INTO #tmpSeason SELECT value FROM dbo.fnx_Split(@Seasons, ',')

CREATE TABLE #tmpYear (Year nvarchar(50))
IF @Years IS NULL OR @Years = '' INSERT INTO #tmpYear SELECT DISTINCT Custom FROM pYear WHERE Active = 1 
ELSE INSERT INTO #tmpYear SELECT value FROM dbo.fnx_Split(@Years, ',')

SELECT DISTINCT StyleID
INTO #tmpStyleID
FROM pStyleSeasonYear ssy
	INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
	INNER JOIN #tmpSeason ts ON sy.Season = ts.Season
	INNER JOIN #tmpYear ty ON sy.Year = ty.Year

CREATE TABLE #tmpUserGroup(TeamID UNIQUEIDENTIFIER)
INSERT INTO #tmpUserGroup
	SELECT uUserGroup.TeamID FROM (SELECT CAST(value AS UNIQUEIDENTIFIER) AS TeamID FROM dbo.fnx_Split(@UserGroup, ',')) ug INNER JOIN uUserGroup ON ug.TeamID = uUserGroup.TeamID
	UNION
	SELECT uUserGroup.TeamID FROM (SELECT CAST(value AS UNIQUEIDENTIFIER) AS TeamID FROM dbo.fnx_Split(@UserGroup, ',')) ug INNER JOIN uUserGroup ON ug.TeamID = uUserGroup.GroupID

SELECT
	sh.StyleNo
	, CHAR(10) + sh.Description AS Description
	, sc.StyleCategory
	, sh.SizeClass
	, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS VariationName
	, sh.StyleSet
	, w.Workflow
	, wi.WorkFlowItemName
	, sh.TechPackDate
	, ISNULL(wi.WorkDue, sw.WorkDue) AS WorkDue
	, sy.Season + ' ' + sy.Year AS SeasonYear
	, sh.StyleID
	, sdi.Variation
	, sw.StyleSet AS wStyleSet
	, sw.WorkflowID
	, ISNULL(CAST(wi.WorkFlowItemID AS NVARCHAR(50)), '') AS WorkFlowItemID
	, sh.SizeRange
	, sh.StyleCategory AS StyleCategoryID
	, sh.StyleType
	, ISNULL(sh.CustomField9,'') AS StyleStatusId
	, sh.DevelopmentID
	, CASE
		WHEN ISNULL(wi.WorkStatus, sw.WorkStatus) = 100 THEN 'Apprvd'
		WHEN DATEDIFF(d, GETDATE(), ISNULL(wi.WorkDue, sw.WorkDue))<0 THEN CAST(ABS(DATEDIFF(d, GETDATE(), ISNULL(wi.WorkDue, sw.WorkDue))) AS NVARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(d, GETDATE(), ISNULL(wi.WorkDue, sw.WorkDue))) AS NVARCHAR(5)) + 'd Left'
	  END AS TextMessage	
	, CASE
		WHEN ISNULL(wi.WorkStatus, sw.WorkStatus) = 100 THEN 'PaleGreen'
		WHEN DATEDIFF(d, GETDATE(), ISNULL(wi.WorkDue, sw.WorkDue))<=0 THEN 'IndianRed'
		WHEN DATEDIFF(d, GETDATE(), ISNULL(wi.WorkDue, sw.WorkDue))>0 AND DATEDIFF(d, GETDATE(), ISNULL(wi.WorkDue, sw.WorkDue))<=@NumDaysToAlert THEN '#ffff64'
		ELSE 'No Color'
	  END AS Color
	 , m.MapUrl
FROM
	pStyleHeader sh
	INNER JOIN #tmpStyleID ON sh.StyleID = #tmpStyleID.StyleID
	INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT JOIN pSeasonYear sy ON sh.IntroSeasonYearID = sy.SeasonYearID
	INNER JOIN pStyleWorkflow sw ON sh.StyleID = sw.StyleID
	INNER JOIN pWorkflow w ON sw.WorkflowID = w.WorkflowID
	INNER JOIN Mapping m ON w.WorkflowID = m.Map
	LEFT OUTER JOIN pWorkFlowItem wi ON sw.StyleID = wi.StyleID AND sw.StyleSet = wi.StyleSet AND sw.WorkflowID = wi.WorkflowID
	INNER JOIN Users u ON sw.WorkAssignedTo = u.UserId
	INNER JOIN #tmpUserGroup ug ON u.TeamID = ug.TeamID
WHERE
	sh.TechPackDate BETWEEN @DateFrom AND @DateTo
	OR sh.TechPackDate IS NULL
ORDER BY
	sh.StyleNo
	, sdi.Variation
	
DROP TABLE #tmpSeason
DROP TABLE #tmpYear
DROP TABLE #tmpUserGroup

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05538', GetDate())
GO
