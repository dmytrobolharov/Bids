IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingSums_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingSums_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingSums_SELECT]
	@StyleCostingScenarioItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 'BOMCost' As ColName, ISNULL(SUM(MaterialCost), '0.00') As ColValue FROM pstyleCostingBOM
	WHERE StytleCostingScenarioItemsID=@StyleCostingScenarioItemID
	UNION SELECT 'BOLCost' As ColName, ISNULL(SUM(OperationCost), '0.00') As ColValue FROM pStyleCostingBOL
	WHERE StytleCostingScenarioItemsID=@StyleCostingScenarioItemID
	UNION SELECT 'AdditionalCost' As ColName, ISNULL(SUM(AdditionalItemCost), '0.00') As ColValue FROM pstyleCostingAdditionalItems
	WHERE StytleCostingScenarioItemsID=@StyleCostingScenarioItemID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03965', GetDate())
GO
