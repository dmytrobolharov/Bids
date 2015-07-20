UPDATE pStyleBOM SET Dim1TypeSel = 0
FROM pStyleBOM bom INNER JOIN pStyleBOMDimension dim ON bom.StyleBOMDimensionId = dim.StyleBOMDimensionID
WHERE dim.ItemDim1TypeId = '00000000-0000-0000-0000-000000000000' AND bom.Dim1TypeSel = 1

GO

UPDATE pStyleBOM SET Dim2TypeSel = 0
FROM pStyleBOM bom INNER JOIN pStyleBOMDimension dim ON bom.StyleBOMDimensionId = dim.StyleBOMDimensionID
WHERE dim.ItemDim2TypeId = '00000000-0000-0000-0000-000000000000' AND bom.Dim2TypeSel = 1 

GO

UPDATE pStyleBOM SET Dim3TypeSel = 0
FROM pStyleBOM bom INNER JOIN pStyleBOMDimension dim ON bom.StyleBOMDimensionId = dim.StyleBOMDimensionID
WHERE dim.ItemDim3TypeId = '00000000-0000-0000-0000-000000000000' AND bom.Dim3TypeSel = 1 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06043', GetDate())
GO
