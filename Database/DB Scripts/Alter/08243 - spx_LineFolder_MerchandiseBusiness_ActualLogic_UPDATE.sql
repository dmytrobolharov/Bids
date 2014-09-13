/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseBusiness_ActualLogic_UPDATE]    Script Date: 07/07/2014 17:56:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_MerchandiseBusiness_ActualLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_MerchandiseBusiness_ActualLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseBusiness_ActualLogic_UPDATE]    Script Date: 07/07/2014 17:56:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_LineFolder_MerchandiseBusiness_ActualLogic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @PlanningID UNIQUEIDENTIFIER
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @PlanningID = PlanningID, @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	/**
	* Declaring column variables
	*/
	
	DECLARE @NoOfStyles DECIMAL(18,5)
	DECLARE @NoOfCarryOverStyles DECIMAL(18,5)
	DECLARE @TotalUnits DECIMAL(18, 5)
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
	DECLARE @CurrentSubCategoryID NVARCHAR(50)
	
	DECLARE @StyleList AS TABLE(StyleID UNIQUEIDENTIFIER)	
	
	-- Updating calculated values for all style categories (lowest level in hierarchy)
	SET @CategoriesCursor = CURSOR SCROLL
	FOR
	SELECT DISTINCT PlanningBrandID, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningSubCategoryID
	FROM pLineFolderMerchandiseBusiness WHERE PlanningID=@PlanningID AND SeasonYearID = @SeasonYearID AND LineFolderID = @LineFolderID
	
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
		SELECT @NoOfCarryOverStyles = COUNT(sh.StyleID) FROM pStyleHeader sh INNER JOIN @StyleList sl ON sl.StyleID = sh.StyleID
		WHERE sh.IntroSeasonYearID <> @SeasonYearID

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


		UPDATE pLineFolderMerchandiseBusiness SET 
			PlanningActualCh = CASE PlanningFinancialID 
				WHEN '10000000-0000-0000-0000-000000000000' THEN @NoOfStyles
				WHEN '10000000-0000-0000-0000-000000000001' THEN @NoOfCarryOverStyles
				WHEN '10000000-0000-0000-0000-000000000004' THEN @WHSUnits
				WHEN '10000000-0000-0000-0000-000000000005' THEN @RetailUnits
				WHEN '10000000-0000-0000-0000-000000000022' THEN @TotalUnits
				WHEN '10000000-0000-0000-0000-000000000011' THEN @ExtendedCost					
				WHEN '10000000-0000-0000-0000-000000000009' THEN @ExtendedWholesale					
				WHEN '10000000-0000-0000-0000-000000000010' THEN @ExtendedRetail					
				WHEN '10000000-0000-0000-0000-000000000006' THEN @AvgCostUnit
				WHEN '10000000-0000-0000-0000-000000000007' THEN @AvgWHSPriceUnit
				WHEN '10000000-0000-0000-0000-000000000008' THEN @AvgRetPriceUnit
				WHEN '10000000-0000-0000-0000-000000000012' THEN @GrossMarginWHS					
				WHEN '10000000-0000-0000-0000-000000000013' THEN @GrossMarginRet					
				ELSE PlanningActualCh END
		WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID AND LineFolderID = @LineFolderID 
			AND ISNULL(PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentDivisionID, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(PlanningStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
			AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND PlanningSubCategoryID IS NULL	
			AND PlanningFinancialID IN (
				'10000000-0000-0000-0000-000000000000',
				'10000000-0000-0000-0000-000000000001',
				'10000000-0000-0000-0000-000000000004',
				'10000000-0000-0000-0000-000000000005',
				'10000000-0000-0000-0000-000000000022',
				'10000000-0000-0000-0000-000000000011',
				'10000000-0000-0000-0000-000000000009',
				'10000000-0000-0000-0000-000000000010',
				'10000000-0000-0000-0000-000000000006',
				'10000000-0000-0000-0000-000000000007',
				'10000000-0000-0000-0000-000000000008',
				'10000000-0000-0000-0000-000000000012',
				'10000000-0000-0000-0000-000000000013')

			
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentBrandID, @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID, @CurrentSubCategoryID
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08243', GetDate())
GO
