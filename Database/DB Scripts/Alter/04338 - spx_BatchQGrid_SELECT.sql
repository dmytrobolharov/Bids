IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_SELECT]
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
	DECLARE @GridSql NVARCHAR(MAX)
	
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,' SELECT  * FROM vwx_BatchQ_ColorFolder_SEL WHERE',' AND ')
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,' SELECT  * FROM vwx_BatchQ_ColorFolder_SEL',' ')
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,'ColorSubFolder2','c.Season')
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,'ColorSubFolder3','c.Year')
	
	SET @GridSql = 'SELECT    DISTINCT a.ColorFolderID, a.ColorFolderDescription, a.ColorSubFolder1,
           a.ColorSubFolder4, a.ColorSubFolder5, a.ColorSubFolder6, a.ColorSubFolder7, 
           a.ColorSubFolder8, a.ColorSubFolder9, a.CUser, a.CDate, a.MUser, a.MDate, a.MChange, a.Active,
           a.StyleColorway, a.SystemServerStorageID, a.ColorTypeID, a.ColorTypeSort
	FROM       dbo.pColorFolder a
		LEFT join pColorFolderSeasonYear b on a.ColorFolderID = b.ColorFolderID
		LEFT join pSeasonYear c on b.SeasonYearID = c.SeasonYearID 
	WHERE     a.Active = 1' + @BatchQueueGridSql
	
	SET @SQLString = 'SELECT * FROM (' + @GridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM ' +  @BatchQueueJobTable + ' WHERE ' + @BatchQueuePagePkName + ' = SqlBatchQ.' + @BatchQueuePagePkName + ')'



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
	IF @ReturnSQLString = 0 
		EXEC (@SQLString) 					
	ELSE 
		SELECT @SQLString AS sqlString
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04338', GetDate())
GO
