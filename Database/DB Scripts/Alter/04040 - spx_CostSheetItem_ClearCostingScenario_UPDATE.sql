IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_ClearCostingScenario_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_ClearCostingScenario_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_ClearCostingScenario_UPDATE]
	@ColumnScenarioID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Clearing BOM Costing
    UPDATE pstyleCostingBOM SET MaterialCost = '0.00'
    WHERE StytleCostingScenarioItemsID = @ColumnScenarioID
    -- Clearing BOL Costing
    UPDATE pStyleCostingBOL SET OperationCost = '0.00'
    WHERE StytleCostingScenarioItemsID = @ColumnScenarioID
    -- Clearing additional items
    UPDATE pstyleCostingAdditionalItems SET AdditionalItemCost = '0.00'
    WHERE StytleCostingScenarioItemsID = @ColumnScenarioID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04040', GetDate())
GO
