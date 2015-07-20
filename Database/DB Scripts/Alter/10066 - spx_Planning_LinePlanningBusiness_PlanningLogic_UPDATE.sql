IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]    Script Date: 03/18/2015 12:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
	DECLARE @NoOfColorways DECIMAL(18, 5)
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
			, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
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
					AND SeasonYearID = @SeasonYearID AND Active = 1
		) pvt PIVOT(MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (
			[10000000-0000-0000-0000-000000000000],
			[10000000-0000-0000-0000-000000000019],
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
				, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
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
						AND SeasonYearID = @SeasonYearID AND Active = 1
			) pvt PIVOT(MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (
				[10000000-0000-0000-0000-000000000000],
				[10000000-0000-0000-0000-000000000019],
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
		
			SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
				, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
				, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
				, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
				, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
				, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
				, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
				, @TotalUnits			= [10000000-0000-0000-0000-000000000022]				
				, @PlannedBudget		= [10000000-0000-0000-0000-000000000024]
				, @ExtendedCost			= [10000000-0000-0000-0000-000000000011]
				, @ExtendedWholesale	= [10000000-0000-0000-0000-000000000009]
				, @ExtendedRetail		= [10000000-0000-0000-0000-000000000010]
				, @ExtendedEcom			= [10000000-0000-0000-0000-000000000025]
				, @GrossProfit			= [10000000-0000-0000-0000-000000000026]
			FROM (
				SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
					WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
						AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NOT NULL								
						AND SeasonYearID = @SeasonYearID AND Active = 1
			) pvt PIVOT(SUM(PlanningPlanningCh) FOR PlanningFinancialID IN (
				[10000000-0000-0000-0000-000000000000],
				[10000000-0000-0000-0000-000000000019],
				[10000000-0000-0000-0000-000000000020],
				[10000000-0000-0000-0000-000000000001],
				[10000000-0000-0000-0000-000000000004],
				[10000000-0000-0000-0000-000000000005],
				[10000000-0000-0000-0000-000000000021],
				[10000000-0000-0000-0000-000000000022],				
				[10000000-0000-0000-0000-000000000024],
				[10000000-0000-0000-0000-000000000011],
				[10000000-0000-0000-0000-000000000009],
				[10000000-0000-0000-0000-000000000010],
				[10000000-0000-0000-0000-000000000025],
				[10000000-0000-0000-0000-000000000026])) fin
				
			-- Avg Cost/Unit
			IF (@TotalUnits = 0)
				SET @AvgCostUnit = 0
			ELSE
				SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
				
			-- WHS Cost/Unit
			IF (@WHSUnits = 0)
				SET @AvgWHSPriceUnit = 0
			ELSE
				SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
				
			-- Retail Cost/Unit
			IF (@RetailUnits = 0)
				SET @AvgRetPriceUnit = 0
			ELSE
				SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
				
			-- Retail Cost/Unit
			IF (@EcomUnits = 0)
				SET @AvgEcomPriceUnit = 0
			ELSE
				SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
				
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
					WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
					WHEN '10000000-0000-0000-0000-000000000019' THEN @NoOfColorways
					WHEN '10000000-0000-0000-0000-000000000020' THEN @NoOfDevStyles
					WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
					WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
					WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
					WHEN '10000000-0000-0000-0000-000000000021' THEN @EcomUnits
					WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
					WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget					
					WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
					WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
					WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
					WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom					
					WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
					WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
					WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
					WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
					WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcomPriceUnit					
					WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
					WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
					WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
					WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
					ELSE PlanningPlanningCh END
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
				AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL			
				AND SeasonYearID = @SeasonYearID
				AND PlanningFinancialID IN (
					'10000000-0000-0000-0000-000000000000',
					'10000000-0000-0000-0000-000000000019',
					'10000000-0000-0000-0000-000000000020',
					'10000000-0000-0000-0000-000000000001',
					'10000000-0000-0000-0000-000000000004',
					'10000000-0000-0000-0000-000000000005',
					'10000000-0000-0000-0000-000000000021',
					'10000000-0000-0000-0000-000000000022',
					'10000000-0000-0000-0000-000000000024',
					'10000000-0000-0000-0000-000000000011',
					'10000000-0000-0000-0000-000000000009',
					'10000000-0000-0000-0000-000000000010',
					'10000000-0000-0000-0000-000000000025',
					'10000000-0000-0000-0000-000000000026',
					'10000000-0000-0000-0000-000000000006',
					'10000000-0000-0000-0000-000000000007',
					'10000000-0000-0000-0000-000000000008',
					'10000000-0000-0000-0000-000000000023',
					'10000000-0000-0000-0000-000000000012',
					'10000000-0000-0000-0000-000000000013',
					'10000000-0000-0000-0000-000000000027',
					'10000000-0000-0000-0000-000000000028')
		END
		
		SET @CategoriesRow = @CategoriesRow + 1		
	END
	
	-- Updating calculated values for all style types (second level in hierarchy)
	DECLARE @StyleTypes TABLE(
		RowNo INT IDENTITY(1, 1),
		PlanningDivisionID UNIQUEIDENTIFIER,
		PlanningStyleTypeID INT
	)
	INSERT INTO @StyleTypes(PlanningDivisionID, PlanningStyleTypeID)
	SELECT PlanningDivisionID, PlanningStyleTypeID FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NOT NULL AND PlanningStyleCategoryID IS NULL
	
	DECLARE @StyleTypesRow INT = 1,
			@StyleTypesTotal INT = (SELECT COUNT(*) FROM @StyleTypes)
	
	WHILE @StyleTypesRow <= @StyleTypesTotal
	BEGIN
		
		SELECT @CurrentDivisionID = PlanningDivisionID
			, @CurrentStyleTypeID = PlanningStyleTypeID 
		FROM @StyleTypes WHERE RowNo = @StyleTypesRow
		
		SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
			, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
			, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
			, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
			, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
			, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
			, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
			, @TotalUnits			= [10000000-0000-0000-0000-000000000022]				
			, @PlannedBudget		= [10000000-0000-0000-0000-000000000024]
			, @ExtendedCost			= [10000000-0000-0000-0000-000000000011]
			, @ExtendedWholesale	= [10000000-0000-0000-0000-000000000009]
			, @ExtendedRetail		= [10000000-0000-0000-0000-000000000010]
			, @ExtendedEcom			= [10000000-0000-0000-0000-000000000025]
			, @GrossProfit			= [10000000-0000-0000-0000-000000000026]
		FROM (
			SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
				WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
					AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL		
					AND SeasonYearID = @SeasonYearID AND Active = 1
		) pvt PIVOT(SUM(PlanningPlanningCh) FOR PlanningFinancialID IN (
			[10000000-0000-0000-0000-000000000000],
			[10000000-0000-0000-0000-000000000019],
			[10000000-0000-0000-0000-000000000020],
			[10000000-0000-0000-0000-000000000001],
			[10000000-0000-0000-0000-000000000004],
			[10000000-0000-0000-0000-000000000005],
			[10000000-0000-0000-0000-000000000021],
			[10000000-0000-0000-0000-000000000022],				
			[10000000-0000-0000-0000-000000000024],
			[10000000-0000-0000-0000-000000000011],
			[10000000-0000-0000-0000-000000000009],
			[10000000-0000-0000-0000-000000000010],
			[10000000-0000-0000-0000-000000000025],
			[10000000-0000-0000-0000-000000000026])) fin
				
		-- Avg Cost/Unit
		IF (@TotalUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
			
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
			
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
			
		-- Retail Cost/Unit
		IF (@EcomUnits = 0)
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
			
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
				WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
				WHEN '10000000-0000-0000-0000-000000000019' THEN @NoOfColorways
				WHEN '10000000-0000-0000-0000-000000000020' THEN @NoOfDevStyles
				WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
				WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
				WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
				WHEN '10000000-0000-0000-0000-000000000021' THEN @EcomUnits
				WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
				WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget					
				WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
				WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
				WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
				WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom					
				WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
				WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
				WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
				WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
				WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcomPriceUnit					
				WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
				WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
				WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
				WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
				ELSE PlanningPlanningCh END
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL			
			AND SeasonYearID = @SeasonYearID
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000000',
				'10000000-0000-0000-0000-000000000019',
				'10000000-0000-0000-0000-000000000020',
				'10000000-0000-0000-0000-000000000001',
				'10000000-0000-0000-0000-000000000004',
				'10000000-0000-0000-0000-000000000005',
				'10000000-0000-0000-0000-000000000021',
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000024',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000025',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000006',
				'10000000-0000-0000-0000-000000000007',
				'10000000-0000-0000-0000-000000000008',
				'10000000-0000-0000-0000-000000000023',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000027',
				'10000000-0000-0000-0000-000000000028')
		
		SET @StyleTypesRow = @StyleTypesRow + 1
	END
	
	-- Updating calculated values for all division
	DECLARE @Divisions TABLE(
		RowNo INT IDENTITY(1, 1),
		PlanningDivisionID UNIQUEIDENTIFIER
	)
	INSERT INTO @Divisions(PlanningDivisionID)
	SELECT PlanningDivisionID FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL
	
	DECLARE @DivisionRow INT = 1,
			@DivisionTotal INT = (SELECT COUNT(*) FROM @Divisions)
	
	WHILE @DivisionRow <= @DivisionTotal
	BEGIN
	
		SELECT @CurrentDivisionID = PlanningDivisionID 
		FROM @Divisions WHERE RowNo = @DivisionRow
		
		SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
			, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
			, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
			, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
			, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
			, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
			, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
			, @TotalUnits			= [10000000-0000-0000-0000-000000000022]				
			, @PlannedBudget		= [10000000-0000-0000-0000-000000000024]
			, @ExtendedCost			= [10000000-0000-0000-0000-000000000011]
			, @ExtendedWholesale	= [10000000-0000-0000-0000-000000000009]
			, @ExtendedRetail		= [10000000-0000-0000-0000-000000000010]
			, @ExtendedEcom			= [10000000-0000-0000-0000-000000000025]
			, @GrossProfit			= [10000000-0000-0000-0000-000000000026]
		FROM (
			SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
				WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
					AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL					
					AND SeasonYearID = @SeasonYearID AND Active = 1
		) pvt PIVOT(SUM(PlanningPlanningCh) FOR PlanningFinancialID IN (
			[10000000-0000-0000-0000-000000000000],
			[10000000-0000-0000-0000-000000000019],
			[10000000-0000-0000-0000-000000000020],
			[10000000-0000-0000-0000-000000000001],
			[10000000-0000-0000-0000-000000000004],
			[10000000-0000-0000-0000-000000000005],
			[10000000-0000-0000-0000-000000000021],
			[10000000-0000-0000-0000-000000000022],				
			[10000000-0000-0000-0000-000000000024],
			[10000000-0000-0000-0000-000000000011],
			[10000000-0000-0000-0000-000000000009],
			[10000000-0000-0000-0000-000000000010],
			[10000000-0000-0000-0000-000000000025],
			[10000000-0000-0000-0000-000000000026])) fin
				
		-- Avg Cost/Unit
		IF (@TotalUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
			
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
			
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
			
		-- Retail Cost/Unit
		IF (@EcomUnits = 0)
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
			
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
				WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
				WHEN '10000000-0000-0000-0000-000000000019' THEN @NoOfColorways
				WHEN '10000000-0000-0000-0000-000000000020' THEN @NoOfDevStyles
				WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
				WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
				WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
				WHEN '10000000-0000-0000-0000-000000000021' THEN @EcomUnits
				WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
				WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget					
				WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
				WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
				WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
				WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom					
				WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
				WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
				WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
				WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
				WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcomPriceUnit					
				WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
				WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
				WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
				WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
				ELSE PlanningPlanningCh END
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
			AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL			
			AND SeasonYearID = @SeasonYearID
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000000',
				'10000000-0000-0000-0000-000000000019',
				'10000000-0000-0000-0000-000000000020',
				'10000000-0000-0000-0000-000000000001',
				'10000000-0000-0000-0000-000000000004',
				'10000000-0000-0000-0000-000000000005',
				'10000000-0000-0000-0000-000000000021',
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000024',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000025',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000006',
				'10000000-0000-0000-0000-000000000007',
				'10000000-0000-0000-0000-000000000008',
				'10000000-0000-0000-0000-000000000023',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000027',
				'10000000-0000-0000-0000-000000000028')
		
		SET @DivisionRow = @DivisionRow + 1
	END
	
	-- Updating calculated values for all brands (highest level in hierarchy)
	DECLARE @Brands TABLE(
		RowNo INT IDENTITY(1, 1),
		PlanningBrandID UNIQUEIDENTIFIER
	)	
	INSERT INTO @Brands(PlanningBrandID)
	SELECT PlanningBrandID FROM #tmpAttributeList
	WHERE PlanningBrandID IS NOT NULL AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL
	
	DECLARE @BrandRow INT = 1,
			@BrandTotal INT = (SELECT COUNT(*) FROM @Brands)
	
	WHILE @BrandRow <= @BrandTotal
	BEGIN
		
		SELECT @CurrentBrandID = PlanningBrandID 
		FROM @Brands WHERE RowNo = @BrandRow
		
		SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
			, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
			, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
			, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
			, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
			, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
			, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
			, @TotalUnits			= [10000000-0000-0000-0000-000000000022]				
			, @PlannedBudget		= [10000000-0000-0000-0000-000000000024]
			, @ExtendedCost			= [10000000-0000-0000-0000-000000000011]
			, @ExtendedWholesale	= [10000000-0000-0000-0000-000000000009]
			, @ExtendedRetail		= [10000000-0000-0000-0000-000000000010]
			, @ExtendedEcom			= [10000000-0000-0000-0000-000000000025]
			, @GrossProfit			= [10000000-0000-0000-0000-000000000026]
		FROM (
			SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
				WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
					AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL					
					AND SeasonYearID = @SeasonYearID AND Active = 1
		) pvt PIVOT(SUM(PlanningPlanningCh) FOR PlanningFinancialID IN (
			[10000000-0000-0000-0000-000000000000],
			[10000000-0000-0000-0000-000000000019],
			[10000000-0000-0000-0000-000000000020],
			[10000000-0000-0000-0000-000000000001],
			[10000000-0000-0000-0000-000000000004],
			[10000000-0000-0000-0000-000000000005],
			[10000000-0000-0000-0000-000000000021],
			[10000000-0000-0000-0000-000000000022],				
			[10000000-0000-0000-0000-000000000024],
			[10000000-0000-0000-0000-000000000011],
			[10000000-0000-0000-0000-000000000009],
			[10000000-0000-0000-0000-000000000010],
			[10000000-0000-0000-0000-000000000025],
			[10000000-0000-0000-0000-000000000026])) fin
				
		-- Avg Cost/Unit
		IF (@TotalUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
			
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
			
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
			
		-- Retail Cost/Unit
		IF (@EcomUnits = 0)
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
			
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
				WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
				WHEN '10000000-0000-0000-0000-000000000019' THEN @NoOfColorways
				WHEN '10000000-0000-0000-0000-000000000020' THEN @NoOfDevStyles
				WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
				WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
				WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
				WHEN '10000000-0000-0000-0000-000000000021' THEN @EcomUnits
				WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
				WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget					
				WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
				WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
				WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
				WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom					
				WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
				WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
				WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
				WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
				WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcomPriceUnit					
				WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
				WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
				WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
				WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
				ELSE PlanningPlanningCh END
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
			AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
			AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL			
			AND SeasonYearID = @SeasonYearID
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000000',
				'10000000-0000-0000-0000-000000000019',
				'10000000-0000-0000-0000-000000000020',
				'10000000-0000-0000-0000-000000000001',
				'10000000-0000-0000-0000-000000000004',
				'10000000-0000-0000-0000-000000000005',
				'10000000-0000-0000-0000-000000000021',
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000024',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000025',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000006',
				'10000000-0000-0000-0000-000000000007',
				'10000000-0000-0000-0000-000000000008',
				'10000000-0000-0000-0000-000000000023',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000027',
				'10000000-0000-0000-0000-000000000028')
		
		SET @BrandRow = @BrandRow + 1
	END	
	
	
	-- Update calculations for all records across all brands
	SELECT @NoOfStyles			= [10000000-0000-0000-0000-000000000000]
		, @NoOfColorways		= [10000000-0000-0000-0000-000000000019]
		, @NoOfDevStyles		= [10000000-0000-0000-0000-000000000020]
		, @NoOfCarryOverStyles	= [10000000-0000-0000-0000-000000000001]
		, @WHSUnits				= [10000000-0000-0000-0000-000000000004]
		, @RetailUnits			= [10000000-0000-0000-0000-000000000005]
		, @EcomUnits			= [10000000-0000-0000-0000-000000000021]
		, @TotalUnits			= [10000000-0000-0000-0000-000000000022]				
		, @PlannedBudget		= [10000000-0000-0000-0000-000000000024]
		, @ExtendedCost			= [10000000-0000-0000-0000-000000000011]
		, @ExtendedWholesale	= [10000000-0000-0000-0000-000000000009]
		, @ExtendedRetail		= [10000000-0000-0000-0000-000000000010]
		, @ExtendedEcom			= [10000000-0000-0000-0000-000000000025]
		, @GrossProfit			= [10000000-0000-0000-0000-000000000026]
	FROM (
		SELECT PlanningPlanningCh, PlanningFinancialID FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningBrandID IS NOT NULL
				AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL		
				AND SeasonYearID = @SeasonYearID AND Active = 1
	) pvt PIVOT(SUM(PlanningPlanningCh) FOR PlanningFinancialID IN (
		[10000000-0000-0000-0000-000000000000],
		[10000000-0000-0000-0000-000000000019],
		[10000000-0000-0000-0000-000000000020],
		[10000000-0000-0000-0000-000000000001],
		[10000000-0000-0000-0000-000000000004],
		[10000000-0000-0000-0000-000000000005],
		[10000000-0000-0000-0000-000000000021],
		[10000000-0000-0000-0000-000000000022],				
		[10000000-0000-0000-0000-000000000024],
		[10000000-0000-0000-0000-000000000011],
		[10000000-0000-0000-0000-000000000009],
		[10000000-0000-0000-0000-000000000010],
		[10000000-0000-0000-0000-000000000025],
		[10000000-0000-0000-0000-000000000026])) fin
			
	-- Avg Cost/Unit
	IF (@TotalUnits = 0)
		SET @AvgCostUnit = 0
	ELSE
		SELECT @AvgCostUnit = @PlannedBudget/@TotalUnits
		
	-- WHS Cost/Unit
	IF (@WHSUnits = 0)
		SET @AvgWHSPriceUnit = 0
	ELSE
		SELECT @AvgWHSPriceUnit = @ExtendedWholesale/@WHSUnits
		
	-- Retail Cost/Unit
	IF (@RetailUnits = 0)
		SET @AvgRetPriceUnit = 0
	ELSE
		SELECT @AvgRetPriceUnit = @ExtendedRetail/@RetailUnits
		
	-- Retail Cost/Unit
	IF (@EcomUnits = 0)
		SET @AvgEcomPriceUnit = 0
	ELSE
		SELECT @AvgEcomPriceUnit = @ExtendedEcom/@EcomUnits
		
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
			WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
			WHEN '10000000-0000-0000-0000-000000000019' THEN @NoOfColorways
			WHEN '10000000-0000-0000-0000-000000000020' THEN @NoOfDevStyles
			WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
			WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
			WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
			WHEN '10000000-0000-0000-0000-000000000021' THEN @EcomUnits
			WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
			WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget					
			WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
			WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
			WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
			WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom					
			WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
			WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
			WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
			WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
			WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcomPriceUnit					
			WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
			WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
			WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcom
			WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
			ELSE PlanningPlanningCh END
	WHERE PlanningID = @PlanningID AND PlanningBrandID IS NULL
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningSubCategoryID IS NULL			
		AND SeasonYearID = @SeasonYearID
		AND PlanningFinancialID IN (
			'10000000-0000-0000-0000-000000000000',
			'10000000-0000-0000-0000-000000000019',
			'10000000-0000-0000-0000-000000000020',
			'10000000-0000-0000-0000-000000000001',
			'10000000-0000-0000-0000-000000000004',
			'10000000-0000-0000-0000-000000000005',
			'10000000-0000-0000-0000-000000000021',
			'10000000-0000-0000-0000-000000000022',
			'10000000-0000-0000-0000-000000000024',
			'10000000-0000-0000-0000-000000000011',
			'10000000-0000-0000-0000-000000000009',
			'10000000-0000-0000-0000-000000000010',
			'10000000-0000-0000-0000-000000000025',
			'10000000-0000-0000-0000-000000000026',
			'10000000-0000-0000-0000-000000000006',
			'10000000-0000-0000-0000-000000000007',
			'10000000-0000-0000-0000-000000000008',
			'10000000-0000-0000-0000-000000000023',
			'10000000-0000-0000-0000-000000000012',
			'10000000-0000-0000-0000-000000000013',
			'10000000-0000-0000-0000-000000000027',
			'10000000-0000-0000-0000-000000000028')
	
	DROP TABLE #tmpAttributeList
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10066', GetUTCDate())
GO
