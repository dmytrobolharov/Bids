/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]    Script Date: 01/08/2013 18:15:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]    Script Date: 01/08/2013 18:15:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingQuoteQuick_CostingCopyData_SELECT]
	@StyleCostingScenarioItem UNIQUEIDENTIFIER
AS
BEGIN
    SELECT scenario.StyleCostingCustomField19 AS txtQuantity, -- Proposed Units
		costing.StyleBOMDimensionID AS ddlBOM
    FROM pStyleCostingScenarioItems scenario
    INNER JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
    LEFT JOIN pStyleCostingDuty duty ON duty.Custom = scenario.StyleCostingHTS
    WHERE scenario.StytleCostingScenarioItemsID = @StyleCostingScenarioItem
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04715', GetDate())
GO
