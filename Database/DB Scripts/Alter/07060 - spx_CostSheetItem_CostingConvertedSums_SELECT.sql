IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingConvertedSums_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingConvertedSums_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingConvertedSums_SELECT]
	@StyleCostingScenarioItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleCostingID UNIQUEIDENTIFIER

	DECLARE @ExchangeRateItemID UNIQUEIDENTIFIER
	DECLARE @ExchangeRateID UNIQUEIDENTIFIER
	DECLARE @ConvCurrType NVARCHAR(5)
	DECLARE @ConvCurrRate DECIMAL(18,4)
	DECLARE @BOMConvCurrRate DECIMAL(18,4)
	DECLARE @BOLConvCurrRate DECIMAL(18,4)	
	
	DECLARE @BOMCurr NVARCHAR(5)
	DECLARE @BOMCurrRate DECIMAL(18,4)
	DECLARE @BOLCurr NVARCHAR(5)
	DECLARE @BOLCurrRate DECIMAL(18,4)
	
	DECLARE @MissingBOMRate	INT = 0
	DECLARE @MissingBOLRate	INT = 0
	
	SELECT @ExchangeRateItemID = ExchangeRateItemID, @StyleCostingID = StyleCostingID 
	FROM vwx_StyleCosting_SEL WHERE ScenarioID = @StyleCostingScenarioItemID
	
	SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate
	FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID
	
	SET @BOMConvCurrRate = @ConvCurrRate
	SET @BOLConvCurrRate = @ConvCurrRate
	
	SELECT @BOMCurr = BOMCurrencyType, @BOLCurr = BOLCurrencyType 
	FROM pStyleCosting WHERE StyleCostingID = @StyleCostingID
	
	IF @BOMCurr IS NOT NULL AND @BOMCurr <> ''
		SELECT @BOMCurrRate = Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = @BOMCurr
	IF @BOLCurr IS NOT NULL AND @BOLCurr <> ''
		SELECT @BOLCurrRate = Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = @BOLCurr
		
	IF @BOMCurrRate IS NULL OR (@BOMCurrRate IS NOT NULL AND @ExchangeRateItemID IS NULL)
	BEGIN
		SET @BOMCurrRate = 1
		SET @BOMConvCurrRate = 0
		SET @MissingBOMRate = 1
	END
	IF @BOLCurrRate IS NULL OR (@BOLCurrRate IS NOT NULL AND @ExchangeRateItemID IS NULL)
	BEGIN
		SET @BOLCurrRate = 1
		SET @BOLConvCurrRate = 0
		SET @MissingBOLRate = 1
	END

	IF (@BOMCurr IS NULL AND @ExchangeRateItemID IS NULL) OR (@BOMCurr IS NULL AND @ExchangeRateItemID IS NOT NULL)
	BEGIN
		SET @BOMCurrRate = 1
		SET @BOMConvCurrRate = 1
		SET @MissingBOMRate = 0
	END
	
	IF (@BOLCurr IS NULL AND @ExchangeRateItemID IS NULL) OR (@BOLCurr IS NULL AND @ExchangeRateItemID IS NOT NULL)
	BEGIN
		SET @BOLCurrRate = 1
		SET @BOLConvCurrRate = 1
		SET @MissingBOLRate = 0
	END			
	print @ConvCurrRate

    -- Insert statements for procedure here
	SELECT 'BOMCost' As ColName, ISNULL(SUM(MaterialCost), '0.00') * @BOMConvCurrRate / @BOMCurrRate As ColValue, @MissingBOMRate AS MissingRate FROM pstyleCostingBOM
	WHERE StytleCostingScenarioItemsID=@StyleCostingScenarioItemID
	UNION SELECT 'BOLCost' As ColName, ISNULL(SUM(OperationCost), '0.00') * @BOLConvCurrRate / @BOLCurrRate As ColValue, @MissingBOLRate AS MissingRate FROM pStyleCostingBOL
	WHERE StytleCostingScenarioItemsID=@StyleCostingScenarioItemID
	UNION SELECT 'AdditionalCost' As ColName, ISNULL(SUM(AdditionalItemCost), '0.00') As ColValue, 0 AS MissingRate FROM pstyleCostingAdditionalItems
	WHERE StytleCostingScenarioItemsID=@StyleCostingScenarioItemID
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07060', GetDate())
GO
