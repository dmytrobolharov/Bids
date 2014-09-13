IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_DELETE2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_DELETE2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCosting_DELETE2](
	@StyleCostingId uniqueidentifier
)
AS 

DELETE FROM pStyleCostingBOL 
WHERE StytleCostingScenarioItemsID IN 
	(SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems WHERE StyleCostingID = @StyleCostingId)

DELETE FROM pstyleCostingBOM
WHERE StytleCostingScenarioItemsID IN 
	(SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems WHERE StyleCostingID = @StyleCostingId)

DELETE FROM pstyleCostingAdditionalItems
WHERE StytleCostingScenarioItemsID IN 
	(SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems WHERE StyleCostingID = @StyleCostingId)

DELETE FROM dbo.pStyleCostingScenarioItems
WHERE StyleCostingID = @StyleCostingId

DELETE FROM dbo.pStyleCosting
WHERE StyleCostingID = @StyleCostingId

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03917', GetDate())
GO
