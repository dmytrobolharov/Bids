ALTER TABLE [pControlBOMConfig] ADD [ItemDim1TypeId] UNIQUEIDENTIFIER
GO
ALTER TABLE [pControlBOMConfig] ADD [ItemDim2TypeId] UNIQUEIDENTIFIER
GO
ALTER TABLE [pControlBOMConfig] ADD [ItemDim3TypeId] UNIQUEIDENTIFIER
GO

UPDATE pControlBOMConfig SET 
	ItemDim1TypeId = (SELECT DimTypeID FROM pStyleBOMDimType WHERE LOWER(DimTypeName) = 'color'),
	ItemDim2TypeId = (SELECT DimTypeID FROM pStyleBOMDimType WHERE LOWER(DimTypeName) = 'size')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07183', GetDate())
GO
