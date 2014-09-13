/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_PlanningLogic_UPDATE]    Script Date: 03/20/2013 18:10:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningBusiness_PlanningLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_PlanningLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_PlanningLogic_UPDATE]    Script Date: 03/20/2013 18:10:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_PlanningLogic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	-- Getting all the categories, style types and divisions in current line folder
	CREATE TABLE #tmpAttributeList (DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT)


	INSERT INTO #tmpAttributeList
	EXEC spx_LineFolder_LinePlanningAttribute_SELECT @LineFolderID
	
	/*
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
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER
	
	-- Updating calculated values for all style categories (lowest level in hierarchy)
	SET @CategoriesCursor = CURSOR SCROLL
	FOR SELECT DivisionID, StyleTypeID, StyleCategoryID FROM #tmpAttributeList WHERE AttributeLevel = 3
	OPEN @CategoriesCursor
	FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		-- Number of Styles
		SELECT @NoOfStyles = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		-- Planned Wholesale Units
		SELECT @WHSUnits = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		-- Retail Units
		SELECT @RetailUnits = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'
		-- Avg Cost / Unit
		SELECT @AvgCostUnit = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000006'
		-- Avg Wholesale Price / Unit
		SELECT @AvgWHSPriceUnit = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000007'
		-- Avg Retail Price / Unit
		SELECT @AvgRetPriceUnit = LineFolderPlanningCh FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000008'
		
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
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedWholesale
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		-- Update extended retail
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedRetail
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		-- Update extended cost
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedCost
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
		-- Update gross margin WHS
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @GrossMarginWHS
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000012'
		-- Update gross margin retail
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @GrossMarginRet
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000013'
		
		-- Set total cost for calculations in Types and Divisions
		UPDATE pLineFolderBusiness SET LineFolderBus1 = (@WHSUnits + @RetailUnits) * @AvgCostUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Set wholesale cost for calculations in Types and Divisions
		UPDATE pLineFolderBusiness SET LineFolderBus2 = @WHSUnits  * @AvgWHSPriceUnit 
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Set retail cost for calculations in Types and Divisions
		UPDATE pLineFolderBusiness SET LineFolderBus3 = @RetailUnits  * @AvgRetPriceUnit 
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID = @CurrentStyleCategoryID AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		
		
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
	-- Updating calculated values for all style types (second level in hierarchy)
	DECLARE @TypesCursor CURSOR
	SET @TypesCursor = CURSOR SCROLL
	FOR SELECT DivisionID, StyleTypeID FROM #tmpAttributeList WHERE AttributeLevel = 2
	OPEN @TypesCursor
	
	FETCH NEXT FROM @TypesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		-- Number of Styles
		SELECT @NoOfStyles = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		-- Planned Retail Units
		SELECT @RetailUnits = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'
		-- Avg Cost/Unit
		IF (@WHSUnits + @RetailUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = SUM(CAST(LineFolderBus1 AS DECIMAL(18, 5)))/(@WHSUnits + @RetailUnits) FROM pLineFolderBusiness
			WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
			AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Total Cost)/SUM(Total Units)
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = SUM(CAST(LineFolderBus2 AS DECIMAL(18, 5)))/(@WHSUnits) FROM pLineFolderBusiness
			WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
			AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Wholesale Cost)/SUM(WHS Units)
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = SUM(CAST(LineFolderBus3 AS DECIMAL(18, 5)))/(@RetailUnits) FROM pLineFolderBusiness
			WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
			AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Retail Cost)/SUM(Retail Units)
		-- Extended wholesale
		SELECT @ExtendedWholesale = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		-- Extended retail
		SELECT @ExtendedRetail = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		-- Extended cost
		SELECT @ExtendedCost = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
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
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @NoOfStyles
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Update Number of Carry Over Styles
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @NoOfCarryOverStyles
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		-- Update Wholesale Units
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @WHSUnits
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		-- Update Retail Units
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @RetailUnits
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'		
		-- Update Average Cost/Unit
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @AvgCostUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000006'
		-- Update Average Wholesale Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @AvgWHSPriceUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000007'
		-- Update Average Retail Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @AvgRetPriceUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000008'
		-- Update extended wholesale
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedWholesale
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		-- Update extended retail
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedRetail
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		-- Update extended cost
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedCost
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
		-- Update gross margin WHS
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @GrossMarginWHS
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000012'
		-- Update gross margin retail
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @GrossMarginRet
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID = @CurrentStyleTypeID
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000013'
		
		FETCH NEXT FROM @TypesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID
	END
	
	CLOSE @TypesCursor
	DEALLOCATE @TypesCursor
	
	-- Updating calculated values for all division (highest level in hierarchy)
	DECLARE @DivisionsCursor CURSOR
	SET @DivisionsCursor = CURSOR SCROLL
	FOR SELECT DivisionID FROM #tmpAttributeList WHERE AttributeLevel = 1
	OPEN @DivisionsCursor
	
	FETCH NEXT FROM @DivisionsCursor INTO @CurrentDivisionID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		-- Number of Styles
		SELECT @NoOfStyles = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		-- Planned Wholesale Units
		SELECT @WHSUnits = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID 
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		-- Planned Retail Units
		SELECT @RetailUnits = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'
		-- Avg Cost/Unit
		IF (@WHSUnits + @RetailUnits = 0)
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = SUM(CAST(LineFolderBus1 AS DECIMAL(18, 5)))/(@WHSUnits + @RetailUnits) FROM pLineFolderBusiness
			WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID 
			AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Total Cost)/SUM(Total Units)
		-- WHS Cost/Unit
		IF (@WHSUnits = 0)
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = SUM(CAST(LineFolderBus2 AS DECIMAL(18, 5)))/(@WHSUnits) FROM pLineFolderBusiness
			WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID
			AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Wholesale Cost)/SUM(WHS Units)
		-- Retail Cost/Unit
		IF (@RetailUnits = 0)
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = SUM(CAST(LineFolderBus3 AS DECIMAL(18, 5)))/(@RetailUnits) FROM pLineFolderBusiness
			WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID 
			AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000' -- SUM(Retail Cost)/SUM(Retail Units)
		-- Extended wholesale
		SELECT @ExtendedWholesale = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID 
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		-- Extended retail
		SELECT @ExtendedRetail = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID 
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		-- Extended cost
		SELECT @ExtendedCost = SUM(LineFolderPlanningCh) FROM pLineFolderBusiness
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID 
		AND LineFolderStyleCategoryID IS NOT NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
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
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @NoOfStyles
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Update Number of Carry Over Styles
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @NoOfCarryOverStyles
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		-- Update Wholesale Units
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @WHSUnits
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		-- Update Retail Units
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @RetailUnits
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'		
		-- Update Average Cost/Unit
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @AvgCostUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000006'
		-- Update Average Wholesale Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @AvgWHSPriceUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000007'
		-- Update Average Retail Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @AvgRetPriceUnit
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000008'
		-- Update extended wholesale
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedWholesale
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		-- Update extended retail
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedRetail
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		-- Update extended cost
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @ExtendedCost
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
		-- Update gross margin WHS
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @GrossMarginWHS
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000012'
		-- Update gross margin retail
		UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @GrossMarginRet
		WHERE LineFolderID = @LineFolderID AND LineFolderDivisionID = @CurrentDivisionID AND LineFolderStyleTypeID IS NULL
		AND LineFolderStyleCategoryID IS NULL AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000013'
		
		FETCH NEXT FROM @DivisionsCursor INTO @CurrentDivisionID
	END
	
	CLOSE @DivisionsCursor
	DEALLOCATE @DivisionsCursor
	
	DROP TABLE #tmpAttributeList
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05364', GetDate())
GO
