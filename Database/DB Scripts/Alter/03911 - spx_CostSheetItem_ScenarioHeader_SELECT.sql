IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_ScenarioHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_ScenarioHeader_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_CostSheetItem_ScenarioHeader_SELECT]
	@StyleCostingID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT StytleCostingScenarioItemsID, StyleCostingName, 0 AS SystemCost
    FROM pStyleCostingScenarioItems
    WHERE StyleCostingID = @StyleCostingID
    UNION SELECT StyleCostingScenarioItemsId, StyleCostingName, 1 AS SystemCost
    FROM pStyleCosting
    WHERE StyleCostingID = @StyleCostingID
    ORDER BY SystemCost DESC
    
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03911', GetDate())
GO
