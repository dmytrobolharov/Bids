/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleHeader_SELECT]    Script Date: 2/13/2015 4:45:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleHeader_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleHeader_SELECT]    Script Date: 2/13/2015 4:45:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleHeader_SELECT]
(
	@BatchQueuePagePkName nvarchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable nvarchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate datetime	,
	@ReturnSQLString INT  = 0
)
AS 


BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE EXISTS (SELECT * FROM pBatchQueueJobItemRecord WHERE BatchQueuePagePki = SqlBatchQ.' + @BatchQueuePagePkName + ' AND BatchQueueJobItemId = ''' + CAST(@BatchQueueJobItemID AS NVARCHAR(50)) + ''')'	
END	
	
BEGIN						
	IF @ReturnSQLString = 0 
		EXEC (@SQLString) 					
	ELSE 
		SELECT @SQLString AS sqlString
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09741', GetDate())
GO
