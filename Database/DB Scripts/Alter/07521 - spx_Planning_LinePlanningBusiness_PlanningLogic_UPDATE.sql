IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	--SET NOCOUNT ON;
	
	SELECT DISTINCT PlanningBrandID, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID,
		(SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
			WHERE psctsc.PlanningID = pb.PlanningID
				AND psctsc.SeasonYearID = pb.SeasonYearID
				AND psctsc.PlanningBrandID = pb.PlanningBrandID
				AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
				AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
				AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
		) AS SubCategoriesCount
	INTO #tmpAttributeList
	FROM pPlanningBusiness pb WHERE pb.PlanningID = @PlanningID AND pb.SeasonYearID = @SeasonYearID
	
	/**
	* Declaring column variables
	*/
	
	DECLARE @NoOfStyles DECIMAL(18,5)
	DECLARE @NoOfDevStyles DECIMAL(18,5)
	DECLARE @NoOfCarryOverStyles DECIMAL(18,5)
	DECLARE @WHSUnits DECIMAL(18, 5)
	DECLARE @RetailUnits DECIMAL(18, 5)
	DECLARE @EcomUnits DECIMAL(18, 5)
	DECLARE @TotalUnits DECIMAL(18, 5)
	DECLARE @AvgCostUnit DECIMAL(18, 5)
	DECLARE @AvgWHSPriceUnit DECIMAL(18, 5)
	DECLARE @AvgRetPriceUnit DECIMAL(18, 5)
	DECLARE @AvgEcomPriceUnit DECIMAL(18, 5)
	DECLARE @PlannedBudget DECIMAL(18, 5)
	DECLARE @ExtendedWholesale DECIMAL(18, 5)
	DECLARE @ExtendedRetail DECIMAL(18, 5)
	DECLARE @ExtendedEcom DECIMAL(18, 5)
	DECLARE @ExtendedCost DECIMAL(18, 5)
	DECLARE @GrossProfit DECIMAL(18, 5)
	DECLARE @GrossMarginWHS DECIMAL(18, 5)
	DECLARE @GrossMarginRet DECIMAL(18, 5)
	DECLARE @GrossMarginEcom DECIMAL(18, 5)
	DECLARE @GrossMargin DECIMAL(18, 5)
	
	DECLARE @CurrentBrandID UNIQUEIDENTIFIER
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER
	DECLARE @CurrentSubCategoryID UNIQUEIDENTIFIER
	DECLARE @SubCategoriesCount INT

	DECLARE @SubCategories TABLE(
		RowNo INT IDENTITY(1, 1),
		PlanningDivisionID UNIQUEIDENTIFIER,
		PlanningStyleTypeID INT, 
		PlanningStyleCategoryID UNIQUEIDENTIFIER, 
		PlanningSubCategoryID UNIQUEIDENTIFIER
	)
	INSERT INTO @SubCategories(PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID)
	SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID 	
	FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL 
		AND PlanningStyleTypeID IS NOT NULL 
		AND PlanningStyleCategoryID IS NOT NULL 
		AND PlanningSubCategoryID IS NOT NULL
		
	DECLARE @SubCategoriesRow INT = 1,
			@SubCategoriesTotal INT = (SELECT COUNT(*) FROM @SubCategories)

	-- Updating calculated values for all Sub categories (lowest level in hierarchy)	
	WHILE @SubCategoriesRow <= @SubCategoriesTotal
	BEGIN
		SELECT @CurrentDivisionID = PlanningDivisionID
			, @CurrentStyleTypeID = PlanningStyleTypeID
			, @CurrentStyleCategoryID = PlanningStyleCategoryID
			, @CurrentSubCategoryID = PlanningSubCategoryID 
		FROM @SubCategories WHERE RowNo = @SubCategoriesRow
		
		SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
			, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
			, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
			, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
			, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
			, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
			, @AvgCostUnit			= [10000000-0000-0000-0000-000000000006]
			, @AvgWHSPriceUnit		= [10000000-0000-0000-0000-000000000007]
			, @AvgRetPriceUnit		= [10000000-0000-0000-0000-000000000008]
			, @AvgEcomPriceUnit		= [10000000-0000-0000-0000-000000000023]
			, @PlannedBudget		= [10000000-0000-0000-0000-000000000024] 
		FROM (
			SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
				WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
					AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID		
					AND SeasonYearID = @SeasonYearID
		) pvt PIVOT(MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (
			[10000000-0000-0000-0000-000000000000],
			[10000000-0000-0000-0000-000000000020],
			[10000000-0000-0000-0000-000000000001],
			[10000000-0000-0000-0000-000000000004],
			[10000000-0000-0000-0000-000000000005],
			[10000000-0000-0000-0000-000000000021],
			[10000000-0000-0000-0000-000000000006],
			[10000000-0000-0000-0000-000000000007],
			[10000000-0000-0000-0000-000000000008],
			[10000000-0000-0000-0000-000000000023],
			[10000000-0000-0000-0000-000000000024])) fin
		
		-- all calculations are here
		SET @TotalUnits = @WHSUnits + @RetailUnits + @EcomUnits	
		SET @ExtendedCost = @TotalUnits * @AvgCostUnit
		SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
		SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit		
		SET @ExtendedEcom = @EcomUnits * @AvgEcomPriceUnit
		SET @GrossProfit = (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) - @ExtendedCost
		
		-- Wholesale Gross Margin
		IF (@ExtendedWholesale = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
		
		-- Retail Gross Margin
		IF (@ExtendedRetail = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
		
		-- Ecom Gross Margin
		IF (@ExtendedEcom = 0)
			SET @GrossMarginEcom = 0
		ELSE
			SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
		
		-- Gross margin
		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)
		
		UPDATE pPlanningBusiness SET 
				PlanningPlanningCh = CASE PlanningFinancialID 
					WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
					WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost
					WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale
					WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail
					WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom
					WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
					WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS
					WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet
					WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
					WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
					ELSE PlanningPlanningCh END
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID			
			AND SeasonYearID = @SeasonYearID
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000025',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000027',
				'10000000-0000-0000-0000-000000000028')
		
		SET @SubCategoriesRow = @SubCategoriesRow + 1		
	END
	
	
	DECLARE @Categories TABLE(
		RowNo INT IDENTITY(1, 1),
		PlanningDivisionID UNIQUEIDENTIFIER,
		PlanningStyleTypeID INT, 
		PlanningStyleCategoryID UNIQUEIDENTIFIER, 
		SubCategoriesCount INT
	)
	INSERT INTO @Categories(PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, SubCategoriesCount)
	SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, SubCategoriesCount 	
	FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL 
		AND PlanningStyleTypeID IS NOT NULL 
		AND PlanningStyleCategoryID IS NOT NULL 
		AND PlanningSubCategoryID IS NULL
		
	DECLARE @CategoriesRow INT = 1,
			@CategoriesTotal INT = (SELECT COUNT(*) FROM @Categories)
						
	-- Updating calculated values for all style categories (almost lowest level in hierarchy)
	WHILE @CategoriesRow <= @CategoriesTotal
	BEGIN
		SELECT @CurrentDivisionID = PlanningDivisionID
			, @CurrentStyleTypeID = PlanningStyleTypeID
			, @CurrentStyleCategoryID = PlanningStyleCategoryID
			, @SubCategoriesCount = SubCategoriesCount
		FROM @Categories WHERE RowNo = @CategoriesRow
	
		IF @SubCategoriesCount = 0 
		BEGIN -- most of the time of procedure is spent here
		
			SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
				, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
				, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
				, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
				, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
				, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
				, @AvgCostUnit			= [10000000-0000-0000-0000-000000000006]
				, @AvgWHSPriceUnit		= [10000000-0000-0000-0000-000000000007]
				, @AvgRetPriceUnit		= [10000000-0000-0000-0000-000000000008]
				, @AvgEcomPriceUnit		= [10000000-0000-0000-0000-000000000023]
				, @PlannedBudget		= [10000000-0000-0000-0000-000000000024] 
			FROM (
				SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
					WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
						AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL				
						AND SeasonYearID = @SeasonYearID
			) pvt PIVOT(MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (
				[10000000-0000-0000-0000-000000000000],
				[10000000-0000-0000-0000-000000000020],
				[10000000-0000-0000-0000-000000000001],
				[10000000-0000-0000-0000-000000000004],
				[10000000-0000-0000-0000-000000000005],
				[10000000-0000-0000-0000-000000000021],
				[10000000-0000-0000-0000-000000000006],
				[10000000-0000-0000-0000-000000000007],
				[10000000-0000-0000-0000-000000000008],
				[10000000-0000-0000-0000-000000000023],
				[10000000-0000-0000-0000-000000000024])) fin
		
			-- All calculations are here			
			SET @TotalUnits = @WHSUnits + @RetailUnits + @EcomUnits
			SET @ExtendedCost = @TotalUnits * @AvgCostUnit
			SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
			SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit
			SET @ExtendedEcom = @EcomUnits * @AvgEcomPriceUnit
			SET @GrossProfit = (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) - @ExtendedCost
			
			-- Wholesale Gross Margin
			IF (@ExtendedWholesale = 0)
				SET @GrossMarginWHS = 0
			ELSE
				SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
			
			-- Retail Gross Margin
			IF (@ExtendedRetail = 0)
				SET @GrossMarginRet = 0
			ELSE
				SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
			
			-- Ecom Gross Margin
			IF (@ExtendedEcom = 0)
				SET @GrossMarginEcom = 0
			ELSE
				SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
				
			-- Gross margin
			IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
				SET @GrossMargin = 0
			ELSE
				SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)
				
			UPDATE pPlanningBusiness SET 
				PlanningPlanningCh = CASE PlanningFinancialID 
					WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
					WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost
					WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale
					WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail
					WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom
					WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
					WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS
					WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet
					WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
					WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
					ELSE PlanningPlanningCh END
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL			
			AND SeasonYearID = @SeasonYearID
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000025',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000027',
				'10000000-0000-0000-0000-000000000028')
		
		END
		ELSE
		BEGIN
		
			-- Number of Styles
			SELECT @NoOfStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
			AND SeasonYearID = @SeasonYearID
			-- Number of Dev.Styles
			SELECT @NoOfDevStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'	
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfDevStyles
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'
			AND SeasonYearID = @SeasonYearID
			-- Number of Carry Over Styles
			SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'
			AND SeasonYearID = @SeasonYearID
			-- Planned Wholesale Units
			SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'
			AND SeasonYearID = @SeasonYearID
			-- Retail Units
			SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'
			AND SeasonYearID = @SeasonYearID
			-- Ecom Units
			SELECT @EcomUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @EcomUnits
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'
			AND SeasonYearID = @SeasonYearID

			-- Total Projected Units
			SELECT @TotalUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @TotalUnits
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'
			AND SeasonYearID = @SeasonYearID
					
			-- Planned Budget
			SELECT @PlannedBudget = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @PlannedBudget
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'
			AND SeasonYearID = @SeasonYearID
		
			-- Extented Cost
			SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'
			AND SeasonYearID = @SeasonYearID
			-- Extended Wholesale
			SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'
			AND SeasonYearID = @SeasonYearID
			-- Extended Retail
			SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'
			AND SeasonYearID = @SeasonYearID
			-- Extended Ecom
			SELECT @ExtendedEcom = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedEcom
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'
			AND SeasonYearID = @SeasonYearID
		
			-- Gross Profit
			SELECT @GrossProfit = SUM(PlanningPlanningCh) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'		
			AND SeasonYearID = @SeasonYearID
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossProfit
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'
			AND SeasonYearID = @SeasonYearID
		
		
			-- Avg Cost/Unit
			IF (@TotalUnits = 0)
				SET @AvgCostUnit = 0
			ELSE
				SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'
			AND SeasonYearID = @SeasonYearID
						
			-- WHS Cost/Unit
			IF (@WHSUnits = 0)
				SET @AvgWHSPriceUnit = 0
			ELSE
				SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'
			AND SeasonYearID = @SeasonYearID
						
			-- Retail Cost/Unit
			IF (@RetailUnits = 0)
				SET @AvgRetPriceUnit = 0
			ELSE
				SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'
			AND SeasonYearID = @SeasonYearID

			-- Retail Cost/Unit
			IF (@EcomUnits = 0)
				SET @AvgEcomPriceUnit = 0
			ELSE
				SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgEcomPriceUnit
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000023'
			AND SeasonYearID = @SeasonYearID

		
			-- Wholesale Gross Margin
			IF (@ExtendedWholesale = 0)
				SET @GrossMarginWHS = 0
			ELSE
				SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'
			AND SeasonYearID = @SeasonYearID
			
			-- Retail Gross Margin
			IF (@ExtendedRetail = 0)
				SET @GrossMarginRet = 0
			ELSE
				SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'
			AND SeasonYearID = @SeasonYearID
			
			-- Ecom Gross Margin
			IF (@ExtendedEcom = 0)
				SET @GrossMarginEcom = 0
			ELSE
				SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginEcom
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000027'
			AND SeasonYearID = @SeasonYearID
			
			-- Gross margin
			IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
				SET @GrossMargin = 0
			ELSE
				SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)		
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMargin
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000028'
			AND SeasonYearID = @SeasonYearID
		
		END
		
		SET @CategoriesRow = @CategoriesRow + 1
		--FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @SubCategoriesCount
	END
	
	--CLOSE @CategoriesCursor
	--DEALLOCATE @CategoriesCursor
	
	-- Updating calculated values for all style types (second level in hierarchy)
	DECLARE @TypesCursor CURSOR
	SET @TypesCursor = CURSOR SCROLL
	FOR SELECT PlanningDivisionID, PlanningStyleTypeID FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NOT NULL AND PlanningStyleCategoryID IS NULL 
	OPEN @TypesCursor
	
	FETCH NEXT FROM @TypesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		-- Number of Styles
		SELECT @NoOfStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
		AND SeasonYearID = @SeasonYearID
		-- Number of Dev.Styles
		SELECT @NoOfDevStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfDevStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'
		AND SeasonYearID = @SeasonYearID
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'
		AND SeasonYearID = @SeasonYearID
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'
		AND SeasonYearID = @SeasonYearID
		-- Retail Units
		SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'
		AND SeasonYearID = @SeasonYearID
		-- Ecom Units
		SELECT @EcomUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @EcomUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'
		AND SeasonYearID = @SeasonYearID

		-- Total Projected Units
		SELECT @TotalUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @TotalUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'
		AND SeasonYearID = @SeasonYearID
				
		-- Planned Budget
		SELECT @PlannedBudget = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @PlannedBudget
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'
		AND SeasonYearID = @SeasonYearID
	
		-- Extented Cost
		SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'
		AND SeasonYearID = @SeasonYearID
		-- Extended Wholesale
		SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'
		AND SeasonYearID = @SeasonYearID
		-- Extended Retail
		SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'
		AND SeasonYearID = @SeasonYearID
		-- Extended Ecom
		SELECT @ExtendedEcom = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedEcom
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'
		AND SeasonYearID = @SeasonYearID
	
		-- Gross Profit
		SELECT @GrossProfit = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossProfit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'
		AND SeasonYearID = @SeasonYearID
	
	
		-- Avg Cost/Unit
		IF (@TotalUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'
		AND SeasonYearID = @SeasonYearID
					
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'
		AND SeasonYearID = @SeasonYearID
					
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'
		AND SeasonYearID = @SeasonYearID

		-- Retail Cost/Unit
		IF (@EcomUnits = 0)
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgEcomPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000023'
		AND SeasonYearID = @SeasonYearID

	
		-- Wholesale Gross Margin
		IF (@ExtendedWholesale = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'
		AND SeasonYearID = @SeasonYearID
		
		-- Retail Gross Margin
		IF (@ExtendedRetail = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'
		AND SeasonYearID = @SeasonYearID
		
		-- Ecom Gross Margin
		IF (@ExtendedEcom = 0)
			SET @GrossMarginEcom = 0
		ELSE
			SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginEcom
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000027'
		AND SeasonYearID = @SeasonYearID
		
		-- Gross margin
		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)		
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMargin
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000028'
		AND SeasonYearID = @SeasonYearID
		
		FETCH NEXT FROM @TypesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID
	END
	
	CLOSE @TypesCursor
	DEALLOCATE @TypesCursor
	
	-- Updating calculated values for all division
	DECLARE @DivisionsCursor CURSOR
	SET @DivisionsCursor = CURSOR SCROLL
	FOR SELECT PlanningDivisionID FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL
	OPEN @DivisionsCursor
	
	FETCH NEXT FROM @DivisionsCursor INTO @CurrentDivisionID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		-- Number of Styles
		SELECT @NoOfStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
		AND SeasonYearID = @SeasonYearID
		-- Number of Dev.Styles
		SELECT @NoOfDevStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfDevStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'
		AND SeasonYearID = @SeasonYearID
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'
		AND SeasonYearID = @SeasonYearID
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'
		AND SeasonYearID = @SeasonYearID
		-- Retail Units
		SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'
		AND SeasonYearID = @SeasonYearID
		-- Ecom Units
		SELECT @EcomUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @EcomUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'
		AND SeasonYearID = @SeasonYearID

		-- Total Projected Units
		SELECT @TotalUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @TotalUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'
		AND SeasonYearID = @SeasonYearID
				
		-- Planned Budget
		SELECT @PlannedBudget = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @PlannedBudget
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'
		AND SeasonYearID = @SeasonYearID
	
		-- Extented Cost
		SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'
		AND SeasonYearID = @SeasonYearID
		-- Extended Wholesale
		SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'
		AND SeasonYearID = @SeasonYearID
		-- Extended Retail
		SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'
		AND SeasonYearID = @SeasonYearID
		-- Extended Ecom
		SELECT @ExtendedEcom = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedEcom
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'
		AND SeasonYearID = @SeasonYearID
	
		-- Gross Profit
		SELECT @GrossProfit = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossProfit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'
		AND SeasonYearID = @SeasonYearID
	
	
		-- Avg Cost/Unit
		IF (@TotalUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'
		AND SeasonYearID = @SeasonYearID
					
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'
		AND SeasonYearID = @SeasonYearID
					
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'
		AND SeasonYearID = @SeasonYearID

		-- Retail Cost/Unit
		IF (@EcomUnits = 0)
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgEcomPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000023'
		AND SeasonYearID = @SeasonYearID

	
		-- Wholesale Gross Margin
		IF (@ExtendedWholesale = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'
		AND SeasonYearID = @SeasonYearID
		
		-- Retail Gross Margin
		IF (@ExtendedRetail = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'
		AND SeasonYearID = @SeasonYearID
		
		-- Ecom Gross Margin
		IF (@ExtendedEcom = 0)
			SET @GrossMarginEcom = 0
		ELSE
			SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginEcom
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000027'
		AND SeasonYearID = @SeasonYearID
		
		-- Gross margin
		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)		
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMargin
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000028'
		AND SeasonYearID = @SeasonYearID		
		
		
		FETCH NEXT FROM @DivisionsCursor INTO @CurrentDivisionID
	END
	
	CLOSE @DivisionsCursor
	DEALLOCATE @DivisionsCursor
	
	
	-- Updating calculated values for all brands (highest level in hierarchy)
	DECLARE @BrandsCursor CURSOR
	SET @BrandsCursor = CURSOR SCROLL
	FOR SELECT PlanningBrandID FROM #tmpAttributeList
	WHERE PlanningBrandID IS NOT NULL AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL
	OPEN @BrandsCursor
	
	FETCH NEXT FROM @BrandsCursor INTO @CurrentBrandID
	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Number of Styles
		SELECT @NoOfStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'			
		AND SeasonYearID = @SeasonYearID
		-- Number of Dev.Styles
		SELECT @NoOfDevStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfDevStyles
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'			
		AND SeasonYearID = @SeasonYearID
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'
		AND SeasonYearID = @SeasonYearID
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'
		AND SeasonYearID = @SeasonYearID
		-- Retail Units
		SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'
		AND SeasonYearID = @SeasonYearID
		-- Ecom Units
		SELECT @EcomUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @EcomUnits
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'
		AND SeasonYearID = @SeasonYearID

		-- Total Projected Units
		SELECT @TotalUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @TotalUnits
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'
		AND SeasonYearID = @SeasonYearID
				
		-- Planned Budget
		SELECT @PlannedBudget = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @PlannedBudget
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'
		AND SeasonYearID = @SeasonYearID
	
		-- Extented Cost
		SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'
		AND SeasonYearID = @SeasonYearID
		-- Extended Wholesale
		SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'
		AND SeasonYearID = @SeasonYearID
		-- Extended Retail
		SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'
		AND SeasonYearID = @SeasonYearID
		-- Extended Ecom
		SELECT @ExtendedEcom = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedEcom
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'
		AND SeasonYearID = @SeasonYearID
	
		-- Gross Profit
		SELECT @GrossProfit = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'		
		AND SeasonYearID = @SeasonYearID
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossProfit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'
		AND SeasonYearID = @SeasonYearID
	
	
		-- Avg Cost/Unit
		IF (@TotalUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'
		AND SeasonYearID = @SeasonYearID
					
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'
		AND SeasonYearID = @SeasonYearID
					
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'
		AND SeasonYearID = @SeasonYearID

		-- Retail Cost/Unit
		IF (@EcomUnits = 0)
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgEcomPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000023'
		AND SeasonYearID = @SeasonYearID

	
		-- Wholesale Gross Margin
		IF (@ExtendedWholesale = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'
		AND SeasonYearID = @SeasonYearID
		
		-- Retail Gross Margin
		IF (@ExtendedRetail = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'
		AND SeasonYearID = @SeasonYearID
		
		-- Ecom Gross Margin
		IF (@ExtendedEcom = 0)
			SET @GrossMarginEcom = 0
		ELSE
			SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginEcom
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000027'
		AND SeasonYearID = @SeasonYearID
		
		-- Gross margin
		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)		
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMargin
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000028'
		AND SeasonYearID = @SeasonYearID		
		
		FETCH NEXT FROM @BrandsCursor INTO @CurrentBrandID
	END
	
	CLOSE @BrandsCursor
	DEALLOCATE @BrandsCursor
	
	DROP TABLE #tmpAttributeList
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07521', GetDate())
GO
