/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE]    Script Date: 03/22/2013 12:10:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE]    Script Date: 03/22/2013 12:10:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
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
	DECLARE @CurrentDivisionID UNIQUEIDENTIFIER
	DECLARE @CurrentStyleTypeID INT
	DECLARE @CurrentStyleCategoryID UNIQUEIDENTIFIER
	
	--get season of current Line List
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID=@LineFolderID
	
	DECLARE @StyleList AS TABLE(
		StyleID UNIQUEIDENTIFIER
	)

	
	
	-- Updating calculated values for all style categories (lowest level in hierarchy)
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
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID AND lfi.LineFolderID = @LineFolderID
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
			FROM pStyleHeader sh INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID AND lfi.LineFolderID = @LineFolderID
			WHERE sh.StyleType = @CurrentStyleTypeID
			AND sh.DivisionID = @CurrentDivisionID
			AND sh.StyleID IN(SELECT sci.StyleID FROM pSourcingCommitmentItem sci
			INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE sci.StyleQuoteItemStatusId = 3 AND ssy.SeasonYearID = @SeasonYearID)
		END
		ELSE
		BEGIN
			INSERT INTO @StyleList(StyleID)
			SELECT DISTINCT sh.StyleID
			FROM pStyleHeader sh INNER JOIN pLineFolderItem lfi ON lfi.StyleID = sh.StyleID AND lfi.LineFolderID = @LineFolderID
			WHERE sh.DivisionID = @CurrentDivisionID
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
		
		-- Update Number of Styles
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @NoOfStyles
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID, 0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
		-- Update Number of Carry Over Styles
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @NoOfCarryOverStyles
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID, 0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
		-- Update Wholesale Units
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @WHSUnits
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000004'
		-- Update Retail Units
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @RetailUnits
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000005'
		-- Update Average Cost/Unit
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @AvgCostUnit
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000006'
		-- Update Average Wholesale Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @AvgWHSPriceUnit
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000007'
		-- Update Average Retail Price/Unit
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @AvgRetPriceUnit
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000008'
		-- Update extended wholesale
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @ExtendedWholesale
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000009'
		-- Update extended retail
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @ExtendedRetail
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000010'
		-- Update extended cost
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @ExtendedCost
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000011'
		-- Update gross margin WHS
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @GrossMarginWHS
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000012'
		-- Update gross margin retail
		UPDATE pLineFolderBusiness SET LineFolderActualCh = @GrossMarginRet
		WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @CurrentDivisionID
		AND ISNULL(LineFolderStyleTypeID,0) = ISNULL(@CurrentStyleTypeID, 0)
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@CurrentStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000013'
	
		FETCH NEXT FROM @CategoriesCursor INTO @CurrentDivisionID, @CurrentStyleTypeID, @CurrentStyleCategoryID
	END
	
	CLOSE @CategoriesCursor
	DEALLOCATE @CategoriesCursor
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05387', GetDate())
GO
