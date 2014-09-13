IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SeasonYear_Check_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SeasonYear_Check_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_SeasonYear_Check_DELETE](
	@SeasonYearID UNIQUEIDENTIFIER
)
AS
BEGIN

IF EXISTS (SELECT * FROM pColorPaletteSeasonYear WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pMaterialSeasonYear WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pStyleSeasonYear WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pLineFolder WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pSourcingHeader WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningSeasonYear WHERE SeasonYearID = @SeasonYearID)
	
	/* check planning tables cause SesonYearID is foreign key */
	OR EXISTS (SELECT * FROM pPlanningActivity WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningBusiness WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningColor WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningConfig WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningLineListConfig WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningMaterial WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory WHERE SeasonYearID = @SeasonYearID)
	OR EXISTS (SELECT * FROM pPlanningTACalendar WHERE SeasonYearID = @SeasonYearID)
BEGIN
	SELECT 1
END
ELSE
BEGIN
	SELECT 0
END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08955', GetDate())
GO
