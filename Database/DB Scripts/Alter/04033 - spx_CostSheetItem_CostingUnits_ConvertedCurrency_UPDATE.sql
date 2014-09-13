IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingUnits_ConvertedCurrency_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_ConvertedCurrency_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_ConvertedCurrency_UPDATE] 
	@StyleCostingID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @UnconvertedTotal NUMERIC(18,3) -- Unconverted value of Total COST/LDP
	DECLARE @SelectedExchangeRate UNIQUEIDENTIFIER
	DECLARE @SelectedExchangeRateItem UNIQUEIDENTIFIER
	DECLARE @RateBase NUMERIC(18, 3) -- Rate of the base currency
	DECLARE @RateSelected NUMERIC(18, 3) -- Rate of the selected currency
	DECLARE @ConvertedTotal NUMERIC (18,3) -- Converted value
	
	DECLARE @ScenarioCursor CURSOR
	DECLARE @ColumnScenarioID UNIQUEIDENTIFIER
	
	-- Selecting all the scenario items for given costing
	SET @ScenarioCursor = CURSOR SCROLL FOR
	SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems WHERE StyleCostingID = @StyleCostingID
	OPEN @ScenarioCursor
	FETCH NEXT FROM @ScenarioCursor INTO @ColumnScenarioID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @SelectedExchangeRate = NULL
		SET @RateSelected = 1
		SET @RateBase = 1
		-- Selecting the Total Cost/LDP to convert. Also select ID of exchange rate item with selected currency
		SELECT @SelectedExchangeRateItem = StyleCostingCurrency, @UnconvertedTotal = StyleCostingCustomField14
		FROM pStyleCostingScenarioItems WHERE StytleCostingScenarioItemsID = @ColumnScenarioID
		SELECT @SelectedExchangeRate = ExchangeRateID, @RateSelected = Rate
		FROM sExchangeRateItem WHERE ExchangeRateItemID = @SelectedExchangeRateItem
		-- Selecting the rate of base currency
		SELECT @RateBase = Rate FROM sExchangeRateItem
		WHERE ExchangeRateID = @SelectedExchangeRate AND BaseCurrency = 1
		-- Calculating the converted value
		SET @ConvertedTotal = (@UnconvertedTotal * @RateSelected)/@RateBase
		
		UPDATE pStyleCostingScenarioItems SET StyleCostingConvertedCurr = @ConvertedTotal
		WHERE StytleCostingScenarioItemsID = @ColumnScenarioID
		
		FETCH NEXT FROM @ScenarioCursor INTO @ColumnScenarioID
	END
	
	CLOSE @ScenarioCursor
	DEALLOCATE @ScenarioCursor
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04033', GetDate())
GO 