IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
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
	
	/*
	* Declaring cursor
	*/
	DECLARE @CategoriesCursor CURSOR
	DECLARE @SubCategoriesCursor CURSOR
	DECLARE @CurrentBrandID UNIQUEIDENTIFIER
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER
	DECLARE @CurrentSubCategoryID UNIQUEIDENTIFIER
	DECLARE @SubCategoriesCount INT


	-- Updating calculated values for all Sub categories (lowest level in hierarchy)
	SET @SubCategoriesCursor = CURSOR SCROLL
	FOR SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NOT NULL AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NOT NULL
	OPEN @SubCategoriesCursor
	FETCH NEXT FROM @SubCategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @CurrentSubCategoryID

	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		-- Number of Styles
		SELECT @NoOfStyles = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
		AND SeasonYearID = @SeasonYearID	
		-- Number of Dev. Styles
		SELECT @NoOfDevStyles = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'	
		AND SeasonYearID = @SeasonYearID	
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
		AND SeasonYearID = @SeasonYearID	
		-- Planned Wholesale Units
		SELECT @WHSUnits = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Retail Units
		SELECT @RetailUnits = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Ecom Units
		SELECT @EcomUnits = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'		
		AND SeasonYearID = @SeasonYearID
		
		-- Total Projected Units
		SET @TotalUnits = @WHSUnits + @RetailUnits + @EcomUnits
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @TotalUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'
		AND SeasonYearID = @SeasonYearID
		
		-- Avg Cost / Unit
		SELECT @AvgCostUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Wholesale Price / Unit
		SELECT @AvgWHSPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Retail Price / Unit
		SELECT @AvgRetPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Ecom Price / Unit
		SELECT @AvgEcomPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000023'		
		AND SeasonYearID = @SeasonYearID

		-- Planned Budget
		SELECT @PlannedBudget = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'		
		AND SeasonYearID = @SeasonYearID
		
		-- Extented Cost
		SET @ExtendedCost = @TotalUnits * @AvgCostUnit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'
		AND SeasonYearID = @SeasonYearID
		-- Extended Wholesale
		SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'
		AND SeasonYearID = @SeasonYearID
		-- Extended Retail
		SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'
		AND SeasonYearID = @SeasonYearID
		-- Extended Ecom
		SET @ExtendedEcom = @EcomUnits * @AvgEcomPriceUnit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedEcom
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'
		AND SeasonYearID = @SeasonYearID
		
		-- Gross Profit
		SET @GrossProfit = (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) - @ExtendedCost
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossProfit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'
		AND SeasonYearID = @SeasonYearID
		
		-- Wholesale Gross Margin
		IF (@ExtendedWholesale = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = ((@AvgWHSPriceUnit - @AvgCostUnit)*@WHSUnits)/@ExtendedWholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'
		AND SeasonYearID = @SeasonYearID
		
		-- Retail Gross Margin
		IF (@ExtendedRetail = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = ((@AvgRetPriceUnit - @AvgCostUnit)*@RetailUnits)/@ExtendedRetail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'
		AND SeasonYearID = @SeasonYearID
		
		-- Ecom Gross Margin
		IF (@ExtendedEcom = 0)
			SET @GrossMarginEcom = 0
		ELSE
			SET @GrossMarginEcom = ((@AvgEcomPriceUnit - @AvgCostUnit)*@EcomUnits)/@ExtendedEcom
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginEcom
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000027'
		AND SeasonYearID = @SeasonYearID
		
		-- Gross margin
		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMargin
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID = @CurrentSubCategoryID
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000028'
		AND SeasonYearID = @SeasonYearID
		
		FETCH NEXT FROM @SubCategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @CurrentSubCategoryID
	END
	
	CLOSE @SubCategoriesCursor
	DEALLOCATE @SubCategoriesCursor

	
	-- Updating calculated values for all style categories (almost lowest level in hierarchy)
	SET @CategoriesCursor = CURSOR SCROLL
	FOR SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, SubCategoriesCount FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NOT NULL AND PlanningStyleCategoryID IS NOT NULL AND PlanningSubCategoryID IS NULL
	OPEN @CategoriesCursor
	FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @SubCategoriesCount
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		IF @SubCategoriesCount = 0
		BEGIN
		
			-- Number of Styles
			SELECT @NoOfStyles = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
			AND SeasonYearID = @SeasonYearID	
			-- Number of Dev. Styles
			SELECT @NoOfDevStyles = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000020'	
			AND SeasonYearID = @SeasonYearID	
			-- Number of Carry Over Styles
			SELECT @NoOfCarryOverStyles = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
			AND SeasonYearID = @SeasonYearID	
			-- Planned Wholesale Units
			SELECT @WHSUnits = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
			AND SeasonYearID = @SeasonYearID
			-- Retail Units
			SELECT @RetailUnits = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
			AND SeasonYearID = @SeasonYearID
			-- Ecom Units
			SELECT @EcomUnits = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000021'		
			AND SeasonYearID = @SeasonYearID
			
			-- Total Projected Units
			SET @TotalUnits = @WHSUnits + @RetailUnits + @EcomUnits
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @TotalUnits
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000022'
			AND SeasonYearID = @SeasonYearID
			
			-- Avg Cost / Unit
			SELECT @AvgCostUnit = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'		
			AND SeasonYearID = @SeasonYearID
			-- Avg Wholesale Price / Unit
			SELECT @AvgWHSPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'		
			AND SeasonYearID = @SeasonYearID
			-- Avg Retail Price / Unit
			SELECT @AvgRetPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'		
			AND SeasonYearID = @SeasonYearID
			-- Avg Ecom Price / Unit
			SELECT @AvgEcomPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000023'		
			AND SeasonYearID = @SeasonYearID

			-- Planned Budget
			SELECT @PlannedBudget = PlanningPlanningCh FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'		
			AND SeasonYearID = @SeasonYearID
			
			-- Extented Cost
			SET @ExtendedCost = @TotalUnits * @AvgCostUnit
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'
			AND SeasonYearID = @SeasonYearID
			-- Extended Wholesale
			SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'
			AND SeasonYearID = @SeasonYearID
			-- Extended Retail
			SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'
			AND SeasonYearID = @SeasonYearID
			-- Extended Ecom
			SET @ExtendedEcom = @EcomUnits * @AvgEcomPriceUnit
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedEcom
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000025'
			AND SeasonYearID = @SeasonYearID
			
			-- Gross Profit
			SET @GrossProfit = (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) - @ExtendedCost
			UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossProfit
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningSubCategoryID IS NULL
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000026'
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
		
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @SubCategoriesCount
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
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
VALUES ('DB_Version', '0.5.0000', '06858', GetDate())
GO
