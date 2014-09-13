IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SeasonYear_PlanningValues_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SeasonYear_PlanningValues_REPLACE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SeasonYear_PlanningValues_REPLACE]
	@PlanningID UNIQUEIDENTIFIER,
	@srcSeasonYearID UNIQUEIDENTIFIER,
	@dstSeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(20),
	@CDate DATETIME
AS
BEGIN
	
	UPDATE pb1 
	SET PlanningPlanningCh = pb2.PlanningPlanningCh,
		CUser = @CUser,
		CDate = @CDate
	FROM pPlanningBusiness pb1
	INNER JOIN pPlanningBusiness pb2 ON pb1.PlanningID = pb2.PlanningID
		AND pb1.PlanningBrandID = pb2.PlanningBrandID
		AND pb1.PlanningDivisionID = pb2.PlanningDivisionID
		AND pb1.PlanningStyleTypeID = pb2.PlanningStyleTypeID
		AND pb1.PlanningStyleCategoryID = pb2.PlanningStyleCategoryID
		AND pb1.PlanningFinancialID = pb2.PlanningFinancialID
	WHERE pb1.PlanningID = @PlanningID AND pb1.SeasonYearID = @dstSeasonYearID
		AND pb2.SeasonYearID = @srcSeasonYearID
		
	exec spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE @PlanningID, @dstSeasonYearID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06429', GetDate())
GO
