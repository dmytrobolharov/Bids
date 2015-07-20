/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleColorway_SELECT]    Script Date: 01/14/2013 15:25:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorway_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleColorway_SELECT]    Script Date: 01/14/2013 15:25:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorway_SELECT] (
	@BatchQueuePagePkName VARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable VARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	,
	@ReturnSQLString INT = 0
)AS 


DECLARE 
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER,
	@SQL NVARCHAR(MAX)

--** Get Seasonyear
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID  FROM ' + @syBatchQueueJobTable + ' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT


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
		LEFT OUTER JOIN ' + @BatchQueueJobTable + '  c ON ' + @tmpTable  + '.StyleID = c.StyleID
		LEFT OUTER JOIN pStyleHeader ph ON ph.StyleID = ' + @tmpTable  + '.StyleID
		LEFT OUTER JOIN dbo.pStyleCategory ON dbo.pStyleCategory.StyleCategoryId = ph.StyleCategory 
		LEFT OUTER JOIN dbo.pSizeClass ON dbo.pSizeClass.Custom = ph.SizeClass 
	WHERE c.StyleID IS NULL 
		AND SeasonYearID =  ''' + CAST(@SeasonYearID AS NVARCHAR(40)) + '''  
		AND pStyleCategory.Active = 1 AND pSizeClass.Active = 1
	'

	IF @Where IS NOT NULL 
		SET @SQL = @SQL + ' AND ' +  @Where
		
	--** Get user id, check access
	DECLARE @TeamID UNIQUEIDENTIFIER
	SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
	IF @TeamID IS NOT NULL
	BEGIN
		SET @SQL = @SQL + ' AND ph.StyleType IN (SELECT StyleTypeID FROM sAccessStyleFolder WHERE ( AccessRoleId =3 OR AccessModify = 1 )  
		AND TeamId = ''' + CAST(@TeamID AS NVARCHAR(40)) + ''' ) '
	END 		

END 

SET @SQL = REPLACE(@SQL,'STYLENO','ph.STYLENO')

IF @ReturnSQLString  = 0 
	EXEC sp_executesql @SQL 
ELSE 
	SELECT @SQL AS sqlString 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04740', GetDate())
GO

