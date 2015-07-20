IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_SELECT]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@SystemColumnScenarioID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	-- Selecting second and third column of current costing and joining it to the first
    SELECT sysCol.StyleMaterialId, sysCol.StytleCostingScenarioItemsID, sysCol.MaterialName, sysCol.MaterialNo, 
			sysCol.MaterialType, sysCol.MaterialTypeDesc, sysCol.CDate, sysCol.MaterialCost AS CostSystem, firstCol.MaterialCost AS Cost1, 
			secondcol.MaterialCost AS Cost2, thirdcol.MaterialCost AS Cost3, 0 AS IsGroup
	FROM pstyleCostingBOM AS sysCol
	LEFT JOIN pstyleCostingBOM AS firstCol
	ON sysCol.StyleMaterialId = firstCol.StyleMaterialId
	LEFT JOIN pstyleCostingBOM AS secondCol
	ON sysCol.StyleMaterialId = secondCol.StyleMaterialId
	LEFT JOIN pstyleCostingBOM AS thirdCol
	ON sysCol.StyleMaterialId = thirdCol.StyleMaterialId
	WHERE sysCol.StytleCostingScenarioItemsID = @SystemColumnScenarioID
	AND firstCol.StytleCostingScenarioItemsID = @FirstColumnScenarioID
	AND secondCol.StytleCostingScenarioItemsID = @SecondColumnScenarioID
	AND thirdCol.StytleCostingScenarioItemsID = @ThirdColumnScenarioID
	UNION SELECT DISTINCT -- Selecting all the material types with it descriptions
			NULL AS StyleMaterialID, NULL AS StyleCostingScenarioItemsID, NULL As MaterialName, NULL As MaterialNo,
			MaterialType, MaterialTypeDesc, NULL As CDate, 
			(SELECT SUM(MaterialCost) FROM pstyleCostingBOM intSel WHERE StytleCostingScenarioItemsID = @SystemColumnScenarioID AND intSel.MaterialType = outSel.MaterialType) As CostSystem, 
			(SELECT SUM(MaterialCost) FROM pstyleCostingBOM intSel WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND intSel.MaterialType = outSel.MaterialType) AS Cost1, 
			(SELECT SUM(MaterialCost) FROM pstyleCostingBOM intSel WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND intSel.MaterialType = outSel.MaterialType) AS Cost2, 
			(SELECT SUM(MaterialCost) FROM pstyleCostingBOM intSel WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND intSel.MaterialType = outSel.MaterialType) AS Cost3,
			1 AS IsGroup
	FROM pstyleCostingBOM outSel
	WHERE StytleCostingScenarioItemsID = @SystemColumnScenarioID
		OR StytleCostingScenarioItemsID = @FirstColumnScenarioID 
		OR StytleCostingScenarioItemsID = @SecondColumnScenarioID
		OR StytleCostingScenarioItemsID = @ThirdColumnScenarioID
	ORDER BY MaterialType ASC, IsGroup DESC, CDate ASC, MaterialNo ASC
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04006', GetDate())
GO