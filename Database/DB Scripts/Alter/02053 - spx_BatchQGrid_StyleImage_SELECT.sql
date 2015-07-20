IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleImage_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleImage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleImage_SELECT]
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
	
	--** Get user id, check access
	DECLARE @TeamID UNIQUEIDENTIFIER
	SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
	IF @TeamID IS NOT NULL
	BEGIN
		SET @SQLString = @SQLString + ' AND StyleType IN (SELECT StyleTypeID FROM sAccessStyleFolder WHERE ( AccessRoleId =3 OR AccessModify = 1 )  
		AND TeamId = ''' + CAST(@TeamID AS NVARCHAR(40)) + ''' ) '
	END 

	
BEGIN						
	IF @ReturnSQLString = 0 
		EXEC (@SQLString) 					
	ELSE 
		SELECT @SQLString AS sqlString
END



go	


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02053'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02053', GetDate())
END	
GO