IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Material_WorkflowDueDate_Tracking_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Material_WorkflowDueDate_Tracking_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Material_WorkflowDueDate_Tracking_SELECT]
(
	@DateFrom DATETIME = NULL
	, @DateTo DATETIME = NULL
	, @Seasons NVARCHAR(MAX) = NULL
	, @Years NVARCHAR(MAX) = NULL
	, @UserGroup NVARCHAR(MAX)
	, @NoofSubmits INT = NULL
)
AS
BEGIN
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
		m.MaterialNo
		, m.MaterialName
		, ct.ComponentDescription
		, cp.ColorName
		, sy.Season
		, sy.Year
		, tprl.AgentName
		, tprl.VendorName
		, tprl.FactoryName
		, mrw.MaterialRequestWorkflow
		, mrsw.DueDate
		, CASE
			WHEN mrss.ApprovedType = 1 THEN 'Apprvd'
			WHEN DATEDIFF(d, GETDATE(), mrsw.DueDate)<0 THEN CAST(ABS(DATEDIFF(d, GETDATE(), mrsw.DueDate)) AS NVARCHAR(5)) + 'd Late'
			ELSE CAST(ABS(DATEDIFF(d, GETDATE(), mrsw.DueDate)) AS NVARCHAR(5)) + 'd Left'
		  END AS TextMessage	
		, CASE
			WHEN mrss.ApprovedType = 1 THEN 'PaleGreen'
			WHEN DATEDIFF(d, GETDATE(), mrsw.DueDate)<=0 THEN 'IndianRed'
			WHEN DATEDIFF(d, GETDATE(), mrsw.DueDate)>0 AND DATEDIFF(d, GETDATE(), mrsw.DueDate)<=@NumDaysToAlert THEN '#ffff64'
			ELSE 'No Color'
		  END AS Color
		, ISNULL(tprl.AgentID, '00000000-0000-0000-0000-000000000000') AS AgentID
		, ISNULL(tprl.VendorID, '00000000-0000-0000-0000-000000000000') AS VendorID
		, ISNULL(tprl.FactoryID, '00000000-0000-0000-0000-000000000000') AS FactoryID
		, mtp.TradePartnerRelationshipLevelID
		, mrsw.Status
		, sy.SeasonYearID
		, m.MaterialType
		, mrsw.MaterialRequestWorkflowID
		, mtpc.MaterialTradePartnerColorID
	FROM pMaterial m
		INNER JOIN pMaterialTradePartner mtp ON m.MaterialID = mtp.MaterialId
		INNER JOIN pMaterialTradePartnerColor mtpc ON mtp.MaterialTradePartnerId = mtpc.MaterialTradePartnerID
		INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mtpc.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
		LEFT JOIN pColorPalette cp ON mtpc.ColorPaletteID = cp.ColorPaletteID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
		LEFT JOIN pSeasonYear sy
			INNER JOIN #tmpSeason ts ON sy.Season = ts.Season
			INNER JOIN #tmpYear ty ON sy.Year = ty.Year
		ON mtp.SeasonYearID = sy.SeasonYearID
		LEFT JOIN pMaterialRequestSubmitStatus mrss ON mrsw.Status = mrss.StatusID
		INNER JOIN Users u ON mrsw.AssignedTo = u.UserId
		INNER JOIN #tmpUserGroup ug ON u.TeamID = ug.TeamID
	WHERE
		(mrsw.DueDate BETWEEN @DateFrom AND @DateTo OR mrsw.DueDate IS NULL)
		AND (mrsw.Submit >= @NoofSubmits OR @NoofSubmits IS NULL)
	ORDER BY
		m.MaterialNo
		, cp.ColorName
		, sy.Season + ' ' + sy.Year
		
	DROP TABLE #tmpSeason
	DROP TABLE #tmpYear
	DROP TABLE #tmpUserGroup
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06978', GetDate())
GO
