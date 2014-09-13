
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[spx_BatchQPage_SELECT](
@BatchQueuePageID UNIQUEIDENTIFIER,
@BatchQueueJobID UNIQUEIDENTIFIER
)
AS 

SELECT pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID, 
	  pBatchQueuePage.BatchQueuePageOrder, pBatchQueuePage.CUser, pBatchQueuePage.CDate, pBatchQueuePage.MUser, 
	  pBatchQueuePage.MDate, pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, 
	  pBatchQueuePageType.BatchQueuePageXmlSearch, pBatchQueuePageType.BatchQueuePageXmlForm, pBatchQueuePageType.BatchQueuePageXmlSelected,
	  pBatchQueuePageType.BatchQueuePageRecType, pBatchQueuePageType.BatchQueuePageRecMax, pBatchQueuePageType.BatchQueuePageSPX, 
	  pBatchQueuePageType.BatchQueuePageXmlGrid, pBatchQueuePageType.BatchQueuePageUrl, pBatchQueuePageType.BatchQueuePagePkID, 
	  pBatchQueueJobItem.BatchQueueJobItemID, pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, 
	  pBatchQueueJobItem.BatchQueueJobTable
FROM  pBatchQueuePage INNER JOIN
	  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID INNER JOIN
	  pBatchQueueJobItem ON pBatchQueuePage.BatchQueuePageID = pBatchQueueJobItem.BatchQueuePageID
WHERE pBatchQueuePage.BatchQueuePageID = @BatchQueuePageID AND 
		pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID 

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01492', GetDate())
GO
