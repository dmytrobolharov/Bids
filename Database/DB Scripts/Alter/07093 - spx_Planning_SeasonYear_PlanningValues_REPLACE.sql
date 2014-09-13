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

	
	INSERT INTO pPlanningStyleCategoryToSubCategory(
		PlanningID, PlanningBrandID, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, SubCategoryID, SeasonYearID)
	SELECT t1.PlanningID, t1.PlanningBrandID, t1.PlanningDivisionID, t1.PlanningStyleTypeID, t1.PlanningStyleCategoryID, t1.SubCategoryID, @dstSeasonYearID
	FROM pPlanningStyleCategoryToSubCategory t1	
	LEFT JOIN pPlanningStyleCategoryToSubCategory t2				
		ON t2.PlanningID = t1.PlanningID AND t2.SeasonYearID = @dstSeasonYearID	
			AND t2.PlanningBrandID = t1.PlanningBrandID
			AND t2.PlanningDivisionID = t1.PlanningDivisionID
			AND t2.PlanningStyleTypeID = t1.PlanningStyleTypeID
			AND t2.PlanningStyleCategoryID = t1.PlanningStyleCategoryID
			AND t2.SubCategoryID = t1.SubCategoryID
	WHERE t1.PlanningID = @PlanningID AND t1.SeasonYearID = @srcSeasonYearID	
		AND t2.PlanningStyleCategoryToSubCategoryID IS NULL AND EXISTS(
			SELECT * FROM pPlanningBusiness pb 
			WHERE pb.PlanningID = @PlanningID 
				AND pb.SeasonYearID = @dstSeasonYearID
				AND pb.PlanningBrandID = t2.PlanningBrandID
				AND pb.PlanningDivisionID = t2.PlanningDivisionID
				AND pb.PlanningStyleTypeID = t2.PlanningStyleTypeID
				AND pb.PlanningStyleCategoryID = t2.PlanningStyleCategoryID
				AND pb.PlanningSubCategoryID = t2.SubCategoryID
				AND pb.Active = 1
		)
		
	INSERT INTO pPlanningBusiness (PlanningBusinessID, PlanningID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort,
		PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningDivision, PlanningStyleTypeDescription, PlanningStyleCategory, 
		PlanningDivisionSort, PlanningStyleTypeSort, 
		CUser, CDate, MUser, MDate, PlanningBrandID, PlanningBrand, SeasonYearID, PlanningSubCategoryID, PlanningSubCategory)
	SELECT NEWID(), t1.PlanningID, t1.PlanningFinancialID, t1.PlanningFinancialText, t1.PlanningFinancialSort,
		t1.PlanningDivisionID, t1.PlanningStyleTypeID, t1.PlanningStyleCategoryID, t1.PlanningDivision, t1.PlanningStyleTypeDescription, t1.PlanningStyleCategory,
		t1.PlanningDivisionSort, t1.PlanningStyleTypeSort, 
		t1.CUser, t1.CDate, t1.MUser, t1.MDate, t1.PlanningBrandID, t1.PlanningBrand, @dstSeasonYearID, t1.planningSubCategoryID, t1.PlanningSubCategory
	FROM pPlanningBusiness t1
	LEFT JOIN pPlanningBusiness t2
		ON t2.PlanningID = t1.PlanningID AND t2.SeasonYearID = @dstSeasonYearID	
			AND t2.PlanningBrandID = t1.PlanningBrandID
			AND t2.PlanningDivisionID = t1.PlanningDivisionID
			AND t2.PlanningStyleTypeID = t1.PlanningStyleTypeID
			AND t2.PlanningStyleCategoryID = t1.PlanningStyleCategoryID
			AND t2.PlanningSubCategoryID = t1.PlanningSubCategoryID
	WHERE t1.PlanningID = @PlanningID AND t1.SeasonYearID = @srcSeasonYearID
		AND t2.PlanningBusinessID IS NULL AND t1.PlanningSubCategoryID IS NOT NULL
		AND t2.Active = 1
	
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
		AND ISNULL(pb1.PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(pb2.PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000')
		AND pb1.PlanningFinancialID = pb2.PlanningFinancialID
	WHERE pb1.PlanningID = @PlanningID AND pb1.SeasonYearID = @dstSeasonYearID
		AND pb2.SeasonYearID = @srcSeasonYearID AND pb1.Active = 1
		
	exec spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE @PlanningID, @dstSeasonYearID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07093', GetDate())
GO
