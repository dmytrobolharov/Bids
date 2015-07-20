IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingAdditional_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditional_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditional_SELECT]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@SystemColumnScenarioID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	-- Selecting second and third column of current costing and joining it to the first
    SELECT sysCol.AdditionalItemNo, sysCol.StytleCostingScenarioItemsID, sysCol.AdditionalItemName, sysCol.AdditionalItemNo, 
			ISNULL(sysCol.AdditionalItemCost, '0.00') AS CostSystem, ISNULL(firstCol.AdditionalItemCost, '0.00') AS Cost1, 
			ISNULL(secondcol.AdditionalItemCost, '0.00') AS Cost2, ISNULL(thirdcol.AdditionalItemCost, '0.00') AS Cost3
	FROM pstyleCostingAdditionalItems AS sysCol
	LEFT JOIN pstyleCostingAdditionalItems AS firstCol
	ON sysCol.AdditionalItemNo = firstCol.AdditionalItemNo
	LEFT JOIN pstyleCostingAdditionalItems AS secondCol
	ON sysCol.AdditionalItemNo = secondCol.AdditionalItemNo
	LEFT JOIN pstyleCostingAdditionalItems AS thirdCol
	ON sysCol.AdditionalItemNo = thirdCol.AdditionalItemNo
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
VALUES     ('DB_Version', '5.0.0000', '03908', GetDate())
GO
