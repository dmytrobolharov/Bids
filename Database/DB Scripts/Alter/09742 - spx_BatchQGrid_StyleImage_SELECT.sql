/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleImage_SELECT]    Script Date: 2/13/2015 4:47:57 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleImage_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleImage_SELECT]    Script Date: 2/13/2015 4:47:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleImage_SELECT]
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
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM pBatchQueueJobItemRecord WHERE BatchQueuePagePki = SqlBatchQ.' + @BatchQueuePagePkName + ' AND BatchQueueJobItemId = ''' + CAST(@BatchQueueJobItemId AS NVARCHAR(50)) + ''')'



	DECLARE @tmpBatchQueueJobtable nvarchar(200),
		@tmpBatchQueuePagePkiName nvarchar(40),
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
										
				SELECT @tmpBatchQueueJobtable = BatchQueueJobTable, @tmpBatchQueuePagePkiName = BatchQueuePagePkID, @tmpBatchQueueJobItemID = BatchQueueJobItemID 
					FROM #BatchQueueDep WHERE BatchQueueIndex = @BatchQueueIndex	
					
						SET @SQLString = @SQLString + ' AND EXISTS (SELECT * FROM pBatchQueueJobItemRecord ' +
							' WHERE BatchQueuePagePki = SqlBatchQ.' + @tmpBatchQueuePagePkiName + ' AND BatchQueueJobItemId = ''' + CAST(@tmpBatchQueueJobItemID AS NVARCHAR(50)) + ''')'
				
				
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
		SET @SQLString = @SQLString + ' AND StyleType IN (SELECT ProductTypeId FROM fnx_Permissions_GetIntProductTypePermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 2) 
							WHERE ( PermissionRoleId =3 OR PermissionModify = 1 ) ) '
	END 

	
BEGIN						
	IF @ReturnSQLString = 0 
		EXEC (@SQLString) 					
	ELSE 
		SELECT @SQLString AS sqlString
END






GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09742', GetDate())
GO
