IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_FinancialPlanning_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_FinancialPlanning_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_FinancialPlanning_SELECT]
	@Division NVARCHAR(MAX)
	, @LineFolder NVARCHAR(MAX)
	, @LineListType NVARCHAR(MAX)
	, @StyleType NVARCHAR(MAX)
	, @StyleCategory NVARCHAR(MAX)
	, @SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	CREATE TABLE #tmpAllData (
		FinancialID UNIQUEIDENTIFIER
		, LYValue DECIMAL(18,5)
		, PlanValue DECIMAL(18,5)
		, DIPValue DECIMAL(18,5)
		, ActValue DECIMAL(18,5)
	)
	
	INSERT INTO #tmpAllData (FinancialID)
	SELECT LineFolderFinancialID FROM pLineFolderFinancial WHERE Active = 1

	CREATE TABLE #tmpLineListType (LineListTypeID UNIQUEIDENTIFIER)
	INSERT INTO #tmpLineListType SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@LineListType,',')
	
	CREATE TABLE #tmpLineFolder (LineFolderID UNIQUEIDENTIFIER)
	INSERT INTO #tmpLineFolder SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@LineFolder,',')
	
	CREATE TABLE #tmpDivision (DivisionID UNIQUEIDENTIFIER)
	INSERT INTO #tmpDivision SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@Division,',')
	
	CREATE TABLE #tmpStyleType (StyleTypeID INT)
	IF -1 NOT IN (SELECT items FROM Split(@StyleType,','))
		INSERT INTO #tmpStyleType SELECT CAST(value AS INT) FROM fnx_Split(@StyleType,',')
	ELSE
		INSERT INTO #tmpStyleType SELECT StyleTypeID FROM pStyleType
		
	CREATE TABLE #tmpStyleCategory (StyleCategoryID UNIQUEIDENTIFIER)
	IF '00000000-0000-0000-0000-000000000000' NOT IN (SELECT items FROM Split(@StyleCategory,','))
		INSERT INTO #tmpStyleCategory SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@StyleCategory,',')
	ELSE
		INSERT INTO #tmpStyleCategory SELECT StyleCategoryId FROM pStyleCategory		

	DECLARE @StyleList AS TABLE(StyleID UNIQUEIDENTIFIER)

	/**
	* Declaring column variables
	*/
	
	DECLARE @NoOfStyles DECIMAL(18,5)
	DECLARE @NoOfCarryOverStyles DECIMAL(18,5)
	DECLARE @WHSUnits DECIMAL(18, 5)
	DECLARE @TotalUnits DECIMAL(18, 5)
	DECLARE @RetailUnits DECIMAL(18, 5)
	DECLARE @AvgCostUnit DECIMAL(18, 5)
	DECLARE @AvgWHSPriceUnit DECIMAL(18, 5)
	DECLARE @AvgRetPriceUnit DECIMAL(18, 5)
	DECLARE @ExtendedWholesale DECIMAL(18, 5)
	DECLARE @ExtendedRetail DECIMAL(18, 5)
	DECLARE @ExtendedCost DECIMAL(18, 5)
	DECLARE @GrossMarginWHS DECIMAL(18, 5)
	DECLARE @GrossMarginRet DECIMAL(18, 5)
	
