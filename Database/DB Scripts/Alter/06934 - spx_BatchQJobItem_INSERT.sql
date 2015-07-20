IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJobItem_INSERT]
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

	SET @SQLCountString = N'SELECT @cnt = COUNT(*) FROM dbo.' + @TempTableName + '  WHERE ' + @BatchQueuePagePkName + ' = @BatchQueuePagePkID'
	EXEC sp_executesql @SQLCountString, N'@BatchQueuePagePkID nvarchar(40), @cnt INT OUTPUT', @BatchQueuePagePkID, @cnt = @CountInt OUTPUT

	IF @CountInt = 0
	BEGIN
		SET @SQLString =N'INSERT INTO dbo.' + @TempTableName + ' 
											(' + @BatchQueuePagePkName + ', 
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
VALUES              ('DB_Version', '0.5.0000', '06934', GetDate())
GO
