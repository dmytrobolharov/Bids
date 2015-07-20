IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]
	@StyleCostingScenarioItem UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS (SELECT * FROM pStyleCostingScenarioItems WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItem)
	BEGIN -- @StyleCostingScenarioItem is one of scenario items that was choosen on costing page as system scenario
		SELECT scenario.StyleCostingCustomField19 AS txtStyleQuoteItemCustomField16, -- Proposed Units
			costing.StyleBOMDimensionID AS drlStyleColorID
		FROM pStyleCostingScenarioItems scenario
		INNER JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
		LEFT JOIN pStyleCostingDuty duty ON duty.CustomID = scenario.StyleCostingHTS
		WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItem
    END
    ELSE
    BEGIN -- @StyleCostingScenarioItem is StyleCostingID of table pStyleCosting (system cosheet) because any of scenarios wasn't choosen on costing page
		SELECT costing.StyleCostingCustomField19 AS txtStyleQuoteItemCustomField16, -- Proposed Units
			costing.StyleBOMDimensionID AS drlStyleColorID
		FROM pStyleCosting costing
		LEFT JOIN pStyleCostingDuty duty ON duty.CustomID = costing.StyleCostingHTS
		WHERE costing.StyleCostingID = @StyleCostingScenarioItem
    END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06515', GetDate())
GO
