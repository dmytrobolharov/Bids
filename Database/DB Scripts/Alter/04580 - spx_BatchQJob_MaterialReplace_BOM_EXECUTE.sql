/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE]    Script Date: 12/07/2012 12:02:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE]
GO


/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE]    Script Date: 12/07/2012 12:02:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE](
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
SET @ServiceQueueSql1 = 'dbo.spx_BatchQJob_MaterialReplace_BOM_EXECUTE_QUEUE ' + 
@pBatchQueueJobID  + ',' + 
@pMDate 

EXEC spx_ServiceQueue_INSERT @ServiceQueueSql = @ServiceQueueSql1, @ServiceQueuePriority = 1, @ServiceQueueDate = @ServiceDate


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04580', GetDate())
GO
