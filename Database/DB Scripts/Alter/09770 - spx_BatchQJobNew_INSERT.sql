/****** Object:  StoredProcedure [dbo].[spx_BatchQJobNew_INSERT]    Script Date: 2/13/2015 5:45:08 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJobNew_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobNew_INSERT]    Script Date: 2/13/2015 5:45:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJobNew_INSERT]
(
	 @BatchQueueJobID uniqueidentifier
	,@BatchQueueID uniqueidentifier
	,@BatchQueueJobDate datetime
	,@BatchQueueJobTeamID uniqueidentifier

)
AS 

BEGIN
	INSERT INTO pBatchQueueJob
			(BatchQueueJobID 
			,BatchQueueID 
			,BatchQueueJobDate 
			,BatchQueueJobTeamID)
     VALUES
			(@BatchQueueJobID 
			,@BatchQueueID 
			,@BatchQueueJobDate 
			,@BatchQueueJobTeamID)
END

BEGIN
	DECLARE
		@BatchQueueJobStatusID uniqueidentifier,
		@BatchQueueJobCompleted int,
		@BatchQueuePagePkiName nvarchar(200),
		@BatchQueuePageID uniqueidentifier,
		@BatchQueueTransId uniqueidentifier,
		@CUser NVarChar(200),
		@CDate datetime

	
--SELECT * FROM #BatchQueueJob	
--	DROP TABLE #BatchQueueJob	
	
DECLARE @BatchQueueIndex INT, @BatchQueueRowCount INT

SET @BatchQueueIndex = 1

	SET NOCOUNT ON

	BEGIN

		SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			  pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID, 
			  pBatchQueuePage.BatchQueuePageOrder, NULL AS BatchQueueJobSeq,
			  pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, pBatchQueuePageType.BatchQueuePagePkID, 
			  pBatchQueuePageType.BatchQueuePageXmlSearch, pBatchQueuePageType.BatchQueuePageXmlForm, pBatchQueuePageType.BatchQueuePageXmlGrid, 
			  pBatchQueuePageType.BatchQueuePageUrl
		INTO #BatchQueueJob      
		FROM pBatchQueuePage INNER JOIN
			  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
		WHERE pBatchQueuePage.BatchQueueID = @BatchQueueID 
		ORDER BY pBatchQueuePage.BatchQueuePageOrder ASC    
		
		SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueJob)

			--WHILE @BatchQueueIndex <= @BatchQueueRowCount 
			--	BEGIN
											
			--		SELECT @BatchQueuePageID = BatchQueuePageID, @BatchQueuePagePkiName = BatchQueuePagePkID 
			--			FROM #BatchQueueJob WHERE BatchQueueIndex = @BatchQueueIndex	
						
			--		DECLARE @TempTableName nvarchar(200)						
			--			--Create temp table name
			--			SELECT @TempTableName = '__' + 
			--				REPLACE(CAST(@BatchQueueJobID AS nVARCHAR(40)),'-','') + '_' + 
			--				REPLACE(CAST(@BatchQueuePageId AS nVARCHAR(40)),'-','')						
			
			--		INSERT INTO pBatchQueueJobItem(BatchQueueJobID, BatchQueuePageID, BatchQueueJobSeq, BatchQueueJobTable)
			--			VALUES(@BatchQueueJobID, @BatchQueuePageID, @BatchQueueIndex, @TempTableName) 

						
			--			EXEC('IF OBJECT_ID(''dbo.' + @TempTableName + ''') IS NULL   
			--			BEGIN CREATE TABLE ' + @TempTableName + '
			--			 (
			--			 TempId [int] IDENTITY(1,1) NOT NULL,' +
			--			 @BatchQueuePagePkiName + ' UNIQUEIDENTIFIER NOT NULL,' +
			--			 @BatchQueuePagePkiName + '_TMP UNIQUEIDENTIFIER NULL,
			--			 BatchQueueJobId UNIQUEIDENTIFIER NULL,
			--			 BatchQueueJobItemId UNIQUEIDENTIFIER NULL,
			--			 BatchQueuePageId UNIQUEIDENTIFIER NULL,
			--			 BatchQueueId UNIQUEIDENTIFIER NULL,
			--			 CUser nVARCHAR(200),
			--			 CDate DATETIME,
			--			 CONSTRAINT pk_' + @TempTableName + ' PRIMARY KEY (TempId)
			--			 )  END')  				  
					
			--		SET @BatchQueueIndex = @BatchQueueIndex + 1
			--	END

			WHILE @BatchQueueIndex <= @BatchQueueRowCount 
			BEGIN
											
				SELECT @BatchQueuePageID = BatchQueuePageID, @BatchQueuePagePkiName = BatchQueuePagePkID 
					FROM #BatchQueueJob WHERE BatchQueueIndex = @BatchQueueIndex	
						
				DECLARE @TempTableName nvarchar(200)						
					--Create temp table name
					SELECT @TempTableName = '__' + 
						REPLACE(CAST(@BatchQueueJobID AS nVARCHAR(40)),'-','') + '_' + 
						REPLACE(CAST(@BatchQueuePageId AS nVARCHAR(40)),'-','')						
			
				INSERT INTO pBatchQueueJobItem(BatchQueueJobID, BatchQueuePageID, BatchQueueJobSeq, BatchQueueJobTable
					)
				VALUES(@BatchQueueJobID, @BatchQueuePageID, @BatchQueueIndex, @TempTableName
					) 

						
					--EXEC('IF OBJECT_ID(''dbo.' + @TempTableName + ''') IS NULL   
					--BEGIN CREATE TABLE ' + @TempTableName + '
					--	(
					--	TempId [int] IDENTITY(1,1) NOT NULL,' +
					--	*@BatchQueuePagePkiName + ' UNIQUEIDENTIFIER NOT NULL,' +
					--	*@BatchQueuePagePkiName + '_TMP UNIQUEIDENTIFIER NULL,
					--	BatchQueueJobId UNIQUEIDENTIFIER NULL,
					--	BatchQueueJobItemId UNIQUEIDENTIFIER NULL,
					--	BatchQueuePageId UNIQUEIDENTIFIER NULL,
					--	*BatchQueueId UNIQUEIDENTIFIER NULL,
					--	*CUser nVARCHAR(200),
					--	*CDate DATETIME,
					--	CONSTRAINT pk_' + @TempTableName + ' PRIMARY KEY (TempId)
					--	)  END')  				  
					
				SET @BatchQueueIndex = @BatchQueueIndex + 1
			END
		
		DROP TABLE #BatchQueueJob 

	SET NOCOUNT OFF
	END
END	
	
	

	
	


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09770', GetDate())
GO
