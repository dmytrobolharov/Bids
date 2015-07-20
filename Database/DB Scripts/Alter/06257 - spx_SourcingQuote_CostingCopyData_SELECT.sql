IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_CostingCopyData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_CostingCopyData_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SourcingQuote_CostingCopyData_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@StyleCostingScenarioItem UNIQUEIDENTIFIER,
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SourcingStyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DELETE FROM pSourcingAdditionalCost WHERE QuoteItemID = @StyleQuoteItemID
	
	
	IF EXISTS (SELECT * FROM pStyleCostingScenarioItems WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItem)
	BEGIN -- @StyleCostingScenarioItem is one of scenario items that was choosen on costing page as system scenario

		IF EXISTS(SELECT * FROM pstyleCostingAdditionalItems WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItem)
		BEGIN
			INSERT INTO pSourcingAdditionalCost (SourcingAdditionalCostID, QuoteItemID, SourcingHeaderID, SourcingStyleID, Description, Amount, CUser, CDate, MUser, MDate, TeamID)
			SELECT NEWID(), @StyleQuoteItemID, @SourcingHeaderID, @SourcingStyleID, AdditionalItemName, AdditionalItemCost, ISNULL(FirstName + ' ', '') + ISNULL(LastName, '') , 
			@CDate, ISNULL(FirstName + ' ', '') + ISNULL(LastName, ''), @CDate, @TeamID
			FROM pStyleCostingScenarioItems scenario LEFT JOIN pstyleCostingAdditionalItems adds ON adds.StytleCostingScenarioItemsID = scenario.StytleCostingScenarioItemsID,
			Users
			WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItem
			AND Users.TeamID = @TeamID
		END
		SELECT scenario.StyleCostingCustomField7 AS txtStyleQuoteItemCustomField7, -- Duty %
			scenario.StyleCostingCustomField9 AS txtStyleQuoteItemCustomField9, -- Commissions %
			scenario.StyleCostingCustomField11 AS txtStyleQuoteItemCustomField11, -- Agent %
			scenario.StyleCostingCustomField13 AS txtStyleQuoteItemCustomField13, -- Freight
			scenario.StyleCostingCustomField19 AS txtStyleQuoteItemCustomField16, -- Proposed Units
			scenario.StyleCostingCustomField3 AS txtStyleQuoteItemCustomField2, -- Wholesale Units
			scenario.StyleCostingCustomField4 AS txtStyleQuoteItemCustomField6, -- Retail Units
			scenario.StyleCostingCustomField15 AS txtStyleCostingCustomField15, -- Wholesale Price/Unit
			scenario.StyleCostingCustomField16 AS txtStyleCostingCustomField16, -- Retail Price/Unit
			costing.StyleBOMDimensionID AS drlStyleColorID,
			duty.CustomID AS widStyleQuotaDutyID,
			duty.Custom AS txtStyleQuotaDutyID
		FROM pStyleCostingScenarioItems scenario
		INNER JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
		LEFT JOIN pStyleCostingDuty duty ON duty.CustomID = scenario.StyleCostingHTS
		WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItem
	
	END
	ELSE
	BEGIN -- @StyleCostingScenarioItem is StyleCostingID of table pStyleCosting (system cosheet) because any of scenarios wasn't choosen on costing page
	
		IF EXISTS(SELECT * FROM pstyleCostingAdditionalItems WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItem)
		BEGIN
			INSERT INTO pSourcingAdditionalCost (SourcingAdditionalCostID, QuoteItemID, SourcingHeaderID, SourcingStyleID, Description, Amount, CUser, CDate, MUser, MDate, TeamID)
			SELECT NEWID(), @StyleQuoteItemID, @SourcingHeaderID, @SourcingStyleID, AdditionalItemName, AdditionalItemCost, ISNULL(FirstName + ' ', '') + ISNULL(LastName, '') , 
			@CDate, ISNULL(FirstName + ' ', '') + ISNULL(LastName, ''), @CDate, @TeamID
			FROM pStyleCosting costing LEFT JOIN pstyleCostingAdditionalItems adds ON adds.StytleCostingScenarioItemsID = costing.StyleCostingID,
			Users
			WHERE costing.StyleCostingID = @StyleCostingScenarioItem
			AND Users.TeamID = @TeamID
		END
		SELECT costing.StyleCostingCustomField7 AS txtStyleQuoteItemCustomField7, -- Duty %
			costing.StyleCostingCustomField9 AS txtStyleQuoteItemCustomField9, -- Commissions %
			costing.StyleCostingCustomField11 AS txtStyleQuoteItemCustomField11, -- Agent %
			costing.StyleCostingCustomField13 AS txtStyleQuoteItemCustomField13, -- Freight
			costing.StyleCostingCustomField19 AS txtStyleQuoteItemCustomField16, -- Proposed Units
			costing.StyleCostingCustomField3 AS txtStyleQuoteItemCustomField2, -- Wholesale Units
			costing.StyleCostingCustomField4 AS txtStyleQuoteItemCustomField6, -- Retail Units
			costing.StyleCostingCustomField15 AS txtStyleCostingCustomField15, -- Wholesale Price/Unit
			costing.StyleCostingCustomField16 AS txtStyleCostingCustomField16, -- Retail Price/Unit
			costing.StyleBOMDimensionID AS drlStyleColorID,
			duty.CustomID AS widStyleQuotaDutyID,
			duty.Custom AS txtStyleQuotaDutyID
		FROM pStyleCosting costing
		LEFT JOIN pStyleCostingDuty duty ON duty.CustomID = costing.StyleCostingHTS
		WHERE costing.StyleCostingID = @StyleCostingScenarioItem
	
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '06257', GetDate())
GO
