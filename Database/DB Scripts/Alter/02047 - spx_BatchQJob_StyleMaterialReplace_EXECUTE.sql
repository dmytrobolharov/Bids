IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS

DECLARE @BatchQueueID UNIQUEIDENTIFIER
SELECT @BatchQueueID = BatchQueueID FROM pBatchQueueJob WITH(NOLOCK) WHERE BatchQueueJobID  = @BatchQueueJobID 

UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '10000000-0000-0000-0000-000000000000'
WHERE BatchQueueJobID  = @BatchQueueJobID 


--** Insert job to the service queue
DECLARE 
	@ServiceDate DATETIME,
	@pBatchQueueJobID NVARCHAR(70),
	@pMDate NVARCHAR(100)
	
SET @ServiceDate = getdate()
SET @pBatchQueueJobID = ' @BatchQueueJobID = ''' +  CAST (@BatchQueueJobID AS NVARCHAR(50)) + ''' '
SET @pMDate = ' @MDate = ''' +  CONVERT( NVARCHAR(40) , @MDate  , 20 ) + ''' '

DECLARE @ServiceQueueSql1 nvarchar(4000)
SET @ServiceQueueSql1 = 'dbo.spx_BatchQJob_StyleMaterialReplace_EXECUTE_QUEUE ' + 
@pBatchQueueJobID  + ',' + 
@pMDate 

EXEC spx_ServiceQueue_INSERT @ServiceQueueSql = @ServiceQueueSql1, @ServiceQueuePriority = 1, @ServiceQueueDate = @ServiceDate

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02047'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02047', GetDate())
END	
GO