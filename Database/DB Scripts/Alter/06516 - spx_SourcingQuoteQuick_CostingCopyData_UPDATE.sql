IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SourcingStyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleCostingScenarioItemId UNIQUEIDENTIFIER
	SELECT @StyleCostingScenarioItemId = StyleCostingScenarioItemID FROM pStyleQuoteItem
	WHERE StyleQuoteItemID = @StyleQuoteItemID

	DELETE FROM pSourcingAdditionalCost WHERE QuoteItemID = @StyleQuoteItemID
	IF EXISTS(SELECT * FROM pstyleCostingAdditionalItems WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItemId)
	BEGIN
		INSERT INTO pSourcingAdditionalCost (SourcingAdditionalCostID, QuoteItemID, SourcingHeaderID, SourcingStyleID, Description, Amount, CUser, CDate, MUser, MDate, TeamID)
		SELECT NEWID(), @StyleQuoteItemID, @SourcingHeaderID, @SourcingStyleID, AdditionalItemName, AdditionalItemCost, ISNULL(FirstName + ' ', '') + ISNULL(LastName, '') , 
		@CDate, ISNULL(FirstName + ' ', '') + ISNULL(LastName, ''), @CDate, @TeamID
		FROM pStyleCostingScenarioItems scenario LEFT JOIN pstyleCostingAdditionalItems adds ON adds.StytleCostingScenarioItemsID = scenario.StytleCostingScenarioItemsID,
		Users
		WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItemId
		AND Users.TeamID = @TeamID
	END
    
    IF @StyleCostingScenarioItemId <> '00000000-0000-0000-0000-000000000000' AND @StyleCostingScenarioItemId IS NOT NULL
    BEGIN
    
		IF EXISTS (SELECT * FROM pStyleCostingScenarioItems WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItemId)
		BEGIN
			UPDATE pStyleQuoteItem
			SET StyleQuoteItemCustomField7 = scenario.StyleCostingCustomField7, -- Duty %
			StyleQuoteItemCustomField13 = scenario.StyleCostingCustomField13, -- Freight
			StyleQuoteItemCustomField16 = scenario.StyleCostingCustomField19, -- Proposed Units
			StyleQuoteItemCustomField2 = scenario.StyleCostingCustomField3, -- Wholesale Units
			StyleQuoteItemCustomField6 = scenario.StyleCostingCustomField4, -- Retail Units
			StyleCostingCustomField15 = scenario.StyleCostingCustomField15, -- Wholesale Price/Unit
			StyleCostingCustomField16 = scenario.StyleCostingCustomField16, -- Retail Price/Unit
			StyleQuotaDutyID = scenario.StyleCostingHTS -- HTS Code
			FROM pStyleCostingScenarioItems scenario
			INNER JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
			WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItemId
		END
		ELSE
		BEGIN
			UPDATE pStyleQuoteItem
			SET StyleQuoteItemCustomField7 = costing.StyleCostingCustomField7, -- Duty %
			StyleQuoteItemCustomField13 = costing.StyleCostingCustomField13, -- Freight
			StyleQuoteItemCustomField16 = costing.StyleCostingCustomField19, -- Proposed Units
			StyleQuoteItemCustomField2 = costing.StyleCostingCustomField3, -- Wholesale Units
			StyleQuoteItemCustomField6 = costing.StyleCostingCustomField4, -- Retail Units
			StyleCostingCustomField15 = costing.StyleCostingCustomField15, -- Wholesale Price/Unit
			StyleCostingCustomField16 = costing.StyleCostingCustomField16, -- Retail Price/Unit
			StyleQuotaDutyID = costing.StyleCostingHTS -- HTS Code
			FROM pStyleCosting costing 
			WHERE costing.StyleCostingID = @StyleCostingScenarioItemId
		END
    
    END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06516', GetDate())
GO
