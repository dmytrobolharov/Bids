IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleType_SELECT]
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
	@ReturnSQLString INT = 0
)
AS 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	
	--IF CHARINDEX(' WHERE ', @BatchQueueGridSql) > 0
	--	SET @BatchQueueGridSql = @BatchQueueGridSql + ' AND Active = 1 AND ((Season IN (SELECT Custom FROM pSeason WHERE Active = 1)) OR (Season NOT IN (SELECT Custom FROM pSeason)))
	--		AND ((Year IN (SELECT Custom FROM pYear WHERE Active = 1)) OR (Year NOT IN (SELECT Custom FROM pYear)))'
	--ELSE
	--	SET @BatchQueueGridSql = @BatchQueueGridSql + ' WHERE Active = 1 AND ((Season IN (SELECT Custom FROM pSeason WHERE Active = 1)) OR (Season NOT IN (SELECT Custom FROM pSeason)))
	--		AND ((Year IN (SELECT Custom FROM pYear WHERE Active = 1)) OR (Year NOT IN (SELECT Custom FROM pYear)))'

	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM ' +  @BatchQueueJobTable + ' WHERE ' + @BatchQueuePagePkName + ' = SqlBatchQ.' + @BatchQueuePagePkName + ')'

	DECLARE @tmpBatchQueueJobtable nvarchar(200),
		@tmpBatchQueuePagePkiName nvarchar(40),
		@BatchQueueIndex int, 
		@BatchQueueRowCount int

	SET @BatchQueueIndex = 1

		SET NOCOUNT ON
		BEGIN

			SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			 pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
			  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
			  pBatchQueuePageType.BatchQueuePagePkID
			INTO #BatchQueueDep  
			FROM pBatchQueuePageDep INNER JOIN
			  pBatchQueueJobItem ON pBatchQueuePageDep.BatchQueuePageRelationID = pBatchQueueJobItem.BatchQueuePageID INNER JOIN
			  pBatchQueuePage ON pBatchQueueJobItem.BatchQueuePageID = pBatchQueuePage.BatchQueuePageID INNER JOIN
			  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
			WHERE (pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID) AND 
			  (pBatchQueuePageDep.BatchQueuePageID = @BatchQueuePageID) 

			SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueDep)
				WHILE @BatchQueueIndex <= @BatchQueueRowCount 
					BEGIN

						SELECT @tmpBatchQueueJobtable = BatchQueueJobTable, @tmpBatchQueuePagePkiName = BatchQueuePagePkID 
							FROM #BatchQueueDep WHERE BatchQueueIndex = @BatchQueueIndex	

								SET @SQLString = @SQLString + ' AND EXISTS (SELECT * FROM ' + @tmpBatchQueueJobtable +
									' WHERE ' + @tmpBatchQueuePagePkiName + ' = SqlBatchQ.' + @tmpBatchQueuePagePkiName + ')'

						SET @BatchQueueIndex = @BatchQueueIndex + 1
					END

			DROP TABLE #BatchQueueDep

		SET NOCOUNT OFF
		END		
END	

BEGIN						
	EXEC (@SQLString + ' ORDER BY StyleTypeDescription ') 					
END





GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09086', GetDate())
GO