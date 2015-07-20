update pBatchQueuePage set BatchQueuePageTypeID='54E6E4E3-DD70-E011-9039-8EF3DCCB61B4' where BatchQueueID='90000000-0000-0000-0000-000000000017' and BatchQueuePageOrder='0003'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04652', GetDate())
GO
