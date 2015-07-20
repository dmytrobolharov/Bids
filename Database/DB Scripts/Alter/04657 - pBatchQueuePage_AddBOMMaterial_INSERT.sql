-- Find Season & Year
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), '99A5E4E3-DD70-E011-9039-8EF3DCCB61B6', '90000000-0000-0000-0000-000000000016', '0000')

-- Select Material
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), 'D0C913C0-7D8C-E011-81E9-005056C00008', '90000000-0000-0000-0000-000000000016', '0001')

-- Select Multiple DBOM Pages
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), '54E6E4E3-DD70-E011-9039-8EF3DCCB61B4', '90000000-0000-0000-0000-000000000016', '0002')

-- Batch Queue Dimensional BOMs
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), '54E6E4E3-DD70-E011-9039-8EF3DCCB61C4', '90000000-0000-0000-0000-000000000016', '0004')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04657', GetDate())
GO
