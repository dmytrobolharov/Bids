/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StylePage_SELECT]    Script Date: 2/13/2015 4:56:41 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StylePage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StylePage_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StylePage_SELECT]    Script Date: 2/13/2015 4:56:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_BatchQGrid_StylePage_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@BatchQueueJobItemId UNIQUEIDENTIFIER


--** Get Pages
SELECT @syBatchQueueJobTable = BatchQueueJobTable, @BatchQueueJobItemId = BatchQueueJobItemID 
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT a.WorkflowID, a.Workflow 
FROM pBatchQueueStyleWorkflow a
	INNER JOIN pBatchQueueJobItemRecord b ON a.WorkflowID = b.BatchQueuePagePki
WHERE b.BatchQueueJobId = ''' + CAST(@BatchQueueJobId AS nVARCHAR(40)) + ''' AND b.BatchQueueJobItemId = ''' + CAST(@BatchQueueJobItemId AS nVARCHAR(40)) + ''''


EXECUTE	sp_executesql @sySQL




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09751', GetDate())
GO

