SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_SeasonYear_SELECT]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable varchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate datetime	
)
AS 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM ' +  @BatchQueueJobTable + ' WHERE ' + @BatchQueuePagePkName + ' = SqlBatchQ.' + @BatchQueuePagePkName + ')'

	DECLARE @tmpBatchQueueJobtable varchar(200),
		@tmpBatchQueuePagePkiName varchar(40),
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
	EXEC (@SQLString + ' ORDER BY [YEAR], [Season] ') 					
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01493', GetDate())
GO
	
	
		
