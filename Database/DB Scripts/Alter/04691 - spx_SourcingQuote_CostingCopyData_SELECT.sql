/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_CostingCopyData_SELECT]    Script Date: 12/26/2012 15:01:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_CostingCopyData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_CostingCopyData_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_CostingCopyData_SELECT]    Script Date: 12/26/2012 15:01:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
    LEFT JOIN pStyleCostingDuty duty ON duty.Custom = scenario.StyleCostingHTS
    WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItem
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04691', GetDate())
GO
