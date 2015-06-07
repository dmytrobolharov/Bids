UPDATE pBatchQueuePageType SET BatchQueueExecuteSPX='spx_BatchQJob_StyleImage_EXECUTE' WHERE BatchQueueExecuteSPX='spx_BatchQJob_StyleImage_EXECUTE_QUEUE'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09775', GetDate())
GO
