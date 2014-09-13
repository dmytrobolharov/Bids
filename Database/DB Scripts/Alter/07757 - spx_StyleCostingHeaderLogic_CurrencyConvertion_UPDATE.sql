IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeaderLogic_CurrencyConvertion_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_CurrencyConvertion_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_CurrencyConvertion_UPDATE]
	@StyleID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

DECLARE @StyleCostingHeaderId UNIQUEIDENTIFIER
SELECT @StyleCostingHeaderId = StyleCostingHeaderId FROM pStyleCostingHeader WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID

CREATE TABLE #tmpCostingScenarioItem
(
	Row_ID INT IDENTITY (1,1)
	, ScenarioID UNIQUEIDENTIFIER
	, StyleCostingCustomField15 DECIMAL (18,5)
	, StyleCostingCustomField16 DECIMAL (18,5)
	, StyleCosting_EcomPriceUnit DECIMAL (18,5)
	, StyleCostingCustomField15_Conv DECIMAL (18,5)
	, StyleCostingCustomField16_Conv DECIMAL (18,5)
	, StyleCosting_EcomPriceUnit_Conv DECIMAL (18,5)
	, ExchangeRateItemID UNIQUEIDENTIFIER
)	

INSERT INTO #tmpCostingScenarioItem (ScenarioID, StyleCostingCustomField15, StyleCostingCustomField16, StyleCosting_EcomPriceUnit, ExchangeRateItemID)
SELECT ScenarioID, pStyleCostingHeader.StyleCostingCustomField1, pStyleCostingHeader.StyleCostingCustomField2, pStyleCostingHeader.StyleCostingCustomField3, ExchangeRateItemID
FROM vwx_StyleCosting_SEL
	INNER JOIN pStyleCostingHeader ON vwx_StyleCosting_SEL.StyleCostingHeaderId = pStyleCostingHeader.StyleCostingHeaderID
WHERE pStyleCostingHeader.StyleCostingHeaderId = @StyleCostingHeaderId
AND ExchangeRateItemID IS NOT NULL


DECLARE @ExchangeRateItemID UNIQUEIDENTIFIER
DECLARE @ExchangeRateID UNIQUEIDENTIFIER
DECLARE @ConvCurrType NVARCHAR(5)
DECLARE @ConvCurrRate DECIMAL(18,4)
DECLARE @HeaderCurrType NVARCHAR(5)
DECLARE @HeaderCurrRate DECIMAL(18,4)

SELECT @HeaderCurrType = CurrencyType FROM pStyleCostingHeader WHERE StyleCostingHeaderID = @StyleCostingHeaderId	

DECLARE @iROW INT = 0
DECLARE @iCount INT = (SELECT COUNT(*) FROM #tmpCostingScenarioItem)
WHILE @iROW <= @iCount
BEGIN
	SELECT @ExchangeRateItemID = ExchangeRateItemID FROM #tmpCostingScenarioItem WHERE Row_ID = @iROW

	SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate
	FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID
	
	SELECT @HeaderCurrRate = Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = @HeaderCurrType
	
	UPDATE #tmpCostingScenarioItem
	SET StyleCostingCustomField15_Conv = StyleCostingCustomField15 * @ConvCurrRate / @HeaderCurrRate,
		StyleCostingCustomField16_Conv = StyleCostingCustomField16 * @ConvCurrRate / @HeaderCurrRate,
		StyleCosting_EcomPriceUnit_Conv = StyleCosting_EcomPriceUnit * @ConvCurrRate / @HeaderCurrRate
	WHERE Row_ID = @iROW
	
	SET @iROW = @iROW + 1
END

UPDATE pStyleCosting 
SET 
	StyleCostingCustomField15 = ISNULL(#tmpCostingScenarioItem.StyleCostingCustomField15_Conv, #tmpCostingScenarioItem.StyleCostingCustomField15),
	StyleCostingCustomField16 = ISNULL(#tmpCostingScenarioItem.StyleCostingCustomField16_Conv, #tmpCostingScenarioItem.StyleCostingCustomField16),
	StyleCosting_EcomPriceUnit = ISNULL(#tmpCostingScenarioItem.StyleCosting_EcomPriceUnit_Conv, #tmpCostingScenarioItem.StyleCosting_EcomPriceUnit)
FROM #tmpCostingScenarioItem
WHERE pStyleCosting.StyleCostingID = #tmpCostingScenarioItem.ScenarioID

UPDATE pStyleCostingScenarioItems 
SET 
	StyleCostingCustomField15 = ISNULL(#tmpCostingScenarioItem.StyleCostingCustomField15_Conv, #tmpCostingScenarioItem.StyleCostingCustomField15),
	StyleCostingCustomField16 = ISNULL(#tmpCostingScenarioItem.StyleCostingCustomField16_Conv, #tmpCostingScenarioItem.StyleCostingCustomField16),
	StyleCosting_EcomPriceUnit = ISNULL(#tmpCostingScenarioItem.StyleCosting_EcomPriceUnit_Conv, #tmpCostingScenarioItem.StyleCosting_EcomPriceUnit)
FROM #tmpCostingScenarioItem
WHERE pStyleCostingScenarioItems.StytleCostingScenarioItemsID = #tmpCostingScenarioItem.ScenarioID

DROP TABLE #tmpCostingScenarioItem

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07757', GetDate())
GO
