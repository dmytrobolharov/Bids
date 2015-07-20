-- Find Season & Year
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), '99A5E4E3-DD70-E011-9039-8EF3DCCB61B6', '90000000-0000-0000-0000-000000000015', '0000')

-- Select Material
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), 'D0C913C0-7D8C-E011-81E9-005056C00010', '90000000-0000-0000-0000-000000000015', '0001')

-- Select Multiple DBOM Pages
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), '54E5E4E3-DD70-E011-9039-8EF3DCCB61B4', '90000000-0000-0000-0000-000000000015', '0002')

-- Material To Replace With
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), 'D0C913C0-7D8C-E011-81E9-005056C00011', '90000000-0000-0000-0000-000000000015', '0003')

-- Batch Queue Dimensional BOMs
INSERT INTO pBatchQueuePage (BatchQueuePageID, BatchQueuePageTypeID, BatchQueueID, BatchQueuePageOrder)
VALUES (NEWID(), 'D0C913C0-7D8C-E011-81E9-005056C00013', '90000000-0000-0000-0000-000000000015', '0004')

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04572', GetDate())
GO
