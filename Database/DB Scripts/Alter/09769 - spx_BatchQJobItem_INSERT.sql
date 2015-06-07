/****** Object:  StoredProcedure [dbo].[spx_BatchQJobItem_INSERT]    Script Date: 2/13/2015 5:32:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJobItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobItem_INSERT]    Script Date: 2/13/2015 5:32:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJobItem_INSERT]
(
	@BatchQueuePagePkName nvarchar(200),
	@BatchQueuePagePkID uniqueidentifier,
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueId uniqueidentifier,
	@CUser NVarChar(200),
	@CDate datetime
)
AS 


DECLARE @TempTableName nvarchar(200)
	
	SELECT @TempTableName = '__' + 
		REPLACE(CAST(@BatchQueueJobId AS nVARCHAR(40)),'-','') 
		+ '_' +
		REPLACE(CAST(@BatchQueuePageId AS nVARCHAR(40)),'-','');	
	
DECLARE @SQLCountString NVARCHAR(500);	
DECLARE @SQLString NVARCHAR(1000);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @CountInt INT

	SELECT @CountInt = COUNT(*) FROM dbo.pBatchQueueJobItemRecord  WHERE BatchQueuePagePki = @BatchQueuePagePkID AND BatchQueueJobItemId = @BatchQueueJobItemId
	--SET @SQLCountString = N'SELECT @cnt = COUNT(*) FROM dbo.pBatchQueueJobItemRecord  WHERE BatchQueuePagePki = @BatchQueuePagePkID AND BatchQueueJobID = ''' + CAST(@BatchQueueJobID AS NVARCHAR(50)) + ''' AND BatchQueuePageId = ''' + CAST(@BatchQueuePageId AS NVARCHAR(50)) + ''''
	--EXEC sp_executesql @SQLCountString, N'@BatchQueuePagePkID nvarchar(40), @cnt INT OUTPUT', @BatchQueuePagePkID, @cnt = @CountInt OUTPUT

	IF @CountInt = 0
	BEGIN
		SET @SQLString =N'INSERT INTO dbo.pBatchQueueJobItemRecord 
											(BatchQueuePagePki, 
											BatchQueueJobId, 
											BatchQueueJobItemId,
											BatchQueuePageId,
											BatchQueueId,
											CUser,
											CDate)		
										VALUES 
											(@BatchQueuePagePkID,
											@BatchQueueJobId, 
											@BatchQueueJobItemId, 
											@BatchQueuePageId,
											@BatchQueueId,
											@CUser,
											@CDate)'
						
		SET @ParmDefinition = N'@BatchQueuePagePkID nvarchar(40),
								@BatchQueuePageID nvarchar(40),
								@BatchQueueJobId nvarchar(40),
								@BatchQueueJobItemId nvarchar(40),
								@BatchQueueId nvarchar(40),						
								@CUser NVarChar(200),
								@CDate datetime'
													

		EXEC sp_executesql @SQLString, @ParmDefinition,
										@BatchQueuePagePkID,
										@BatchQueuePageID,
										@BatchQueueJobId,
										@BatchQueueJobItemId,
										@BatchQueueId,						
										@CUser,
										@CDate

	END





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09769', GetDate())
GO
