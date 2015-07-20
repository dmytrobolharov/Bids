IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT DISTINCT PlanningBrandID, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID
	INTO #tmpAttributeList
	FROM pPlanningBusiness WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
	
	/**
	* Declaring column variables
	*/
	
	DECLARE @NoOfStyles DECIMAL(18,5)
	DECLARE @NoOfCarryOverStyles DECIMAL(18,5)
	DECLARE @WHSUnits DECIMAL(18, 5)
	DECLARE @RetailUnits DECIMAL(18, 5)
	DECLARE @AvgCostUnit DECIMAL(18, 5)
	DECLARE @AvgWHSPriceUnit DECIMAL(18, 5)
	DECLARE @AvgRetPriceUnit DECIMAL(18, 5)
	DECLARE @ExtendedWholesale DECIMAL(18, 5)
	DECLARE @ExtendedRetail DECIMAL(18, 5)
	DECLARE @ExtendedCost DECIMAL(18, 5)
	DECLARE @GrossMarginWHS DECIMAL(18, 5)
	DECLARE @GrossMarginRet DECIMAL(18, 5)
	
	/*
	* Declaring cursor
	*/
	DECLARE @CategoriesCursor CURSOR
	DECLARE @CurrentBrandID UNIQUEIDENTIFIER
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER
	
	-- Updating calculated values for all style categories (lowest level in hierarchy)
	SET @CategoriesCursor = CURSOR SCROLL
	FOR SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID FROM #tmpAttributeList
	WHERE PlanningDivisionID IS NOT NULL AND PlanningStyleTypeID IS NOT NULL AND PlanningStyleCategoryID IS NOT NULL
	OPEN @CategoriesCursor
	FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		-- Number of Styles
		SELECT @NoOfStyles = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'	
		AND SeasonYearID = @SeasonYearID	
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'	
		AND SeasonYearID = @SeasonYearID	
		-- Planned Wholesale Units
		SELECT @WHSUnits = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Retail Units
		SELECT @RetailUnits = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Cost / Unit
		SELECT @AvgCostUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Wholesale Price / Unit
		SELECT @AvgWHSPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Retail Price / Unit
		SELECT @AvgRetPriceUnit = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'		
		AND SeasonYearID = @SeasonYearID
		
		SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
		SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit
		SET @ExtendedCost = (@WHSUnits + @RetailUnits) * @AvgCostUnit
		IF (@AvgWHSPriceUnit = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
		IF (@AvgRetPriceUnit = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit
		
		-- Update extended wholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'	
		AND SeasonYearID = @SeasonYearID	
		-- Update extended retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended cost
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin WHS
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'
		AND SeasonYearID = @SeasonYearID
				
		-- Set total cost for calculations in Types and Divisions
		UPDATE pPlanningBusiness SET PlanningBus1 = (@WHSUnits + @RetailUnits) * @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
		AND SeasonYearID = @SeasonYearID
		-- Set wholesale cost for calculations in Types and Divisions
		UPDATE pPlanningBusiness SET PlanningBus2 = @WHSUnits  * @AvgWHSPriceUnit 
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'		
		AND SeasonYearID = @SeasonYearID
		-- Set retail cost for calculations in Types and Divisions
		UPDATE pPlanningBusiness SET PlanningBus3 = @RetailUnits  * @AvgRetPriceUnit 
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID = @CurrentStyleCategoryID AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'				
		AND SeasonYearID = @SeasonYearID
		
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
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
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
		AND SeasonYearID = @SeasonYearID		
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'		
		AND SeasonYearID = @SeasonYearID
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Planned Retail Units
		SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Cost/Unit
		IF (@WHSUnits + @RetailUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = SUM(CAST(PlanningBus1 AS DECIMAL(18, 5)))/(@WHSUnits + @RetailUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Total Cost)/SUM(Total Units)
			AND SeasonYearID = @SeasonYearID			
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = SUM(CAST(PlanningBus2 AS DECIMAL(18, 5)))/(@WHSUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Wholesale Cost)/SUM(WHS Units)	
			AND SeasonYearID = @SeasonYearID		
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = SUM(CAST(PlanningBus3 AS DECIMAL(18, 5)))/(@RetailUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Retail Cost)/SUM(Retail Units)	
			AND SeasonYearID = @SeasonYearID		
		-- Extended wholesale
		SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		-- Extended retail
		SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Extended cost
		SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Gross Margins
		IF (@AvgWHSPriceUnit = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
		IF (@AvgRetPriceUnit = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit
		
		-- Update Number of Styles
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'		
		AND SeasonYearID = @SeasonYearID
		-- Update Number of Carry Over Styles
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'		
		AND SeasonYearID = @SeasonYearID
		-- Update Wholesale Units
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Update Retail Units
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'			
		AND SeasonYearID = @SeasonYearID
		-- Update Average Cost/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Wholesale Price/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Retail Price/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended wholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended cost
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin WHS
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID = @CurrentStyleTypeID
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'		
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
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'		
		AND SeasonYearID = @SeasonYearID
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'		
		AND SeasonYearID = @SeasonYearID
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Planned Retail Units
		SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Cost/Unit
		IF (@WHSUnits + @RetailUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = SUM(CAST(PlanningBus1 AS DECIMAL(18, 5)))/(@WHSUnits + @RetailUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID 
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
			AND SeasonYearID = @SeasonYearID
			-- SUM(Total Cost)/SUM(Total Units)
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = SUM(CAST(PlanningBus2 AS DECIMAL(18, 5)))/(@WHSUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000' 
			AND SeasonYearID = @SeasonYearID
			-- SUM(Wholesale Cost)/SUM(WHS Units)
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = SUM(CAST(PlanningBus3 AS DECIMAL(18, 5)))/(@RetailUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID 
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
			AND SeasonYearID = @SeasonYearID
			-- SUM(Retail Cost)/SUM(Retail Units)
		-- Extended wholesale
		SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		-- Extended retail
		SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Extended cost
		SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Gross Margins
		IF (@AvgWHSPriceUnit = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
		IF (@AvgRetPriceUnit = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit
		
		-- Update Number of Styles
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'		
		AND SeasonYearID = @SeasonYearID
		-- Update Number of Carry Over Styles
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'		
		AND SeasonYearID = @SeasonYearID
		-- Update Wholesale Units
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Update Retail Units
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Cost/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Wholesale Price/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Retail Price/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended wholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended cost
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin WHS
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningDivisionID = @CurrentDivisionID AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'		
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
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'		
		AND SeasonYearID = @SeasonYearID
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'		
		AND SeasonYearID = @SeasonYearID
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Planned Retail Units
		SELECT @RetailUnits = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Avg Cost/Unit
		IF (@WHSUnits + @RetailUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = SUM(CAST(PlanningBus1 AS DECIMAL(18, 5)))/(@WHSUnits + @RetailUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
			AND SeasonYearID = @SeasonYearID
			-- SUM(Total Cost)/SUM(Total Units)
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = SUM(CAST(PlanningBus2 AS DECIMAL(18, 5)))/(@WHSUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000' 
			AND SeasonYearID = @SeasonYearID
			-- SUM(Wholesale Cost)/SUM(WHS Units)
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = SUM(CAST(PlanningBus3 AS DECIMAL(18, 5)))/(@RetailUnits) FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
			AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
			AND SeasonYearID = @SeasonYearID
			-- SUM(Retail Cost)/SUM(Retail Units)
		-- Extended wholesale
		SELECT @ExtendedWholesale = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		-- Extended retail
		SELECT @ExtendedRetail = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Extended cost
		SELECT @ExtendedCost = SUM(PlanningPlanningCh) FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningStyleCategoryID IS NOT NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Gross Margins
		IF (@AvgWHSPriceUnit = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
		IF (@AvgRetPriceUnit = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit		
		
		-- Update Number of Styles
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfStyles
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000'				
		AND SeasonYearID = @SeasonYearID
		-- Update Number of Carry Over Styles
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @NoOfCarryOverStyles
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000001'		
		AND SeasonYearID = @SeasonYearID
		-- Update Wholesale Units
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @WHSUnits
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000004'		
		AND SeasonYearID = @SeasonYearID
		-- Update Retail Units
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @RetailUnits
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000005'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Cost/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgCostUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000006'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Wholesale Price/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgWHSPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000007'		
		AND SeasonYearID = @SeasonYearID
		-- Update Average Retail Price/Unit
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @AvgRetPriceUnit
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000008'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended wholesale
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedWholesale
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000009'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedRetail
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000010'		
		AND SeasonYearID = @SeasonYearID
		-- Update extended cost
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @ExtendedCost
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000011'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin WHS
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginWHS
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000012'		
		AND SeasonYearID = @SeasonYearID
		-- Update gross margin retail
		UPDATE pPlanningBusiness SET PlanningPlanningCh = @GrossMarginRet
		WHERE PlanningID = @PlanningID AND PlanningBrandID = @CurrentBrandID 
		AND PlanningDivisionID IS NULL AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL AND PlanningFinancialID = '10000000-0000-0000-0000-000000000013'		
		AND SeasonYearID = @SeasonYearID
		
		FETCH NEXT FROM @BrandsCursor INTO @CurrentBrandID
	END
	
	CLOSE @BrandsCursor
	DEALLOCATE @BrandsCursor
	
	DROP TABLE #tmpAttributeList
	
END





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06413', GetDate())
GO