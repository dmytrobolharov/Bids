IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Sample_WorkflowDueDate_Tracking_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Sample_WorkflowDueDate_Tracking_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Sample_WorkflowDueDate_Tracking_SELECT]
(
	@DateFrom DATETIME = NULL
	, @DateTo DATETIME = NULL
	, @Seasons NVARCHAR(MAX) = NULL
	, @Years NVARCHAR(MAX) = NULL
	, @UserGroup NVARCHAR(MAX)
	, @NoofSubmits INT = NULL
)
AS

DECLARE @NumDaysToAlert int = 7

IF @DateFrom IS NULL or @DateFrom = '' SET @DateFrom = '1900-01-01T00:00:00.000'
IF @DateTo IS NULL or @DateTo = '' SET @DateTo= '2900-12-31T00:00:00.000'

CREATE TABLE #tmpSeason (Season NVARCHAR(50))
IF @Seasons IS NULL OR @Seasons = '' INSERT INTO #tmpSeason SELECT DISTINCT Custom FROM pSeason WHERE Active = 1 
ELSE INSERT INTO #tmpSeason SELECT value FROM dbo.fnx_Split(@Seasons, ',')

CREATE TABLE #tmpYear (Year NVARCHAR(50))
IF @Years IS NULL OR @Years = '' INSERT INTO #tmpYear SELECT DISTINCT Custom FROM pYear WHERE Active = 1 
ELSE INSERT INTO #tmpYear SELECT value FROM dbo.fnx_Split(@Years, ',')

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
	, sh.TechPackDate
	, sy.Season + ' ' + sy.Year AS SeasonYear
	, sdi.Variation
	, sh.SizeRange
	, sh.StyleCategory AS StyleCategoryID
	, sh.StyleType
	, ISNULL(sh.CustomField3,'') AS StyleStatusId
	, di1.ItemDim1Name
	, di2.ItemDim2Name
	, di3.ItemDim3Name
	, tprl.AgentName
	, tprl.VendorName
	, tprl.FactoryName
	, sw.SampleWorkflow
	, srw.DueDate
	, srw.Status
	, CASE
		WHEN srw.Status = 2 OR srw.Status = 3 THEN 'Apprvd'
		WHEN DATEDIFF(d, GETDATE(), srw.DueDate)<0 THEN CAST(ABS(DATEDIFF(d, GETDATE(), srw.DueDate)) AS NVARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(d, GETDATE(), srw.DueDate)) AS NVARCHAR(5)) + 'd Left'
	  END AS TextMessage	
	, CASE
		WHEN srw.Status = 2 OR srw.Status = 3 THEN 'PaleGreen'
		WHEN DATEDIFF(d, GETDATE(), srw.DueDate)<=0 THEN 'IndianRed'
		WHEN DATEDIFF(d, GETDATE(), srw.DueDate)>0 AND DATEDIFF(d, GETDATE(), srw.DueDate)<=@NumDaysToAlert THEN '#ffff64'
		ELSE 'No Color'
	  END AS Color
	, ISNULL(tprl.AgentID, '00000000-0000-0000-0000-000000000000') AS AgentID
	, ISNULL(tprl.VendorID, '00000000-0000-0000-0000-000000000000') AS VendorID
	, ISNULL(tprl.FactoryID, '00000000-0000-0000-0000-000000000000') AS FactoryID
	, sr.SampleRequestTradeID
	, srw.SampleWorkflowID
	, sh.StyleID
	, ssy.SeasonYearID
FROM
	pStyleHeader sh
	INNER JOIN pStyleSeasonYear ssy
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		INNER JOIN #tmpSeason ts ON sy.Season = ts.Season
		INNER JOIN #tmpYear ty ON sy.Year = ty.Year
	ON sh.StyleID = ssy.StyleID
	INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pSampleRequestBOMTrade sr ON sh.StyleID = sr.StyleID AND ssy.StyleSeasonYearID = sr.StyleSeasonYearID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON sr.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN pSampleRequestWorkflowBOM srw
		INNER JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
	ON sr.SampleRequestTradeID = srw.SampleRequestTradeID
	LEFT JOIN pStyleBOMDimensionItem di1 ON sr.ItemDim1ID=di1.ItemDim1ID AND sr.StyleBOMDimensionID = di1.StyleBOMDimensionID
	LEFT JOIN pStyleBOMDimensionItem di2 ON sr.ItemDim2ID=di2.ItemDim2ID AND sr.StyleBOMDimensionID = di2.StyleBOMDimensionID
	LEFT JOIN pStyleBOMDimensionItem di3 ON sr.ItemDim3ID=di3.ItemDim3ID AND sr.StyleBOMDimensionID = di3.StyleBOMDimensionID
	INNER JOIN Users u ON srw.AssignedTo = u.UserId
	INNER JOIN #tmpUserGroup ug ON u.TeamID = ug.TeamID
WHERE
	(sh.TechPackDate BETWEEN @DateFrom AND @DateTo OR sh.TechPackDate IS NULL)
	AND (srw.Submit >= @NoofSubmits OR @NoofSubmits IS NULL)
ORDER BY
	sh.StyleNo
	, SeasonYear
	, sdi.Variation
	
DROP TABLE #tmpSeason
DROP TABLE #tmpYear
DROP TABLE #tmpUserGroup


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07029', GetDate())
GO
