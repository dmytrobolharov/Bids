IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_PlanningActivity_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_PlanningActivity_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_PlanningActivity_SELECT]
(
	@LineFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = '',
	@TopCount INT = NULL
)
AS
BEGIN

	DECLARE @PlanningID UNIQUEIDENTIFIER,
			@SeasonYearID UNIQUEIDENTIFIER

	SELECT @PlanningID = PlanningID, @SeasonYearID = SeasonYearID
	FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	
	SELECT 
		pa.PlanningActivityID
		, pa.PlanningActivityTypeID
		, pa.PlanningID
		, pa.SeasonYearID
		, pa.TeamID
		, pa.CUser
		, pa.CDate
		, pa.CDate as CTime
		, pat.PlanningActivityType
		, pat.PlanningActivityMsg
		, pa.ParamValues
		, CASE WHEN pav.TeamID IS NULL THEN 1 ELSE 0 END AS NewActivity
	INTO #tmp
	FROM pPlanningActivity pa
		INNER JOIN pPlanningActivityType pat ON pa.PlanningActivityTypeID = pat.PlanningActivityTypeID
		LEFT JOIN pPlanningActivityView pav ON pa.PlanningActivityID = pav.PlanningActivityID AND pav.TeamID = @TeamID
	WHERE pa.StyleID IN (SELECT StyleID FROM pLineFolderItem WHERE LineFolderID = @LineFolderID) OR pa.StyleID = '00000000-0000-0000-0000-000000000000'
	
	IF @TopCount IS NULL
	BEGIN
		EXEC('SELECT * FROM #tmp ' + @SearchCond + ' ORDER BY CDate DESC')
	END
	ELSE
	BEGIN
		DECLARE @SQL NVARCHAR(MAX)
		IF LTRIM(RTRIM(@SearchCond)) = ''
			SET @SearchCond = 'WHERE NewActivity = 1'
		SET @SQL = 'SELECT TOP ' + CAST(@TopCount AS NVARCHAR(10)) + ' * FROM #tmp ' + @SearchCond + ' ORDER BY CDate DESC'
		EXEC(@SQL)
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07944', GetDate())
GO
