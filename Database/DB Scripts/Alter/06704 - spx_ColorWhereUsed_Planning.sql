IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorWhereUsed_Planning]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorWhereUsed_Planning]
GO

CREATE PROCEDURE [dbo].[spx_ColorWhereUsed_Planning]
	@ColorPaletteID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT p.PlanningName, sy.SeasonYear, pc.PlanningID, pc.SeasonYearID
	FROM pPlanningColor pc
	INNER JOIN pPlanning p ON pc.PlanningID = p.PlanningID
	INNER JOIN vwx_SeasonYear_SEL sy ON pc.SeasonYearID = sy.SeasonYearID
	WHERE pc.ColorPaletteID = @ColorPaletteID
	ORDER BY PlanningName, sy.SeasonOrder
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06704', GetDate())
GO
