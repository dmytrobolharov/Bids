IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_ColorPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_ColorPalette_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_ColorPalette_SELECT]
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @PlannigColor INT
	, @WhereExp NVARCHAR(MAX) = ''
AS
BEGIN
	DECLARE @SqlStr NVARCHAR(MAX)
	
	IF @PlannigColor = 1
		SET @SqlStr = 'SELECT * FROM (SELECT cp.*, pc.PlanningID FROM pColorPalette cp INNER JOIN pPlanningColor pc ON cp.ColorPaletteID = pc.ColorPaletteID WHERE SeasonYearID = ''' + CAST(@SeasonYearID AS NVARCHAR(40)) + ''' AND PlanningColorDrop = 0) a WHERE Active = 1 AND PlanningID = ''' + CAST(@PlanningID AS NVARCHAR(40)) + ''' ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'
	ELSE
		SET @SqlStr = 'SELECT * FROM pColorPalette WHERE Active = 1 ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'

	EXEC (@SqlStr)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06716', GetDate())
GO
