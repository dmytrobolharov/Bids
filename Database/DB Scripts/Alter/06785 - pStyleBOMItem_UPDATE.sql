INSERT INTO pStyleBOMItem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID, WorkflowID, WorkflowItemID, StyleID, StyleSet
	, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name, ItemDim3ID, ItemDim3Name, CDate, CUser, MDate, MUser)		

SELECT sbis.StyleBOMDimensionId, sbis.StyleBOMDimensionItemId, sb.StyleMaterialID, 
	sbis.WorkflowID, sbis.WorkflowItemID, sbis.StyleID, sbis.StyleSet,
	sbis.ItemDim1TypeId, sbis.ItemDim2TypeId, sbis.ItemDim3TypeId, 
	sbis.ItemDim1Id, sbis.ItemDim1Name, sbis.ItemDim2Id, sbis.ItemDim2Name, sbis.ItemDim3Id, sbis.ItemDim3Name, 
	sbis.CDate, sbis.CUser, sbis.MDate, sbis.MUser 
FROM pStyleBOMDimensionItems sbis
	INNER JOIN pStyleBOM sb ON sbis.StyleBOMDimensionId = sb.StyleBOMDimensionId
WHERE sbis.StyleBOMDimensionItemId NOT IN
	(SELECT StyleBOMDimensionItemId FROM pStyleBOMItem WHERE StyleBOMDimensionId = sbis.StyleBOMDimensionId AND StyleMaterialID = sb.StyleMaterialID)
AND sb.StyleMaterialID NOT IN 
	(SELECT StyleMaterialID FROM pStyleBOMItem WHERE StyleBOMDimensionId = sbis.StyleBOMDimensionId)

	
GO


DELETE FROM pStyleBOMItem WHERE StyleBOMDimensionItemID IN (SELECT StyleBOMDimensionItemID FROM pStyleBOMDimensionItem)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06785', GetDate())
GO
