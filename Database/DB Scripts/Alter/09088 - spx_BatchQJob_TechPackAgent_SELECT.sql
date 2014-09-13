IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_TechPackAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_TechPackAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_TechPackAgent_SELECT]  
 @BatchQueueJobID [uniqueidentifier],  
 @BatchQueueJobSql [nvarchar](max)  
WITH EXECUTE AS CALLER  
AS  
DECLARE   
 @TradePartnerTable NVARCHAR(200),   
 @SQL NVARCHAR(MAX),  
 @ParmDefinition NVARCHAR(500),  
 @BatchQueueID UNIQUEIDENTIFIER  
  
BEGIN  
 SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID  
END  
  
BEGIN  
 -- ** Style selected  
 SELECT @TradePartnerTable =  BatchQueueJobTable   
 FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)  
  INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID    
 WHERE a.BatchQueueJobID = @BatchQueueJobID  AND b.BatchQueuePageOrder = '0006'  
  
 SET @SQL = 'SELECT * FROM (' + @BatchQueueJobSql + ') a   
 WHERE EXISTS(SELECT a.TradePartnerRelationshipLevelID FROM ' + @TradePartnerTable + ' b WHERE b.TradePartnerRelationshipLevelID = a.TradePartnerRelationshipLevelID)  
 '  
 EXEC sp_executesql @SQL  
   
  
END  
  
  
  


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09088', GetDate())
GO