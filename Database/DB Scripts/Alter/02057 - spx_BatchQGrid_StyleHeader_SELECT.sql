IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleHeader_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleHeader_SELECT]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable varchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate datetime	,
	@ReturnSQLString INT  = 0
)
AS 


BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE EXISTS (SELECT * FROM ' +  @BatchQueueJobTable + ' WHERE ' + @BatchQueuePagePkName + ' = SqlBatchQ.' + @BatchQueuePagePkName + ')'	
END	
	
BEGIN						
	IF @ReturnSQLString = 0 
		EXEC (@SQLString) 					
	ELSE 
		SELECT @SQLString AS sqlString
END

go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02057'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02057', GetDate())
END	
GO