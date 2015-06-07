/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPackAgent_SELECT]    Script Date: 25.02.2015 17:58:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_TechPackAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_TechPackAgent_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPackAgent_SELECT]    Script Date: 25.02.2015 17:58:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_TechPackAgent_SELECT]  
 @BatchQueueJobID [uniqueidentifier],  
 @BatchQueueJobSql [nvarchar](max)  
WITH EXECUTE AS CALLER  
AS  
BEGIN

DECLARE    
 @SQL NVARCHAR(MAX) 

 SET @SQL = 'SELECT DISTINCT BatchSQL.* FROM (' + @BatchQueueJobSql + ') AS BatchSQL
 INNER JOIN pBatchQueueJobItemRecord rec ON BatchSQL.TradePartnerRelationshipLevelID = rec.BatchQueuePagePki
 INNER JOIN pBatchQueueJobItem job ON job.BatchQueueJobItemID = rec.BatchQueueJobItemID AND job.BatchQueueJobID = ''' + CAST(@BatchQueueJobID AS NVARCHAR(40)) + '''
 INNER JOIN pBatchQueuePage page ON job.BatchQueuePageID = page.BatchQueuePageID AND page.BatchQueuePageOrder = ''0006''
 '  
 EXEC sp_executesql @SQL  
   
END  
  
  
  



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09765', GetDate())
GO
