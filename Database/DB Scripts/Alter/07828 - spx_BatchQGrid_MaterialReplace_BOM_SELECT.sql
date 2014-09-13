/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_MaterialReplace_BOM_SELECT]    Script Date: 06/03/2014 12:52:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_MaterialReplace_BOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_MaterialReplace_BOM_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_MaterialReplace_BOM_SELECT]    Script Date: 06/03/2014 12:52:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_MaterialReplace_BOM_SELECT] (
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
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
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



--** Get Material to be replaced
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + ' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT



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


IF @SeasonYearID IS NULL OR @MaterialID IS NULL
BEGIN 

	SET  @SQL = 'SELECT * FROM ' + @tmpTable + ' WHERE 1 = 2'

END 
ELSE
BEGIN 


	SET @SQL = '
	SELECT DISTINCT ' +  @tmpTable  +  '.* FROM (
		
		SELECT DISTINCT psm.StyleBOMDimensionID FROM ( 
			SELECT a.StyleID    
			FROM dbo.pStyleSeasonYear a WITH(NOLOCK)     
				INNER JOIN dbo.pStyleSeasonYear c WITH(NOLOCK) ON a.StyleID =  c.StyleID    
			WHERE a.SeasonYearID = '''+ CAST(@SeasonYearID AS NVARCHAR(40)) +'''        
			GROUP BY a.StyleID     
--			HAVING COUNT(*)  = 1   
		) AS style1Season 
			INNER JOIN dbo.pStyleBOM psm ON psm.StyleID = style1Season.StyleID
			WHERE psm.MaterialID = ''' + CAST(@MaterialID AS NVARCHAR(40)) + '''    
		
	) AS foo
		LEFT OUTER JOIN ' + @BatchQueueJobTable + '  c ON foo.StyleBOMDimensionID = c.StyleBOMDimensionID
		INNER JOIN ' + @tmpTable + '  ON '  + @tmpTable + '.StyleBOMDimensionID =  foo.StyleBOMDimensionID
	WHERE c.StyleBOMDimensionID IS NULL 
		AND foo.StyleBOMDimensionID IN (
			SELECT StyleBOMDimensionID FROM pStyleBOM WHERE MaterialID = ''' + CAST(@MaterialID AS NVARCHAR(40)) + ''' 	)
		AND foo.StyleBOMDimensionID NOT IN (
			SELECT psm2.StyleBOMDimensionID
			from pStyleBOM psm2
				INNER JOIN pStyleSeasonYear pssy2 ON psm2.StyleID =  pssy2.StyleID
					AND pssy2.SeasonYearID  = '''+ CAST(@SeasonYearID AS NVARCHAR(40)) +'''        
				INNER JOIN dbo.pStyleColorwaySeasonYear pscsy ON pscsy.StyleSeasonYearID = pssy2.StyleSeasonYearID
					AND StyleColorStatus  IN ( 200,300 ) 
			WHERE psm2.MaterialID = ''' + CAST(@MaterialID AS NVARCHAR(40)) + '''	
				AND psm2.MainMaterial = 1 
		)
				
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
VALUES ('DB_Version', '0.5.0000', '07828', GetDate())
GO
