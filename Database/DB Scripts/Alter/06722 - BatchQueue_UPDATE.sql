UPDATE pBatchQueue SET
	BatchQueueName = REPLACE(BatchQueueName, 'Dimensional BOM', 'Bill of Material')
	, BatchQueueDesc = REPLACE(BatchQueueDesc, 'Dimensional BOM', 'Bill of Material')
GO

UPDATE pBatchQueuePageType SET
	BatchQueuePageTypeName = REPLACE(REPLACE(BatchQueuePageTypeName, 'DBOM', 'Bill of Material'), 'Dimensional BOM', 'Bill of Material')
	, BatchQueuePageTypeDesc = REPLACE(BatchQueuePageTypeDesc, 'Dimensional BOM', 'Bill of Material')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06722', GetDate())
GO
