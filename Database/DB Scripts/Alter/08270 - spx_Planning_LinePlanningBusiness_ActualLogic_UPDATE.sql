IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_ActualLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_ActualLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_ActualLogic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	/**
	* Declaring column variables
	*/
	
	DECLARE @NoOfStyles DECIMAL(18,5)
	DECLARE @NoOfCarryOverStyles DECIMAL(18,5)
	DECLARE @NoOfOverDevStyles DECIMAL(18,5)
	DECLARE @TotalUnits DECIMAL(18, 5)
	DECLARE @WHSUnits DECIMAL(18, 5)
	DECLARE @RetailUnits DECIMAL(18, 5)
	DECLARE @EcomUnits DECIMAL(18, 5)
	DECLARE @AvgCostUnit DECIMAL(18, 5)
	DECLARE @AvgWHSPriceUnit DECIMAL(18, 5)
	DECLARE @AvgRetPriceUnit DECIMAL(18, 5)
	DECLARE @AvgEcomPriceUnit DECIMAL(18, 5)
	DECLARE @ExtendedWholesale DECIMAL(18, 5)
	DECLARE @ExtendedRetail DECIMAL(18, 5)
	DECLARE @ExtendedEcom DECIMAL(18, 5)
	DECLARE @ExtendedCost DECIMAL(18, 5)
	DECLARE @GrossMargin DECIMAL(18, 5)
	DECLARE @GrossMarginWHS DECIMAL(18, 5)
	DECLARE @GrossMarginRet DECIMAL(18, 5)
	DECLARE @GrossProfit DECIMAL(18, 5)
	DECLARE @NoOfColorways DECIMAL(18,5)
	DECLARE @PlannedBudget DECIMAL(18,5)
	
	/*
	* Declaring cursor
	*/
	DECLARE @CategoriesCursor CURSOR
	DECLARE @CurrentBrandID UNIQUEIDENTIFIER
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER	
	DECLARE @CurrentSubCategoryID NVARCHAR(50)
	
	DECLARE @StyleList AS TABLE(StyleID UNIQUEIDENTIFIER)	
	
	-- Updating calculated values for all style categories (lowest level in hierarchy)
	SET @CategoriesCursor = CURSOR SCROLL
	FOR
	SELECT DISTINCT PlanningBrandID, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID
	FROM pPlanningBusiness WHERE PlanningID=@PlanningID AND SeasonYearID = @SeasonYearID
	
	OPEN @CategoriesCursor
	FETCH NEXT FROM @CategoriesCursor INTO @CurrentBrandID, @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @CurrentSubCategoryID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		DELETE FROM @StyleList
		
		IF @CurrentSubCategoryID IS NOT NULL
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.SubCategoryId = @CurrentSubCategoryID AND sh.StyleCategory = @CurrentStyleCategoryID AND sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentStyleCategoryID IS NOT NULL
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.StyleCategory = @CurrentStyleCategoryID AND sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentStyleTypeID IS NOT NULL
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentDivisionID IS NOT NULL
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.DivisionID IN (SELECT CustomID FROM vwx_Division_SEL WHERE BrandID = @CurrentBrandID)
			AND sh.StyleID IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END		
	
		-- Number of Styles
		SELECT @NoOfStyles = COUNT(*) FROM @StyleList
				
		-- Number of Carry Over Styles
		SELECT @NoOfCarryOverStyles = COUNT(sh.StyleID) 
		FROM pStyleHeader sh INNER JOIN @StyleList sl ON sl.StyleID = sh.StyleID
		WHERE sh.IntroSeasonYearID <> @SeasonYearID
		
		-- Number of Over Dev Styles
		SELECT @NoOfOverDevStyles = COUNT(DISTINCT pli.StyleID) 
		FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
		INNER JOIN vwx_Division_SEL d ON sh.DivisionID = d.CustomID
		LEFT JOIN pSourcingCommitmentItem sci 
			ON pli.StyleSeasonYearID = sci.StyleSeasonYearID AND sci.StyleQuoteItemStatusId = 3
		WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID 
			AND (@CurrentSubCategoryID IS NULL OR sh.SubCategoryId = @CurrentSubCategoryID)
			AND (@CurrentStyleCategoryID IS NULL OR sh.StyleCategory = @CurrentStyleCategoryID) 
			AND (@CurrentStyleTypeID IS NULL OR sh.StyleType = @CurrentStyleTypeID)
			AND (@CurrentDivisionID IS NULL OR sh.DivisionID = @CurrentDivisionID)
			AND (@CurrentBrandID IS NULL OR d.BrandID = @CurrentBrandID)
			AND sci.SourcingCommitmentItemID IS NULL

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
		
		-- Ecom Units
		SELECT @EcomUnits = SUM(sci.StyleQuoteItem_EcomUnits) FROM pSourcingCommitmentItem  sci  
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
			
		-- Avg Ecom Price / Unit
		IF @EcomUnits = 0
			SET @AvgEcomPriceUnit = 0
		ELSE
			SELECT @AvgEcomPriceUnit = (SUM(sci.StyleQuoteItem_EcomUnits * sci.StyleQuoteItem_EcomPriceUnit) / @EcomUnits) FROM pSourcingCommitmentItem  sci  
			INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
		
		--Extended WHS and Retail, Ecom	
		SET @ExtendedWholesale = @WHSUnits * @AvgWHSPriceUnit
		SET @ExtendedRetail = @RetailUnits * @AvgRetPriceUnit
		SET @ExtendedEcom = @EcomUnits * @AvgEcomPriceUnit		
		
		-- Extended Cost
		SELECT @ExtendedCost = SUM(sci.StyleQuoteItemCustomField24) FROM pSourcingCommitmentItem  sci 
		INNER JOIN @StyleList sl ON sl.StyleID = sci.StyleID
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID
		
		-- Gross Profit
		SET @GrossProfit = @ExtendedWholesale + @ExtendedRetail + @ExtendedEcom - @ExtendedCost
		
		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit/(@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)
		
		-- Gross Margins
		IF (@AvgWHSPriceUnit = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
		IF (@AvgRetPriceUnit = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit

		-- No Of Colorways
		SELECT @NoOfColorways = COUNT(DISTINCT sc.StyleColorID) 
		FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSourcingCommitmentItem sci ON pli.StyleSeasonYearID = sci.StyleSeasonYearID
		INNER JOIN pSourcingCommitmentBOMDetails scbd ON sci.SourcingCommitmentItemID = scbd.SourcingCommitmentItemID
		INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (scbd.ItemDim1Id, scbd.ItemDim2Id, scbd.ItemDim3Id)
		INNER JOIN @StyleList sl ON pli.StyleID = sl.StyleID
		WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
			AND sci.StyleQuoteItemStatusId = 3 AND scbd.Quantity > 0
			
		-- Planned Budget
		SELECT @PlannedBudget = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
			AND ISNULL(PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentDivisionID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
			AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentSubCategoryID, '00000000-0000-0000-0000-000000000000')
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'

		UPDATE pPlanningBusiness SET 
			PlanningActualCh = CASE PlanningFinancialID 
				WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
				WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
				WHEN '10000000-0000-0000-0000-000000000020' THEN @NoOfOverDevStyles
				WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
				WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
				WHEN '10000000-0000-0000-0000-000000000021' THEN @EcomUnits
				WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
				WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
				WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
				WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
				WHEN '10000000-0000-0000-0000-000000000025' THEN @ExtendedEcom	
				WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
				WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
				WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
				WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcomPriceUnit
				WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
				WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
				WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
				WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
				WHEN '10000000-0000-0000-0000-000000000019' THEN @NoOfColorways	
				WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget
				ELSE PlanningActualCh END
		WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
			AND ISNULL(PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentDivisionID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
			AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentSubCategoryID, '00000000-0000-0000-0000-000000000000')
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000000',
				'10000000-0000-0000-0000-000000000001',
				'10000000-0000-0000-0000-000000000020',
				'10000000-0000-0000-0000-000000000004',
				'10000000-0000-0000-0000-000000000005',
				'10000000-0000-0000-0000-000000000021',
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000025',
				'10000000-0000-0000-0000-000000000006',
				'10000000-0000-0000-0000-000000000007',
				'10000000-0000-0000-0000-000000000008',
				'10000000-0000-0000-0000-000000000023',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000028',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000019',
				'10000000-0000-0000-0000-000000000024')

			
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentBrandID, @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @CurrentSubCategoryID
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08270', GetDate())
GO
