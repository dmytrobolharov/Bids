IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningValues_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningValues_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_PlanningValues_SELECT]
	@PlanningID UNIQUEIDENTIFIER, 	
	@SeasonYearID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN

	IF CHARINDEX(' WHERE ', @SearchCond) > 0
		SET @SearchCond = RTRIM(LTRIM(SUBSTRING(@SearchCond, CHARINDEX(' WHERE ', @SearchCond) + 7, LEN(@SearchCond))))
	ELSE
		SET @SearchCond = N''
	
	DECLARE @PlanningFinancialIDList NVARCHAR(MAX)
	
	SELECT @PlanningFinancialIDList = COALESCE(@PlanningFinancialIDList + ',', '') + 
	'[' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 ORDER BY PlanningFinancialSort
	
	DECLARE @sql NVARCHAR(MAX) = 
		'SELECT Name, PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision,   
				PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory,' + @PlanningFinancialIDList + ', CategoriesCount, SubCategoriesCount, Active		
		FROM (
			SELECT PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningFinancialID,
				COALESCE(PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision) as Name,
				PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory, Active,
				(
					SELECT COUNT(*) FROM pStyleCategoryStyleType scst
					WHERE scst.StyleTypeID = pPlanningBusiness.PlanningStyleTypeID
				) AS CategoriesCount,
				(
					SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
					WHERE psctsc.PlanningID = ''' + CAST(@PlanningID as NVARCHAR(40)) + '''
						AND psctsc.SeasonYearID = '''  + CAST(@SeasonYearID as NVARCHAR(40)) + '''
						AND psctsc.PlanningDivisionID = pPlanningBusiness.PlanningDivisionID
						AND psctsc.PlanningStyleTypeID = pPlanningBusiness.PlanningStyleTypeID 
						AND psctsc.PlanningStyleCategoryID = pPlanningBusiness.PlanningStyleCategoryID
				) AS SubCategoriesCount
			FROM pPlanningBusiness WHERE 
			PlanningID = ''' + CAST(@PlanningID as NVARCHAR(40)) + ''' 				
				AND SeasonYearID = '''  + CAST(@SeasonYearID as NVARCHAR(40)) + '''
		) tbl		
		PIVOT (MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (' + @PlanningFinancialIDList + ')) pvt
		WHERE PlanningStyleTypeID IS NOT NULL AND (SubCategoriesCount = 0 OR PlanningSubCategory IS NOT NULL) 
			' + CASE WHEN LEN(@SearchCond) = 0 THEN '' ELSE ' AND ' + @SearchCond END + '
		ORDER BY CASE WHEN PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL THEN 1 ELSE 0 END, 
		PlanningStyleTypeDescription, PlanningStyleCategory, PlanningSubCategory'
	
	EXEC(@sql)
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07092', GetDate())
GO
