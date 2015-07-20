IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningValues_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningValues_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_PlanningValues_SELECT]
	@PlanningID UNIQUEIDENTIFIER, 
	@DivisionID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @PlanningFinancialIDList NVARCHAR(MAX)
	
	SELECT @PlanningFinancialIDList = COALESCE(@PlanningFinancialIDList + ',', '') + 
	'[' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 AND Editable = 1 ORDER BY PlanningFinancialSort
	
	DECLARE @sql NVARCHAR(MAX) = 
		'SELECT Name, PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision,   
				PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory,' + @PlanningFinancialIDList + ',
		(
			SELECT COUNT(*) FROM pStyleCategoryStyleType scst
			WHERE scst.StyleTypeID = pvt.PlanningStyleTypeID
		) AS CategoriesCount,
		(
			SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
			WHERE psctsc.PlanningDivisionID = pvt.PlanningDivisionID
				AND psctsc.PlanningStyleTypeID = pvt.PlanningStyleTypeID 
				AND psctsc.PlanningStyleCategoryID = pvt.PlanningStyleCategoryID
		) AS SubCategoriesCount
		FROM (
			SELECT PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningFinancialID,
				COALESCE(PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision) as Name,
				PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory
			FROM pPlanningBusiness WHERE 
			PlanningID = ''' + CAST(@PlanningID as NVARCHAR(40)) + ''' 
				AND PlanningDivisionID = '''  + CAST(@DivisionID as NVARCHAR(40)) + '''
				AND SeasonYearID = '''  + CAST(@SeasonYearID as NVARCHAR(40)) + '''
		) tbl
		PIVOT (MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (' + @PlanningFinancialIDList + ')) pvt
		ORDER BY CASE WHEN PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL THEN 1 ELSE 0 END, 
		PlanningStyleTypeDescription, PlanningStyleCategory, PlanningSubCategory'
	
	EXEC(@sql)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06851', GetDate())
GO
