IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_ScenarioHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_ScenarioHeader_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_ScenarioHeader_SELECT]
	@StyleCostingID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT StytleCostingScenarioItemsID, StyleCostingName, StyleCostingScenarioNo, pStyleCostingScenarioItems.ExchangeRateItemID, sExchangeRateItem.CurrencyType, 0 AS SystemCost
    FROM pStyleCostingScenarioItems
		LEFT JOIN sExchangeRateItem ON pStyleCostingScenarioItems.ExchangeRateItemID = sExchangeRateItem.ExchangeRateItemID
    WHERE StyleCostingID = @StyleCostingID
    UNION SELECT StyleCostingScenarioItemsId, StyleCostingName, StyleCostingScenarioNo, pStyleCosting.ExchangeRateItemID, sExchangeRateItem.CurrencyType, 1 AS SystemCost
    FROM pStyleCosting
		LEFT JOIN sExchangeRateItem ON pStyleCosting.ExchangeRateItemID = sExchangeRateItem.ExchangeRateItemID
    WHERE StyleCostingID = @StyleCostingID
    ORDER BY SystemCost DESC, StyleCostingScenarioNo
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07058', GetDate())
GO
