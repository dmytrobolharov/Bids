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
			sysCol.OperationTypeID, ISNULL(sysCol.OperationCost, '0.00') AS CostSystem, ISNULL(firstCol.OperationCost, '0.00') AS Cost1, 
			ISNULL(secondcol.OperationCost, '0.00') AS Cost2, ISNULL(thirdcol.OperationCost, '0.00') AS Cost3, 0 AS IsGroup
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
	
	/* Template of group select from BOM -- we'll do the same here as soon as we'll know, what groups we need to use
	 
	UNION SELECT DISTINCT -- Selecting all the material types with it descriptions
			NULL AS StyleMaterialID, NULL AS StyleCostingScenarioItemsID, NULL As MaterialName, NULL As MaterialNo,
			MaterialType, MaterialTypeDesc, NULL As CostSystem, NULL AS Cost1, NULL AS Cost2, NULL AS Cost3,
			1 AS IsGroup
	FROM pstyleCostingBOM
	WHERE StytleCostingScenarioItemsID = @SystemColumnScenarioID
		OR StytleCostingScenarioItemsID = @FirstColumnScenarioID 
		OR StytleCostingScenarioItemsID = @SecondColumnScenarioID
		OR StytleCostingScenarioItemsID = @ThirdColumnScenarioID
	ORDER BY MaterialType ASC, IsGroup DESC, MaterialNo ASC */
	
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03909', GetDate())
GO
