/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE]    Script Date: 05/23/2013 18:14:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE]    Script Date: 05/23/2013 18:14:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER,
	@RangePlan INT = 0
AS
BEGIN

	DECLARE @StyleList AS TABLE(
								StyleID UNIQUEIDENTIFIER
								)
								
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
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
	
	/*
	* Declaring cursor
	*/
	DECLARE @CategoriesCursor CURSOR
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER
	
	SET @CategoriesCursor = CURSOR SCROLL
	FOR 	
	SELECT DISTINCT LineFolderDivisionID, LineFolderStyleTypeID, LineFolderStyleCategoryID
	FROM pLineFolderBusiness WHERE LineFolderID=@LineFolderID
	
	OPEN @CategoriesCursor
	FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		DELETE FROM @StyleList
		
		IF @CurrentStyleCategoryID IS NOT NULL
		BEGIN -- Selecting styles for current Division/Style Type/Style Category
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID AND lfi.LineFolderID = @LineFolderID
			WHERE sh.StyleCategory = @CurrentStyleCategoryID AND sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE IF @CurrentStyleTypeID IS NOT NULL -- Selecting styles for current Division/Style Type
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID AND lfi.LineFolderID = @LineFolderID
			WHERE sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE
		BEGIN
			INSERT INTO @StyleList(StyleID) -- Selecting styles for current Division
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID AND lfi.LineFolderID = @LineFolderID
			WHERE sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID NOT IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci 
									INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
									WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		
		SELECT @NoOfStyles = COUNT(StyleID) FROM @StyleList -- Sum of all styles in Line Folder
		SELECT @NoOfCarryOverStyles = COUNT(sh.StyleID) FROM pStyleHeader sh INNER JOIN @StyleList sl ON sl.StyleID = sh.StyleID -- Sum of all Carry Over styles in Line Folder
										WHERE sh.IntroSeasonYearID <> @SeasonYearID
		SELECT @WHSUnits = SUM(StyleCostingCustomField6) FROM pStyleCostingHeader sch -- Sum of Wholesale Units in Style Costing Headers for given Season Year
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		SELECT @RetailUnits = SUM(StyleCostingCustomField7) FROM pStyleCostingHeader sch  -- Sum of Retail Units in Style Costing Headers for given Season Year
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
			SELECT @AvgRetPriceUnit = SUM(StyleCostingCustomField7 * StyleCostingCustomField2)/@RetailUnits FROM pStyleCostingHeader sch  -- Sum of (Retail Cost * Retail Units) div by sum of Retail Units
					INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
					INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
					
		SELECT @ExtendedWholesale = SUM(StyleCostingCustomField1 * StyleCostingCustomField6) FROM pStyleCostingHeader sch  -- Sum of (WHS Price * WHS Units)
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 
		SELECT @ExtendedRetail = SUM(StyleCostingCustomField7 * StyleCostingCustomField2) FROM pStyleCostingHeader sch  -- Sum of (Retail Price * Retail Units
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID 
		SELECT @ExtendedCost = SUM(StyleCostingCustomField8 * StyleCostingCustomField10) FROM pStyleCostingHeader sch -- Sum of (Total Cost * Total Units)
				INNER JOIN pStyleSeasonYear ssy ON sch.StyleSeasonYearID = ssy.StyleSeasonYearID  AND ssy.SeasonYearID = @SeasonYearID
				INNER JOIN @StyleList sl ON sl.StyleID = sch.StyleID
		
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
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @NoOfStyles
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		AND RangePlan = @RangePlan
		-- Update Number of Carry Over Styles
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @NoOfCarryOverStyles
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000') 
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		AND RangePlan = @RangePlan
		-- Update Wholesale Units
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @WHSUnits
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		AND RangePlan = @RangePlan
		-- Update Retail Units
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @RetailUnits
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'	
		AND RangePlan = @RangePlan	
		-- Update Average Cost/Unit
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @AvgCostUnit
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000006'
		AND RangePlan = @RangePlan
		-- Update Average Wholesale Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @AvgWHSPriceUnit
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000') 
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000007'
		AND RangePlan = @RangePlan
		-- Update Average Retail Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @AvgRetPriceUnit
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000008'
		AND RangePlan = @RangePlan
		-- Update extended wholesale
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @ExtendedWholesale
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		AND RangePlan = @RangePlan
		-- Update extended retail
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @ExtendedRetail
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		AND RangePlan = @RangePlan
		-- Update extended cost
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @ExtendedCost
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
		AND RangePlan = @RangePlan
		-- Update gross margin WHS
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @GrossMarginWHS
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000012'
		AND RangePlan = @RangePlan
		-- Update gross margin retail
		UPDATE pLineFolderBusiness SET LineFolderDIPCh = @GrossMarginRet
		WHERE LineFolderID = @LineFolderID 
		AND LineFolderDivisionID = @CurrentDivisionID 
		AND ISNULL(LineFolderStyleTypeID, '0') = ISNULL(@CurrentStyleTypeID, '0')
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000013'
		AND RangePlan = @RangePlan
		
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05754', GetDate())
GO
