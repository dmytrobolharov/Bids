IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQPageJobItem_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQPageJobItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQPageJobItem_SELECT](
	@BatchQueueJobItemID UNIQUEIDENTIFIER
)
AS 

SELECT pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID, 
	  pBatchQueuePage.BatchQueuePageOrder, pBatchQueuePage.CUser, pBatchQueuePage.CDate, pBatchQueuePage.MUser, 
	  pBatchQueuePage.MDate, pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, 
	  pBatchQueuePageType.BatchQueuePageXmlSearch, pBatchQueuePageType.BatchQueuePageXmlForm, pBatchQueuePageType.BatchQueuePageXmlSelected,
	  pBatchQueuePageType.BatchQueuePageRecType, pBatchQueuePageType.BatchQueuePageRecMax, pBatchQueuePageType.BatchQueuePageSPX, 
	  pBatchQueuePageType.BatchQueuePageXmlGrid, pBatchQueuePageType.BatchQueuePageUrl, pBatchQueuePageType.BatchQueuePagePkID, 
	  pBatchQueueJobItem.BatchQueueJobItemID, pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, 
	  pBatchQueueJobItem.BatchQueueJobTable, pBatchQueuePageType.BatchQueueExecuteSPX, 
	  pBatchQueuePageType.BatchQueueLogicInsertSPX, pBatchQueuePageType.BatchQueuePageXmlGridAlternating,
	  pBatchQueuePageType.BatchQueueGridAlternatingName, pBatchQueuePageType.BatchQueueGridXMLThumbnail
FROM  pBatchQueuePage INNER JOIN
	  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID INNER JOIN
	  pBatchQueueJobItem ON pBatchQueuePage.BatchQueuePageID = pBatchQueueJobItem.BatchQueuePageID
WHERE pBatchQueueJobItem.BatchQueueJobItemID = @BatchQueueJobItemID 


go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02056'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02056', GetDate())
END	
GO