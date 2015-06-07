/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_SeasonYear_SELECT]    Script Date: 23.02.2015 17:14:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_SeasonYear_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_SeasonYear_SELECT]    Script Date: 23.02.2015 17:14:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_BatchQGrid_SeasonYear_SELECT]
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
	
	IF CHARINDEX(' WHERE ', @BatchQueueGridSql) > 0
		SET @BatchQueueGridSql = @BatchQueueGridSql + ' AND Active = 1 AND ((Season IN (SELECT Custom FROM pSeason WHERE Active = 1)) OR (Season NOT IN (SELECT Custom FROM pSeason)))
			AND ((Year IN (SELECT Custom FROM pYear WHERE Active = 1)) OR (Year NOT IN (SELECT Custom FROM pYear)))'
	ELSE
		SET @BatchQueueGridSql = @BatchQueueGridSql + ' WHERE Active = 1 AND ((Season IN (SELECT Custom FROM pSeason WHERE Active = 1)) OR (Season NOT IN (SELECT Custom FROM pSeason)))
			AND ((Year IN (SELECT Custom FROM pYear WHERE Active = 1)) OR (Year NOT IN (SELECT Custom FROM pYear)))'

	SET @SqlString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ
		LEFT OUTER JOIN pBatchQueueJobItemRecord ON pBatchQueueJobItemRecord.BatchQueuePagePki = SqlBatchQ.' + @BatchQueuePagePkName + ' AND pBatchQueueJobItemRecord.BatchQueueJobItemID =''' + CAST(@BatchQueueJobItemID AS NVARCHAR(50)) + '''
		WHERE pBatchQueueJobItemRecord.BatchQueuePagePki IS NULL '

	DECLARE @tmpBatchQueuePagePkiName nvarchar(40),
		@tmpBatchQueueJobItemID UNIQUEIDENTIFIER,
		@BatchQueueIndex int, 
		@BatchQueueRowCount int

	SET @BatchQueueIndex = 1

		SET NOCOUNT ON
		BEGIN
			 
			SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			 pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
			  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
			  pBatchQueuePageType.BatchQueuePagePkID, pBatchQueueJobItem.BatchQueueJobItemID
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
										
				SELECT @tmpBatchQueuePagePkiName = BatchQueuePagePkID, @tmpBatchQueueJobItemID = BatchQueueJobItemID 
					FROM #BatchQueueDep WHERE BatchQueueIndex = @BatchQueueIndex	
					
						SET @SQLString = @SQLString + ' AND EXISTS (SELECT * FROM pBatchQueueJobItemRecord ' +
							' WHERE BatchQueuePagePki = SqlBatchQ.' + @tmpBatchQueuePagePkiName + ' AND BatchQueueJobItemId = ''' + CAST(@tmpBatchQueueJobItemID AS NVARCHAR(50)) + ''')'
				
				
				SET @BatchQueueIndex = @BatchQueueIndex + 1
			END
	
			DROP TABLE #BatchQueueDep

		SET NOCOUNT OFF
		END	
END	

BEGIN						
	EXEC (@SQLString + ' ORDER BY [YEAR], [Season] ') 					
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09735', GetDate())
GO
