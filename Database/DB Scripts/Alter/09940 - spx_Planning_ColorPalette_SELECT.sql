IF OBJECT_ID(N'[dbo].[spx_Planning_ColorPalette_SELECT]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_Planning_ColorPalette_SELECT]
GO
CREATE PROCEDURE [dbo].[spx_Planning_ColorPalette_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@PlannigColor INT,
	@WhereExp NVARCHAR(MAX) = '',
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
AS
BEGIN
	DECLARE @SqlStr NVARCHAR(MAX)
	
	IF @PlannigColor = 1
		SET @SqlStr = 'SELECT * INTO #tmp0 FROM (SELECT cp.*, pc.PlanningID FROM pColorPalette cp INNER JOIN pPlanningColor pc ON cp.ColorPaletteID = pc.ColorPaletteID WHERE SeasonYearID = ''' + CAST(@SeasonYearID AS NVARCHAR(40)) + ''' AND PlanningColorDrop = 0) a WHERE Active = 1 AND PlanningID = ''' + CAST(@PlanningID AS NVARCHAR(40)) + ''' ' + @WhereExp + ' ORDER BY Sort,L ,H ,S;'
	ELSE
		SET @SqlStr = 'SELECT * INTO #tmp0 FROM pColorPalette WHERE Active = 1 ' + @WhereExp + ' ORDER BY Sort,L ,H ,S;'

	DECLARE @sqlString  NVARCHAR(MAX)  = @SqlStr + dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, NULL)
	exec sp_executesql @sqlString
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09940', GetUTCDate())
GO
