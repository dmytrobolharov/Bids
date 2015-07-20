IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT](
	@BatchQueuePagePkName nvarchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable nvarchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate DATETIME
)
AS 


DECLARE 
	@StyleTableName NVARCHAR(500),
	@sySQL NVARCHAR(1000)


SELECT @StyleTableName =  BatchQueueJobTable 
FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
	INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
WHERE a.BatchQueueJobID = @BatchQueueJobID 
	AND b.BatchQueuePageOrder = '0001'
	
SET @sySQL = 'SELECT a.* FROM vwx_BatchQ_TechPackStyle_SEL a INNER JOIN ' + @StyleTableName  + ' b ON 
		a.StyleID = b.StyleID'
		
EXECUTE	sp_executesql @sySQL	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06925', GetDate())
GO
