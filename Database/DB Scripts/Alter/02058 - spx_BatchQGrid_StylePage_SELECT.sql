IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StylePage_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StylePage_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StylePage_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200)


--** Get Pages
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT a.WorkflowID, a.Workflow 
FROM pBatchQueueStyleWorkflow a
	INNER JOIN ' + @syBatchQueueJobTable  + ' b ON a.WorkflowID = b.WorkflowID
WHERE b.BatchQueueJobId = ''' + CAST(@BatchQueueJobId AS VARCHAR(40)) + ''' '


EXECUTE	sp_executesql @sySQL


go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02058'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02058', GetDate())
END	
GO