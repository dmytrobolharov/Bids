/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleColorway_SELECT]    Script Date: 23.02.2015 17:29:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorway_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleColorway_SELECT]    Script Date: 23.02.2015 17:29:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorway_SELECT] (
	@BatchQueuePagePkName nVARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable nVARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	,
	@ReturnSQLString INT = 0
)AS 


DECLARE 
	@SeasonYearID UNIQUEIDENTIFIER,
	@SQL NVARCHAR(MAX)

--** Get Seasonyear
SELECT @SeasonYearID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 1


--** Find table/view submited in parameters
DECLARE 
	@tmpBatchQueueGridSql NVARCHAR(MAX),
	@ROWID INT ,
	@tmpTable NVARCHAR(200),
	@nPosWhere INT,
	@Where NVARCHAR(MAX)
	
SET @tmpBatchQueueGridSql = RTRIM(LTRIM(UPPER(@BatchQueueGridSql)))

SELECT IDENTITY(INT ,1,1) AS RowID, * INTO #tmp FROM dbo.split(@tmpBatchQueueGridSql,' ')  
SELECT @ROWID = ROWID FROM #tmp WHERE  RTRIM(LTRIM(items)) = 'FROM'
SELECT TOP 1 @tmpTable = items FROM #tmp  WHERE ROWID = @ROWID + 1 
DROP TABLE #tmp


SET @nPosWhere = CHARINDEX(' WHERE ',@tmpBatchQueueGridSql )
IF @nPosWhere > 0 
	SET @Where = SUBSTRING(@tmpBatchQueueGridSql , @nPosWhere +  7, LEN (@tmpBatchQueueGridSql))


IF @SeasonYearID IS NULL 
BEGIN 

	SET  @SQL = 'SELECT * FROM ' + @tmpTable + ' WHERE 1 = 2'

END 
ELSE
BEGIN 

	SET @SQL = '
	
	SELECT  ' +  @tmpTable  +  '.* FROM  ' + @tmpTable  + '
		LEFT OUTER JOIN pBatchQueueJobItemRecord c ON ' + @tmpTable  + '.StyleID = c.BatchQueuePagePki AND c.BatchQueueJobItemId = ''' + CAST(@BatchQueueJobItemID AS NVARCHAR(50)) + '''
	WHERE c.BatchQueuePagePki IS NULL 
		AND SeasonYearID =  ''' + CAST(@SeasonYearID AS NVARCHAR(40)) + '''  
	'

	IF @Where IS NOT NULL 
		SET @SQL = @SQL + ' AND ' +  @Where
		
	--** Get user id, check access
	DECLARE @TeamID UNIQUEIDENTIFIER
	SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
	IF @TeamID IS NOT NULL
	BEGIN
		SET @SQL = @SQL + ' AND StyleType IN (SELECT ProductTypeId FROM fnx_Permissions_GetIntProductTypePermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 2) 
							WHERE ( PermissionRoleId =3 OR PermissionModify = 1 ) ) '
	END 		

END 

IF @ReturnSQLString  = 0 
	EXEC sp_executesql @SQL 
ELSE 
	SELECT @SQL AS sqlString 




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09738', GetDate())
GO
