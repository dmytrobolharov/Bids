IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOL_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOL_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOL_SELECT]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@SystemColumnScenarioID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	-- Selecting second and third column of current costing and joining it to the first
    SELECT sysCol.StyleNBOLItemId, sysCol.StytleCostingScenarioItemsID, sysCol.OperationName, sysCol.OperationCode, 
			sysCol.OperationTypeID, sysCol.CDate, ISNULL(sysCol.OperationCost, '0.00') AS CostSystem, ISNULL(firstCol.OperationCost, '0.00') AS Cost1, 
			ISNULL(secondcol.OperationCost, '0.00') AS Cost2, ISNULL(thirdcol.OperationCost, '0.00') AS Cost3, 0 AS IsGroup,
			(SELECT COUNT(*) FROM pStyleNBOLItems nbol WHERE nbol.StyleNBOLItemID = sysCol.StyleNBOLItemId) AS IsCopied
	FROM pstyleCostingBOL AS sysCol
	LEFT JOIN pstyleCostingBOL AS firstCol
	ON sysCol.StyleNBOLItemId = firstCol.StyleNBOLItemId
	LEFT JOIN pstyleCostingBOL AS secondCol
	ON sysCol.StyleNBOLItemId = secondCol.StyleNBOLItemId
	LEFT JOIN pstyleCostingBOL AS thirdCol
	ON sysCol.StyleNBOLItemId = thirdCol.StyleNBOLItemId
	WHERE sysCol.StytleCostingScenarioItemsID = @SystemColumnScenarioID
	AND firstCol.StytleCostingScenarioItemsID = @FirstColumnScenarioID
	AND secondCol.StytleCostingScenarioItemsID = @SecondColumnScenarioID
	AND thirdCol.StytleCostingScenarioItemsID = @ThirdColumnScenarioID
	ORDER BY sysCol.CDate, OperationCode
	
	/*PROBABLY TO DO: If we'll have a need to make grouping for BOL table -- steal UNION SELECT from spx_CostSheetItem_CostingBOM_SELECT*/
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04061', GetDate())

GO