-----------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------DIP--------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------	
	
	INSERT INTO @StyleList(StyleID)
	SELECT DISTINCT sh.StyleID
	FROM pStyleHeader sh
		INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID
		INNER JOIN #tmpLineFolder tlf ON lfi.LineFolderID = tlf.LineFolderID
		INNER JOIN #tmpStyleCategory tsc ON sh.StyleCategory = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON sh.StyleType = tst.StyleTypeID
		INNER JOIN #tmpDivision td ON sh.DivisionID = td.DivisionID
	WHERE sh.StyleID NOT IN(SELECT sci.StyleID
							FROM pSourcingCommitmentItem sci INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
							WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
	
	-- Sum of all styles
	SELECT @NoOfStyles = COUNT(StyleID) FROM @StyleList
	
	-- Sum of all Carry Over styles
	SELECT @NoOfCarryOverStyles = COUNT(sh.StyleID) FROM pStyleHeader sh INNER JOIN @StyleList sl ON sl.StyleID = sh.StyleID WHERE sh.IntroSeasonYearID <> @SeasonYearID
	
	-- Sum of Wholesale Units in Style Costing Headers for given Season Year
	SELECT @WHSUnits = SUM(StyleCostingCustomField6) FROM pStyleCostingHeader sch
			INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
			
	-- Sum of Retail Units in Style Costing Headers for given Season Year
	SELECT @RetailUnits = SUM(StyleCostingCustomField7) FROM pStyleCostingHeader sch 
			INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
			INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
	
	-- Sum of Total Units in Style Costing Headers for given Season Year
	SELECT @TotalUnits = SUM(StyleCostingCustomField8) FROM pStyleCostingHeader sch
			INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
			INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
	
	-- Avg. Cost / Unit
	IF @TotalUnits = 0
		SET @AvgCostUnit = 0
	ELSE
		-- Sum of (Total Cost * Projected Units) div by sum of Projected Units
		SELECT @AvgCostUnit = SUM(StyleCostingCustomField8 * StyleCostingCustomField10)/@TotalUnits FROM pStyleCostingHeader sch
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID		
	
	-- Avg. Wholesale Price / Unit
	IF @WHSUnits = 0
		SET @AvgWHSPriceUnit = 0
	ELSE
		-- Sum of (WHS Price * WHS Units) div by sum of WHS Units
		SELECT @AvgWHSPriceUnit = SUM(StyleCostingCustomField1 * StyleCostingCustomField6)/@WHSUnits FROM pStyleCostingHeader sch
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
	
	-- Avg. Retail Price / Unit
	IF @RetailUnits = 0
		SET @AvgRetPriceUnit = 0
	ELSE
		-- Sum of (Retail Cost * Retail Units) div by sum of Retail Units
		SELECT @AvgRetPriceUnit = SUM(StyleCostingCustomField7 * StyleCostingCustomField2)/@RetailUnits FROM pStyleCostingHeader sch
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
	
	-- Sum of (WHS Price * WHS Units)
	SELECT @ExtendedWholesale = SUM(StyleCostingCustomField1 * StyleCostingCustomField6) FROM pStyleCostingHeader sch
			INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
			INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 
	
	-- Sum of (Retail Price * Retail Units)
	SELECT @ExtendedRetail = SUM(StyleCostingCustomField7 * StyleCostingCustomField2) FROM pStyleCostingHeader sch
			INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
			INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 

	-- Sum of (Total Cost * Total Units)			
	SELECT @ExtendedCost = SUM(StyleCostingCustomField8 * StyleCostingCustomField10) FROM pStyleCostingHeader sch
			INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
			INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
	
	-- Gross Margins
	IF (@AvgWHSPriceUnit = 0)
		SET @GrossMarginWHS = 0
	ELSE
		SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
	--
	IF (@AvgRetPriceUnit = 0)
		SET @GrossMarginRet = 0
	ELSE
		SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit				
	
	UPDATE #tmpAllData SET DIPValue = ISNULL(@NoOfStyles, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000000'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@NoOfCarryOverStyles, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000001'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@WHSUnits, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000004'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@RetailUnits, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000005'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@AvgCostUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000006'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@AvgWHSPriceUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000007'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@AvgRetPriceUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000008'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@ExtendedWholesale, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000009'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@ExtendedRetail, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000010'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@ExtendedCost, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000011'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@GrossMarginWHS, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000012'
	UPDATE #tmpAllData SET DIPValue = ISNULL(@GrossMarginRet, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000013'

-----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------ACTUAL--------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
	DELETE FROM @StyleList

	INSERT INTO @StyleList(StyleID)
	SELECT DISTINCT sh.StyleID
	FROM pStyleHeader sh
		INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID
		INNER JOIN #tmpLineFolder tlf ON lfi.LineFolderID = tlf.LineFolderID
		INNER JOIN #tmpStyleCategory tsc ON sh.StyleCategory = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON sh.StyleType = tst.StyleTypeID
		INNER JOIN #tmpDivision td ON sh.DivisionID = td.DivisionID
	WHERE sh.StyleID IN(SELECT sci.StyleID
						FROM pSourcingCommitmentItem sci INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
						WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)

	-- Number of Styles
	SELECT @NoOfStyles = COUNT(*) FROM @StyleList
			
	-- Number of Carry Over Styles
	SELECT @NoOfCarryOverStyles = COUNT(sh.StyleID) FROM pStyleHeader sh INNER JOIN @StyleList sl ON sl.StyleID = sh.StyleID WHERE sh.IntroSeasonYearID <> @SeasonYearID

	-- Planned Wholesale Units
	SELECT @WHSUnits = SUM(sci.StyleQuoteItemCustomField2) FROM pSourcingCommitmentItem  sci 
		INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	-- Retail Units
	SELECT @RetailUnits = SUM(sci.StyleQuoteItemCustomField6) FROM pSourcingCommitmentItem  sci  
		INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	-- Avg Cost / Unit
	SELECT @TotalUnits = SUM(sci.StyleQuoteItemCustomField16) FROM pSourcingCommitmentItem  sci 
		INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	IF @TotalUnits = 0
		SET @AvgCostUnit = 0
	ELSE
		SELECT @AvgCostUnit = SUM(sci.StyleQuoteItemCustomField24)/@TotalUnits FROM pSourcingCommitmentItem  sci 
			INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	-- Avg Wholesale Price / Unit
	IF @WHSUnits = 0
		SET @AvgWHSPriceUnit = 0
	ELSE
		SELECT @AvgWHSPriceUnit = (SUM(sci.StyleCostingCustomField15 * sci.StyleQuoteItemCustomField2)/ @WHSUnits) FROM pSourcingCommitmentItem  sci 
			INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	-- Avg Retail Price / Unit
	IF @RetailUnits = 0
		SET @AvgRetPriceUnit = 0
	ELSE
		SELECT @AvgRetPriceUnit = (SUM(sci.StyleCostingCustomField16 * sci.StyleQuoteItemCustomField6) / @RetailUnits) FROM pSourcingCommitmentItem  sci  
			INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	--Extended WHS and Retail	
	SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
	SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit
	
	-- Extended Cost
	SELECT @ExtendedCost = SUM(sci.StyleQuoteItemCustomField24) FROM pSourcingCommitmentItem  sci 
		INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
	
	-- Gross Margins
	IF (@AvgWHSPriceUnit = 0)
		SET @GrossMarginWHS = 0
	ELSE
		SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
	IF (@AvgRetPriceUnit = 0)
		SET @GrossMarginRet = 0
	ELSE
		SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit

	UPDATE #tmpAllData SET ActValue = ISNULL(@NoOfStyles, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000000'
	UPDATE #tmpAllData SET ActValue = ISNULL(@NoOfCarryOverStyles, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000001'
	UPDATE #tmpAllData SET ActValue = ISNULL(@WHSUnits, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000004'
	UPDATE #tmpAllData SET ActValue = ISNULL(@RetailUnits, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000005'
	UPDATE #tmpAllData SET ActValue = ISNULL(@AvgCostUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000006'
	UPDATE #tmpAllData SET ActValue = ISNULL(@AvgWHSPriceUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000007'
	UPDATE #tmpAllData SET ActValue = ISNULL(@AvgRetPriceUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000008'
	UPDATE #tmpAllData SET ActValue = ISNULL(@ExtendedWholesale, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000009'
	UPDATE #tmpAllData SET ActValue = ISNULL(@ExtendedRetail, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000010'
	UPDATE #tmpAllData SET ActValue = ISNULL(@ExtendedCost, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000011'
	UPDATE #tmpAllData SET ActValue = ISNULL(@GrossMarginWHS, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000012'
	UPDATE #tmpAllData SET ActValue = ISNULL(@GrossMarginRet, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000013'

-----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------PLANNING------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------	

	-- Number of Styles
	SELECT @NoOfStyles = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
	
	-- Number of Carry Over Styles
	SELECT @NoOfCarryOverStyles = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
	
	-- Planned Wholesale Units
	SELECT @WHSUnits = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
	
	-- Planned Retail Units
	SELECT @RetailUnits = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'
	
	-- Avg Cost/Unit
	IF (@WHSUnits + @RetailUnits = 0)
		SET @AvgCostUnit = 0
	ELSE
		-- SUM(Total Cost)/SUM(Total Units)
		SELECT @AvgCostUnit = SUM(CAST(LineFolderBus1 AS DECIMAL(18, 5)))/(@WHSUnits + @RetailUnits)
		FROM pLineFolderBusiness lfb
			INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
			INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
			INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
			INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
		WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
	
	-- WHS Cost/Unit
	IF (@WHSUnits = 0)
		SET @AvgWHSPriceUnit = 0
	ELSE
		-- SUM(Wholesale Cost)/SUM(WHS Units)
		SELECT @AvgWHSPriceUnit = SUM(CAST(LineFolderBus2 AS DECIMAL(18, 5)))/(@WHSUnits)
		FROM pLineFolderBusiness lfb
			INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
			INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
			INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
			INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
		WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
	
	-- Retail Cost/Unit
	IF (@RetailUnits = 0)
		SET @AvgRetPriceUnit = 0
	ELSE
		-- SUM(Retail Cost)/SUM(Retail Units)
		SELECT @AvgRetPriceUnit = SUM(CAST(LineFolderBus3 AS DECIMAL(18, 5)))/(@RetailUnits)
		FROM pLineFolderBusiness lfb
			INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
			INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
			INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
			INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
		WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		
	-- Extended wholesale
	SELECT @ExtendedWholesale = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
	
	-- Extended retail
	SELECT @ExtendedRetail = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
	
	-- Extended cost
	SELECT @ExtendedCost = SUM(LineFolderPlanningCh)
	FROM pLineFolderBusiness lfb
		INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
		INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
		INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfb.LineFolderID = tlf.LineFolderID
	WHERE lfb.LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
	
	-- Gross Margins
	IF (@AvgWHSPriceUnit = 0)
		SET @GrossMarginWHS = 0
	ELSE
		SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
	IF (@AvgRetPriceUnit = 0)
		SET @GrossMarginRet = 0
	ELSE
		SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit

	UPDATE #tmpAllData SET PlanValue = ISNULL(@NoOfStyles, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000000'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@NoOfCarryOverStyles, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000001'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@WHSUnits, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000004'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@RetailUnits, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000005'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@AvgCostUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000006'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@AvgWHSPriceUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000007'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@AvgRetPriceUnit, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000008'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@ExtendedWholesale, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000009'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@ExtendedRetail, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000010'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@ExtendedCost, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000011'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@GrossMarginWHS, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000012'
	UPDATE #tmpAllData SET PlanValue = ISNULL(@GrossMarginRet, 0) WHERE FinancialID = '10000000-0000-0000-0000-000000000013'

-----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------LAST YEAR-----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

	UPDATE #tmpAllData
	SET LYValue = ly.LYValue
	FROM
		(SELECT
			lfb.LineFolderFinancialID
			, AVG (ISNULL(lfb.LineFolderActualCh, 0)) AS LYValue
		FROM pLineFolderHistorical lfh
			INNER JOIN #tmpLineFolder tlf ON lfh.LineFolderMasterID = tlf.LineFolderID
			INNER JOIN pLineFolderBusiness lfb ON lfh.LineFolderID = lfb.LineFolderID
			INNER JOIN #tmpDivision td ON lfb.LineFolderDivisionID = td.DivisionID
			INNER JOIN #tmpStyleCategory tsc ON lfb.LineFolderStyleCategoryID = tsc.StyleCategoryID
			INNER JOIN #tmpStyleType tst ON lfb.LineFolderStyleTypeID = tst.StyleTypeID
		GROUP BY lfb.LineFolderFinancialID) ly
	WHERE FinancialID = ly.LineFolderFinancialID
	
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

	SELECT
		lff.LineFolderFinancialText
		, tad.LYValue
		, tad.PlanValue
		, tad.DIPValue
		, tad.ActValue
		, lff.LineFolderFinancialDataFormat
		, lff.LineFolderFinancialCssClass
	FROM #tmpAllData tad
		INNER JOIN pLineFolderFinancial lff ON tad.FinancialID = lff.LineFolderFinancialID
	ORDER BY lff.LineFolderFinancialSort

	DROP TABLE #tmpLineListType
	DROP TABLE #tmpLineFolder
	DROP TABLE #tmpDivision
	DROP TABLE #tmpStyleType
	DROP TABLE #tmpStyleCategory
	DROP TABLE #tmpAllData
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05433', GetDate())
GO
