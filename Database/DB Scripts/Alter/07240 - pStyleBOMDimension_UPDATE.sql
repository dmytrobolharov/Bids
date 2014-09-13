UPDATE pStyleBOMDimension SET ItemDim1TypeId = '00000000-0000-0000-0000-000000000000', ItemDim1TypeName = '<not used>'
WHERE ItemDim1TypeId IS NULL AND ItemDim1TypeName IS NULL

UPDATE pStyleBOMDimension SET ItemDim2TypeId = '00000000-0000-0000-0000-000000000000', ItemDim2TypeName = '<not used>'
WHERE ItemDim2TypeId IS NULL AND ItemDim2TypeName IS NULL

UPDATE pStyleBOMDimension SET ItemDim3TypeId = '00000000-0000-0000-0000-000000000000', ItemDim3TypeName = '<not used>'
WHERE ItemDim3TypeId IS NULL AND ItemDim3TypeName IS NULL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07240', GetDate())
GO
