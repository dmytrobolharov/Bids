IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_LastYearLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_LastYearLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_LastYearLogic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	;WITH PSY AS (
		SELECT ROW_NUMBER() OVER(ORDER BY Sort) AS RowNo, * FROM pPlanningSeasonYear
		WHERE PlanningID = @PlanningID
	)
	UPDATE pb SET pb.PlanningLastYearCh = ISNULL(lypb.PlanningActualCh, 0)
	FROM pPlanningBusiness pb
	INNER JOIN PSY ON pb.PlanningID = psy.PlanningID AND pb.SeasonYearID = psy.SeasonYearID
	LEFT JOIN pPlanningBusiness lypb 
		INNER JOIN PSY lypsy ON lypb.PlanningID = lypsy.PlanningID AND lypb.SeasonYearID = lypsy.SeasonYearID
		ON (pb.PlanningBrandID = lypb.PlanningBrandID 
			OR (pb.PlanningBrandID IS NULL AND lypb.PlanningBrandID IS NULL))
		AND (pb.PlanningDivisionID = lypb.PlanningDivisionID 
			OR (pb.PlanningDivisionID IS NULL AND lypb.PlanningDivisionID IS NULL))
		AND (pb.PlanningStyleTypeID = lypb.PlanningStyleTypeID 
			OR (pb.PlanningStyleTypeID IS NULL AND lypb.PlanningStyleTypeID IS NULL))
		AND (pb.PlanningStyleCategoryID = lypb.PlanningStyleCategoryID 
			OR (pb.PlanningStyleCategoryID IS NULL AND lypb.PlanningStyleCategoryID IS NULL))
		AND (pb.PlanningSubCategoryID = lypb.PlanningSubCategoryID 
			OR (pb.PlanningSubCategoryID IS NULL AND lypb.PlanningSubCategoryID IS NULL))
		AND pb.PlanningFinancialID = lypb.PlanningFinancialID
		AND PSY.RowNo = lypsy.RowNo + 1
	WHERE pb.PlanningID = @PlanningID AND pb.SeasonYearID = @SeasonYearID
		AND pb.PlanningLastYearCh <> lypb.PlanningActualCh

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08271', GetDate())
GO
