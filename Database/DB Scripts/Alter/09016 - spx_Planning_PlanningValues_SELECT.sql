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
		INTO ##tmpPlanningValues
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
		INTO ##tmpPlanningValues
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
	
	DECLARE @SumColumns nvarchar(max)
	SET @SumColumns = REPLACE(REPLACE(@PlanningFinancialIDList,'[','SUM(['),']','])')
	
	EXEC('
		INSERT INTO ##tmpPlanningValues (Name,' + @PlanningFinancialIDList + ')
		SELECT NULL, ' + @SumColumns + '
		FROM ##tmpPlanningValues
	')
	
	DECLARE @ExtentedCost DECIMAL (18,5)
	DECLARE @ExtentedWholesale DECIMAL (18,5)
	DECLARE @ExtentedRetail DECIMAL (18,5)
	DECLARE @ExtentedEcom DECIMAL (18,5)
	DECLARE @TotalProjectedUnits DECIMAL (18,5)
	DECLARE @TotalWholesaleUnits DECIMAL (18,5)
	DECLARE @TotalRetailUnits DECIMAL (18,5)
	DECLARE @TotalEcomUnits DECIMAL (18,5)
	DECLARE @AvgCostUnit DECIMAL (18,5)
	DECLARE @AvgWholesaleCostUnit DECIMAL (18,5)
	DECLARE @AvgRetailCostUnit DECIMAL (18,5)
	DECLARE @AvgEcomCostUnit DECIMAL (18,5)
	
	DECLARE @TotalWholesaleCost DECIMAL(18,5)
	DECLARE @TotalRetailCost DECIMAL(18,5)
	DECLARE @TotalEcomCost DECIMAL(18,5)
	
	DECLARE @GrossMargin DECIMAL(18,5)
	DECLARE @WholesaleGrossMargin DECIMAL(18,5)
	DECLARE @RetailGrossMargin DECIMAL(18,5)
	DECLARE @EcomGrossMargin DECIMAL(18,5)
	
	SELECT @ExtentedCost = [10000000-0000-0000-0000-000000000011] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @ExtentedWholesale = [10000000-0000-0000-0000-000000000009] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @ExtentedRetail = [10000000-0000-0000-0000-000000000010] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @ExtentedEcom = [10000000-0000-0000-0000-000000000025] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @TotalProjectedUnits = [10000000-0000-0000-0000-000000000022] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @TotalWholesaleUnits = [10000000-0000-0000-0000-000000000004] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @TotalRetailUnits = [10000000-0000-0000-0000-000000000005] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	SELECT @TotalEcomUnits = [10000000-0000-0000-0000-000000000021] FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NULL
	
	IF @TotalProjectedUnits = 0
		SET @AvgCostUnit = 0
	ELSE
		SET @AvgCostUnit = @ExtentedCost/@TotalProjectedUnits

	IF @TotalWholesaleUnits = 0
		SET @AvgWholesaleCostUnit = 0
	ELSE
		SET @AvgWholesaleCostUnit = @ExtentedWholesale/@TotalWholesaleUnits

	IF @TotalRetailUnits = 0
		SET @AvgRetailCostUnit = 0
	ELSE
		SET @AvgRetailCostUnit = @ExtentedRetail/@TotalRetailUnits

	IF @TotalEcomUnits = 0
		SET @AvgEcomCostUnit = 0
	ELSE
		SET @AvgEcomCostUnit = @ExtentedEcom/@TotalEcomUnits
		

	SELECT @TotalWholesaleCost = SUM([10000000-0000-0000-0000-000000000004] * [10000000-0000-0000-0000-000000000006]) 
	FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NOT NULL
	
	SELECT @TotalRetailCost = SUM([10000000-0000-0000-0000-000000000005] * [10000000-0000-0000-0000-000000000006]) 
	FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NOT NULL

	SELECT @TotalEcomCost = SUM([10000000-0000-0000-0000-000000000021] * [10000000-0000-0000-0000-000000000006]) 
	FROM ##tmpPlanningValues WHERE PlanningStyleCategoryID IS NOT NULL
	
	IF @ExtentedWholesale = 0
		SET @WholesaleGrossMargin = 0
	ELSE
		SET @WholesaleGrossMargin = (@ExtentedWholesale - @TotalWholesaleCost)/@ExtentedWholesale

	IF @ExtentedRetail = 0
		SET @RetailGrossMargin = 0
	ELSE
		SET @RetailGrossMargin = (@ExtentedRetail - @TotalRetailCost)/@ExtentedRetail
	
	IF @ExtentedEcom = 0
		SET @EcomGrossMargin = 0
	ELSE
		SET @EcomGrossMargin = (@ExtentedEcom - @TotalEcomCost)/@ExtentedEcom

	IF (@ExtentedWholesale + @ExtentedRetail + @ExtentedEcom) = 0
		SET @GrossMargin = 0
	ELSE
		SET @GrossMargin = (@ExtentedWholesale + @ExtentedRetail + @ExtentedEcom - @ExtentedCost) / (@ExtentedWholesale + @ExtentedRetail + @ExtentedEcom)
	
	-- Avg Cost / Unit
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000006] = @AvgCostUnit
	WHERE PlanningStyleCategoryID IS NULL
	
	-- Avg Wholesale Price / Unit
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000007] = @AvgWholesaleCostUnit
	WHERE PlanningStyleCategoryID IS NULL

	-- Avg Retail Price / Unit
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000008] = @AvgRetailCostUnit
	WHERE PlanningStyleCategoryID IS NULL
	
	-- Avg Ecom Price / Unit
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000023] = @AvgEcomCostUnit
	WHERE PlanningStyleCategoryID IS NULL

	-- Wholesale Gross Margin %
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000012] = @WholesaleGrossMargin
	WHERE PlanningStyleCategoryID IS NULL

	-- Retail Gross Margin %
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000013] = @RetailGrossMargin
	WHERE PlanningStyleCategoryID IS NULL

	-- Ecom Gross Margin %
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000027] = @EcomGrossMargin
	WHERE PlanningStyleCategoryID IS NULL

	-- Gross Margin %
	UPDATE ##tmpPlanningValues
	SET [10000000-0000-0000-0000-000000000028] = @GrossMargin
	WHERE PlanningStyleCategoryID IS NULL


	SELECT * FROM ##tmpPlanningValues
	
	DROP TABLE ##tmpPlanningValues
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '6.0.0000', '09016', GetDate())
GO
