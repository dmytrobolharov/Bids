IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningValues_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningValues_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_PlanningValues_SELECT]
	@PlanningID UNIQUEIDENTIFIER, 	
	@SeasonYearID UNIQUEIDENTIFIER,
	@CompareSeasonYearID UNIQUEIDENTIFIER,	
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN

	DECLARE @PrevSeasonYearID UNIQUEIDENTIFIER = @CompareSeasonYearID
	
	IF CHARINDEX(' WHERE ', @SearchCond) > 0
		SET @SearchCond = RTRIM(LTRIM(SUBSTRING(@SearchCond, CHARINDEX(' WHERE ', @SearchCond) + 7, LEN(@SearchCond))))
	ELSE
		SET @SearchCond = N''
	
	DECLARE @PlanningFinancialIDList NVARCHAR(MAX)	
	SELECT @PlanningFinancialIDList = COALESCE(@PlanningFinancialIDList + ',', '') + 
	'[' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 ORDER BY PlanningFinancialSort
	
	SELECT @PlanningFinancialIDList = COALESCE(@PlanningFinancialIDList + ',', '') + 
	'[CMP__' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 AND PlanningFinancialID IN ('10000000-0000-0000-0000-000000000000', '10000000-0000-0000-0000-000000000020', '10000000-0000-0000-0000-000000000001')
	
	DECLARE @PlanningFinancialSelectList NVARCHAR(MAX)
	SELECT @PlanningFinancialSelectList = COALESCE(@PlanningFinancialSelectList + ',', '') + 
	'ISNULL([' + CAST(PlanningFinancialID AS NVARCHAR(50)) + '], 0) AS [' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 ORDER BY PlanningFinancialSort
	
	SELECT @PlanningFinancialSelectList = COALESCE(@PlanningFinancialSelectList + ',', '') + 
	'ISNULL([CMP__' + CAST(PlanningFinancialID AS NVARCHAR(50)) + '], 0) AS [CMP__' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 AND PlanningFinancialID IN ('10000000-0000-0000-0000-000000000000', '10000000-0000-0000-0000-000000000020', '10000000-0000-0000-0000-000000000001')
	
	DECLARE @sql NVARCHAR(MAX)
	
	IF @PrevSeasonYearID = '00000000-0000-0000-0000-000000000000'
	BEGIN
	SET @sql = 
		'SELECT Name, PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision,   
				PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory,' + @PlanningFinancialIDList + ', CategoriesCount, SubCategoriesCount, Active,
				SUBSTRING(ISNULL(''/'' + PlanningBrand, '''') + ISNULL(''/'' + PlanningDivision, '''') + ISNULL(''/'' + PlanningStyleTypeDescription, '''') + ISNULL(''/'' + PlanningStyleCategory, '''') + ISNULL(''/'' + PlanningSubCategory, ''''), 2, 4000) AS ChangeLogName			
		FROM (
			SELECT PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, CAST(PlanningFinancialID AS nVARCHAR(100)) AS PlanningFinancialID,
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
			UNION
			SELECT 0 as PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID,
				''CMP__'' + CAST(PlanningFinancialID AS nVARCHAR(40)) AS PlanningFinancialID,
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
				AND PlanningFinancialID IN (''10000000-0000-0000-0000-000000000000'',''10000000-0000-0000-0000-000000000020'',''10000000-0000-0000-0000-000000000001'')
		) tbl		
		PIVOT (MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (' + @PlanningFinancialIDList + ')) pvt
		WHERE PlanningStyleCategoryID IS NOT NULL AND (SubCategoriesCount = 0 OR PlanningSubCategory IS NOT NULL) 
			' + CASE WHEN LEN(@SearchCond) = 0 THEN '' ELSE ' AND ' + @SearchCond END + '
		ORDER BY CASE WHEN PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL THEN 1 ELSE 0 END, 
		PlanningStyleTypeDescription, PlanningStyleCategory, PlanningSubCategory'
		
	END
	ELSE
	BEGIN
	
	SET @sql = 
		'SELECT Name, PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision,   
				PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory,' + @PlanningFinancialSelectList + ', CategoriesCount, 0 as SubCategoriesCount, Active, 
				SUBSTRING(ISNULL(''/'' + PlanningBrand, '''') + ISNULL(''/'' + PlanningDivision, '''') + ISNULL(''/'' + PlanningStyleTypeDescription, '''') + ISNULL(''/'' + PlanningStyleCategory, '''') + ISNULL(''/'' + PlanningSubCategory, ''''), 2, 4000) AS ChangeLogName
		FROM (
			SELECT PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, CAST(PlanningFinancialID AS nVARCHAR(100)) AS PlanningFinancialID,
				COALESCE(PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision) as Name,
				PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory, Active, 
				(
					SELECT COUNT(*) FROM pStyleCategoryStyleType scst
					WHERE scst.StyleTypeID = pPlanningBusiness.PlanningStyleTypeID
				) AS CategoriesCount
			FROM pPlanningBusiness WHERE 
			PlanningID = ''' + CAST(@PlanningID as NVARCHAR(40)) + ''' 				
				AND SeasonYearID = '''  + CAST(@SeasonYearID as NVARCHAR(40)) + '''
			UNION
			SELECT PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, 
				''CMP__'' + CAST(PlanningFinancialID AS nVARCHAR(40)) AS PlanningFinancialID,
				COALESCE(PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision) as Name,
				PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision, PlanningBrandID, PlanningBrand, 
				PlanningSubCategoryID, PlanningSubCategory, Active,
				(
					SELECT COUNT(*) FROM pStyleCategoryStyleType scst
					WHERE scst.StyleTypeID = pPlanningBusiness.PlanningStyleTypeID
				) AS CategoriesCount
			FROM pPlanningBusiness WHERE 
			PlanningID = ''' + CAST(@PlanningID as NVARCHAR(40)) + ''' 				
				AND SeasonYearID = '''  + CAST(@PrevSeasonYearID as NVARCHAR(40)) + '''
				AND PlanningFinancialID IN (''10000000-0000-0000-0000-000000000000'',''10000000-0000-0000-0000-000000000020'',''10000000-0000-0000-0000-000000000001'')
		) tbl		
		PIVOT (MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (' + @PlanningFinancialIDList + ')) pvt
		WHERE PlanningSubCategoryID IS NULL AND PlanningStyleCategoryID IS NOT NULL
			' + CASE WHEN LEN(@SearchCond) = 0 THEN '' ELSE ' AND ' + @SearchCond END + '
		ORDER BY CASE WHEN PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL THEN 1 ELSE 0 END, 
		PlanningStyleTypeDescription, PlanningStyleCategory, PlanningSubCategory'
	
	
	END
	
	--print(@sql)
	EXEC(@sql)
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08449', GetDate())
GO
