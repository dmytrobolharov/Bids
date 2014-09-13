IF (SELECT COUNT(*) FROM pStyleBOMDimensionComboItems) = 0
BEGIN
	INSERT INTO pStyleBOMDimensionComboItems (StyleBOMDimensionComboItemID, StyleBOMDimensionID, ItemDim2Id, ItemDim3Id, Active)
	SELECT NEWID(), d2.StyleBOMDimensionID, d2.ItemDim2Id, d3.ItemDim3Id, 1 FROM pStyleBOMDimensionItem d2
		CROSS JOIN pStyleBOMDimensionItem d3
		INNER JOIN pStyleBOMDimension sbd ON d2.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	WHERE d2.StyleBOMDimensionID = d3.StyleBOMDimensionID AND d2.ItemDim2Id IS NOT NULL AND d3.ItemDim3Id IS NOT NULL
	AND LOWER(sbd.ItemDim1TypeName) = 'color' AND LOWER(sbd.ItemDim2TypeName) = 'size' AND LOWER(sbd.ItemDim3TypeName) = 'cup size'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06461', GetDate())
GO
