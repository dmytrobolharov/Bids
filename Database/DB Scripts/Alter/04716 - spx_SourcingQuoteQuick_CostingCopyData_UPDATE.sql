/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]    Script Date: 01/08/2013 18:22:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]    Script Date: 01/08/2013 18:22:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_UPDATE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SourcingStyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleCostingScenarioItem UNIQUEIDENTIFIER
	SELECT @StyleCostingScenarioItem = StyleCostingScenarioItemID FROM pStyleQuoteItem
	WHERE StyleQuoteItemID = @StyleQuoteItemID

	DELETE FROM pSourcingAdditionalCost WHERE QuoteItemID = @StyleQuoteItemID
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
    
    UPDATE pStyleQuoteItem
    SET StyleQuoteItemCustomField7 = scenario.StyleCostingCustomField7, -- Duty %
    StyleQuoteItemCustomField13 = scenario.StyleCostingCustomField13, -- Freight
    StyleQuoteItemCustomField16 = scenario.StyleCostingCustomField19, -- Proposed Units
    StyleQuoteItemCustomField2 = scenario.StyleCostingCustomField3, -- Wholesale Units
    StyleQuoteItemCustomField6 = scenario.StyleCostingCustomField4, -- Retail Units
    StyleCostingCustomField15 = scenario.StyleCostingCustomField15, -- Wholesale Price/Unit
    StyleCostingCustomField16 = scenario.StyleCostingCustomField16, -- Retail Price/Unit
    StyleQuotaDutyID = duty.CustomID -- HTS Code
    FROM pStyleCostingScenarioItems scenario
    INNER JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
    LEFT JOIN pStyleCostingDuty duty ON duty.Custom = scenario.StyleCostingHTS
    WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItem
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04716', GetDate())
GO
