IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_DIPLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_DIPLogic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_DIPLogic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleList AS TABLE(StyleID UNIQUEIDENTIFIER)
	
	/**
	* Declaring column variables
	*/
	
	DECLARE @NoOfStyles DECIMAL(18,5)
	DECLARE @NoOfColorways DECIMAL(18,5)
	DECLARE @NoOfCarryOverStyles DECIMAL(18,5)
	DECLARE @NoOfOverDevStyles DECIMAL(18,5)
	DECLARE @WHSUnits DECIMAL(18, 5)
	DECLARE @TotalUnits DECIMAL(18, 5)
	DECLARE @RetailUnits DECIMAL(18, 5)
	DECLARE @EcomUnits DECIMAL(18, 5)
	DECLARE @AvgCostUnit DECIMAL(18, 5)
	DECLARE @AvgWHSPriceUnit DECIMAL(18, 5)
	DECLARE @AvgRetPriceUnit DECIMAL(18, 5)
	DECLARE @AvgEcmPriceUnit DECIMAL(18, 5)
	DECLARE @ExtendedWholesale DECIMAL(18, 5)
	DECLARE @ExtendedRetail DECIMAL(18, 5)
	DECLARE @ExtendedEcom DECIMAL(18, 5)
	DECLARE @ExtendedCost DECIMAL(18, 5)
	DECLARE @GrossMarginWHS DECIMAL(18, 5)
	DECLARE @GrossMarginRet DECIMAL(18, 5)
	DECLARE @GrossMarginEcm DECIMAL(18, 5)
	DECLARE @GrossMargin DECIMAL(18, 5)
	DECLARE @GrossProfit DECIMAL(18, 5)
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
		BEGIN -- Selecting styles for current Brand/Division/Style Type/Style Category/Sub Category
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.SubCategoryId = @CurrentSubCategoryID AND sh.StyleCategory = @CurrentStyleCategoryID AND sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID			
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentStyleCategoryID IS NOT NULL
		BEGIN -- Selecting styles for current Brand/Division/Style Type/Style Category
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.StyleCategory = @CurrentStyleCategoryID AND sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID			
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentStyleTypeID IS NOT NULL -- Selecting styles for current Brand/Division/Style Type
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentDivisionID IS NOT NULL
		BEGIN
			INSERT INTO @StyleList(StyleID) -- Selecting styles for current Brand/Division
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE
		BEGIN
			INSERT INTO @StyleList(StyleID) -- Selecting styles for current Brand
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh 
			INNER JOIN pPlanningItem ppi ON ppi.StyleID = sh.StyleID AND ppi.PlanningID = @PlanningID
			INNER JOIN pStyleSeasonYear ssy ON ppi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
			WHERE sh.DivisionID IN (SELECT CustomID FROM vwx_Division_SEL WHERE BrandID = @CurrentBrandID)
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		
		SELECT @NoOfStyles = COUNT(sl.StyleID) -- Sum of all active styles in Line Planning
		FROM @StyleList sl
		INNER JOIN pPlanningItem pli ON sl.StyleID = pli.StyleID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
			AND pli.PlanningItemDrop = 'No'
			
		SELECT @NoOfOverDevStyles = COUNT(sl.StyleID) -- Sum of all dropped styles in Line Planning
		FROM @StyleList sl
		INNER JOIN pPlanningItem pli ON sl.StyleID = pli.StyleID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
			AND pli.PlanningItemDrop = 'Yes'
		
		SELECT @NoOfCarryOverStyles = COUNT(sh.StyleID) FROM pStyleHeader sh INNER JOIN @StyleList sl ON sl.StyleID = sh.StyleID -- Sum of all Carry Over styles in Line Folder
										WHERE sh.IntroSeasonYearID <> @SeasonYearID
		SELECT @WHSUnits = SUM(StyleCostingCustomField6) FROM pStyleCostingHeader sch -- Sum of Wholesale Units in Style Costing Headers for given Season Year
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		SELECT @RetailUnits = SUM(StyleCostingCustomField7) FROM pStyleCostingHeader sch  -- Sum of Retail Units in Style Costing Headers for given Season Year
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		SELECT @EcomUnits = SUM(StyleCostingCustomField5) FROM pStyleCostingHeader sch  -- Sum of Ecom Units in Style Costing Headers for given Season Year
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		
		-- Avg. Cost / Unit
		SELECT @TotalUnits = SUM(StyleCostingCustomField8) FROM pStyleCostingHeader sch  -- Sum of Total Units in Style Costing Headers for given Season Year
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		IF @TotalUnits = 0
			SET @AvgCostUnit = 0
		ELSE
			SELECT @AvgCostUnit = SUM(StyleCostingCustomField8 * StyleCostingCustomField10)/@TotalUnits FROM pStyleCostingHeader sch  -- Sum of (Total Cost * Projected Units) div by sum of Projected Units
					INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
					INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		-- Avg. Wholesale Price / Unit
		IF @WHSUnits = 0
			SET @AvgWHSPriceUnit = 0
		ELSE
			SELECT @AvgWHSPriceUnit = SUM(StyleCostingCustomField1 * StyleCostingCustomField6)/@WHSUnits FROM pStyleCostingHeader sch  -- Sum of (WHS Price * WHS Units) div by sum of WHS Units
					INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
					INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		-- Avg. Retail Price / Unit			
		IF @RetailUnits = 0
			SET @AvgRetPriceUnit = 0
		ELSE
			SELECT @AvgRetPriceUnit = SUM(StyleCostingCustomField2 * StyleCostingCustomField7)/@RetailUnits FROM pStyleCostingHeader sch  -- Sum of (Retail Cost * Retail Units) div by sum of Retail Units
					INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
					INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		-- Avg. Ecom Price / Unit			
		IF @EcomUnits = 0
			SET @AvgEcmPriceUnit = 0
		ELSE
			SELECT @AvgEcmPriceUnit = SUM(StyleCostingCustomField3 * StyleCostingCustomField5)/@EcomUnits FROM pStyleCostingHeader sch  -- Sum of (Ecom Cost * Ecom Units) div by sum of Ecom Units
					INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
					INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
					
		SELECT @ExtendedWholesale = SUM(StyleCostingCustomField1 * StyleCostingCustomField6) FROM pStyleCostingHeader sch  -- Sum of (WHS Price * WHS Units)
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 
		SELECT @ExtendedRetail = SUM(StyleCostingCustomField2 * StyleCostingCustomField7) FROM pStyleCostingHeader sch  -- Sum of (Retail Price * Retail Units
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 
		SELECT @ExtendedEcom = SUM(StyleCostingCustomField3 * StyleCostingCustomField5) FROM pStyleCostingHeader sch  -- Sum of (Ecom Price * Ecom Units
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 
		SELECT @ExtendedCost = SUM(StyleCostingCustomField8 * StyleCostingCustomField10) FROM pStyleCostingHeader sch -- Sum of (Total Cost * Total Units)
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		
		-- Gross Profit
		SET @GrossProfit = (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) - @ExtendedCost
		
		-- Gross Margins
		IF (@AvgWHSPriceUnit = 0)
			SET @GrossMarginWHS = 0
		ELSE
			SET @GrossMarginWHS = (@AvgWHSPriceUnit - @AvgCostUnit)/@AvgWHSPriceUnit
		IF (@AvgRetPriceUnit = 0)
			SET @GrossMarginRet = 0
		ELSE
			SET @GrossMarginRet = (@AvgRetPriceUnit - @AvgCostUnit)/@AvgRetPriceUnit
		IF (@AvgEcmPriceUnit = 0)
			SET @GrossMarginEcm = 0
		ELSE
			SET @GrossMarginEcm = (@AvgEcmPriceUnit - @AvgCostUnit)/@AvgEcmPriceUnit

		IF (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom) = 0
			SET @GrossMargin = 0
		ELSE
			SET @GrossMargin = @GrossProfit / (@ExtendedWholesale + @ExtendedRetail + @ExtendedEcom)
			
		-- Planned Budget
		SELECT @PlannedBudget = PlanningPlanningCh FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
			AND PlanningBrandID = @CurrentBrandID
			AND ISNULL(PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentDivisionID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
			AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentSubCategoryID, '00000000-0000-0000-0000-000000000000')
			AND PlanningFinancialID = '10000000-0000-0000-0000-000000000024'			
			
		UPDATE pPlanningBusiness SET 
			PlanningDIPCh = CASE PlanningFinancialID 
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
				WHEN '10000000-0000-0000-0000-000000000023' THEN @AvgEcmPriceUnit
				WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
				WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet
				WHEN '10000000-0000-0000-0000-000000000027' THEN @GrossMarginEcm
				WHEN '10000000-0000-0000-0000-000000000026' THEN @GrossProfit
				WHEN '10000000-0000-0000-0000-000000000028' THEN @GrossMargin
				WHEN '10000000-0000-0000-0000-000000000024' THEN @PlannedBudget					
				ELSE PlanningDIPCh END
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
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013',
				'10000000-0000-0000-0000-000000000027',
				'10000000-0000-0000-0000-000000000026',
				'10000000-0000-0000-0000-000000000028',
				'10000000-0000-0000-0000-000000000024')			

		-- Select number of active colorways for active styles in planning
		;WITH BOMColorways AS (
			SELECT sbdi.StyleBOMDimensionID, COUNT(V.DimItemID) AS ColorwayCount FROM pStyleBOMDimensionItem sbdi
			CROSS APPLY (VALUES (sbdi.ItemDim1TypeId, sbdi.ItemDim1Id, sbdi.ItemDim1Active),
								(sbdi.ItemDim2TypeId, sbdi.ItemDim2Id, sbdi.ItemDim2Active),
								(sbdi.ItemDim3TypeId, sbdi.ItemDim3Id, sbdi.ItemDim3Active))
							  V (DimTypeID, DimItemID, DimActive)
			INNER JOIN pStyleBOMDimType sbdt ON V.DimTypeID = sbdt.DimTypeID
			WHERE UPPER(LTRIM(RTRIM(sbdt.DimTypeName))) = 'COLOR'
				AND V.DimItemID IS NOT NULL
				AND V.DimActive = 1
			GROUP BY sbdi.StyleBOMDimensionID
		)
		SELECT @NoOfColorways = ISNULL(SUM(BOMColorways.ColorwayCount), 0) FROM pPlanningItem pli
		INNER JOIN BOMColorways ON pli.StyleBOMDimensionID = BOMColorways.StyleBOMDimensionID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		LEFT JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
		LEFT JOIN vwx_Division_SEL d ON sh.DivisionID = d.CustomID
		WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID AND pli.PlanningItemDrop = 'No'
			AND (@CurrentSubCategoryID IS NULL OR sh.SubCategoryId = @CurrentSubCategoryID)
			AND (@CurrentStyleCategoryID IS NULL OR sh.StyleCategory = @CurrentStyleCategoryID) 
			AND (@CurrentStyleTypeID IS NULL OR sh.StyleType = @CurrentStyleTypeID)
			AND (@CurrentDivisionID IS NULL OR sh.DivisionID = @CurrentDivisionID)
		
		-- Update # of Colorways
		UPDATE pPlanningBusiness SET PlanningDIPCh = @NoOfColorways
		WHERE PlanningID = @PlanningID 
		AND SeasonYearID = @SeasonYearID
		AND ISNULL(PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentDivisionID, '00000000-0000-0000-0000-000000000000')
		AND ISNULL(PlanningStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND ISNULL(PlanningSubCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentSubCategoryID, '00000000-0000-0000-0000-000000000000')
		AND PlanningFinancialID = '10000000-0000-0000-0000-000000000019'
		
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentBrandID, @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @CurrentSubCategoryID
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09028', GetDate())
GO
