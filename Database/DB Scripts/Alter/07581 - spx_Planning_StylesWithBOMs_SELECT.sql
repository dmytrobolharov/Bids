IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_StylesWithBOMs_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_StylesWithBOMs_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_StylesWithBOMs_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@StyleIDs nVARCHAR(MAX)
AS
BEGIN
	
	SELECT * FROM pStyleHeader sh
	INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
	INNER JOIN dbo.fnx_Split(@StyleIDs, N',') styles ON sh.StyleID = styles.value	
	ORDER BY sh.StyleNo
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07581', GetDate())
GO
