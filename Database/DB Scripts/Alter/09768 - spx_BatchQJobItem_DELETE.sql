/****** Object:  StoredProcedure [dbo].[spx_BatchQJobItem_DELETE]    Script Date: 2/13/2015 5:22:43 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJobItem_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobItem_DELETE]    Script Date: 2/13/2015 5:22:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJobItem_DELETE]
(
	@BatchQueuePagePkName nvarchar(200),
	@BatchQueuePagePkID nvarchar(40),
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
DECLARE @SQLString NVARCHAR(500);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @CountInt INT

	DELETE FROM dbo.pBatchQueueJobItemRecord  WHERE BatchQueuePagePki = @BatchQueuePagePkID AND BatchQueueJobItemId = @BatchQueueJobItemId
	--SET @SQLCountString = N'DELETE FROM dbo.' + @TempTableName + '  WHERE ' + @BatchQueuePagePkName + ' = @BatchQueuePagePkID AND BatchQueueJobItemId = @BatchQueueJobItemId'
	--EXEC sp_executesql @SQLCountString, N'@BatchQueueJobItemId nvarchar(40), @BatchQueuePagePkID nvarchar(40)', @BatchQueueJobItemId, @BatchQueuePagePkID

IF @BatchQueuePageId = '50000000-0000-0000-1000-000000000001' 
BEGIN 

	SELECT @TempTableName = '__' + 
		REPLACE(CAST(@BatchQueueJobId AS nVARCHAR(40)),'-','') 
		+ '_' +
		REPLACE('50000000-0000-0000-2000-000000000001','-','');	
	
	DELETE FROM dbo.pBatchQueueJobItemRecord WHERE BatchQueueJobItemId = @BatchQueueJobItemId
	--SET @SQLCountString = N'DELETE FROM dbo.' + @TempTableName 
	--EXECUTE sp_executesql @SQLCountString

END
	--IF @CountInt = 0
	--BEGIN
	--	SET @SQLString =N'INSERT INTO dbo.' + @TempTableName + ' 
	--										(' + @BatchQueuePagePkName + ', 
	--										BatchQueueJobId, 
	--										BatchQueueJobItemId,
	--										BatchQueuePageId,
	--										BatchQueueId,
	--										CUser,
	--										CDate)		
	--									VALUES 
	--										(@BatchQueuePagePkID,
	--										@BatchQueueJobId, 
	--										@BatchQueueJobItemId, 
	--										@BatchQueuePageId,
	--										@BatchQueueId,
	--										@CUser,
	--										@CDate)'
						
	--	SET @ParmDefinition = N'@BatchQueuePagePkIDn(40),
	--							@BatchQueuePageID nvarchar(40),
	--							@BatchQueueJobId nvarchar(40),
	--							@BatchQueueJobItemId nvarchar(40),
	--							@BatchQueueId nvarchar(40),						
	--							@CUser NVarChar(200),
	--							@CDate datetime'
													

	--	EXEC sp_executesql @SQLString, @ParmDefinition,
	--									@BatchQueuePagePkID,
	--									@BatchQueuePageID,
	--									@BatchQueueJobId,
	--									@BatchQueueJobItemId,
	--									@BatchQueueId,						
	--									@CUser,
	--									@CDate

	--END


		



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09768', GetDate())
GO
