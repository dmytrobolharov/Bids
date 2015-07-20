/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleImage_EXECUTE_QUEUE]    Script Date: 2/13/2015 5:20:20 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleImage_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_StyleImage_EXECUTE_QUEUE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleImage_EXECUTE_QUEUE]    Script Date: 2/13/2015 5:20:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleImage_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS


DECLARE 
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion INT,
	@MUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200), 
	@ColorName  NVARCHAR(200),
	@BatchQueueJobItemId UNIQUEIDENTIFIER


DECLARE @error INT 
SET @error = 0 


BEGIN TRAN 

	BEGIN TRY 

	SELECT @MUser = ISNULL(b.UserName,'') + ' '  +  ISNULL(b.LastName,''),
		@TeamID = b.TeamID
	FROM dbo.pBatchQueueJob a
		INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID = b.TeamID
	WHERE BatchQueueJobID = @BatchQueueJobID

	--** Get Image
	SELECT @syBatchQueueJobTable = BatchQueueJobTable, @BatchQueueJobItemId = BatchQueueJobItemID   
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

	SELECT @ImageID = BatchQueuePagePki  FROM pBatchQueueJobItemRecord WITH(NOLOCK) WHERE BatchQueueJobId = @BatchQueueJobId AND BatchQueueJobItemID = @BatchQueueJobItemId
	--SET @sySQL = 'SELECT @ImageID = ImageID  FROM ' + @syBatchQueueJobTable + ' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
	--SET @ParmDefinition = '@ImageID UNIQUEIDENTIFIER OUTPUT'
	--EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	--	@ImageID = @ImageID OUTPUT
			
	SELECT @ImageID = ImageID, @ImageVersion = Version FROM pImage WHERE ImageID = @ImageID 	

	--** get Pages
	CREATE TABLE #bq_pages (
		ROWID INT IDENTITY(1,1),
		WorkflowID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable = BatchQueueJobTable, @BatchQueueJobItemId = BatchQueueJobItemID  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

	INSERT INTO #bq_pages (WorkflowID)
	SELECT DISTINCT BatchQueuePagePki
	FROM pBatchQueueJobItemRecord
	WHERE BatchQueueJobID = @BatchQueueJobId AND BatchQueueJobItemID = @BatchQueueJobItemId

	--SET @sySQL = 'INSERT INTO #bq_pages (WorkflowID)
	--SELECT DISTINCT WorkflowID
	--FROM ' + @syBatchQueueJobTable + '
	--WHERE BatchQueueJobID = ''' + CAST(@BatchQueueJobId AS nVARCHAR(40)) + ''''

 --   EXECUTE	sp_executesql @sySQL


	--** Get Styles 
	SELECT @syBatchQueueJobTable = BatchQueueJobTable, @BatchQueueJobItemId = BatchQueueJobItemID  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3
	
	CREATE TABLE #bq_styles (
		ROWID INT IDENTITY(1,1),
		StyleID UNIQUEIDENTIFIER
	)

	INSERT INTO #bq_styles (StyleID)
	SELECT DISTINCT BatchQueuePagePki
	FROM pBatchQueueJobItemRecord
	WHERE BatchQueueJobID = @BatchQueueJobId AND BatchQueueJobItemID = @BatchQueueJobItemId

	--SET @sySQL = 'INSERT INTO #bq_styles (StyleID)
	--SELECT DISTINCT StyleID
	--FROM ' + @syBatchQueueJobTable + '
	--WHERE BatchQueueJobID = ''' + CAST(@BatchQueueJobId AS nVARCHAR(40)) + ''''

    EXECUTE	sp_executesql @sySQL

	DECLARE 
		@ROWID INT,
		@TOTAL INT,
		@StyleID UNIQUEIDENTIFIER,
		@PageID UNIQUEIDENTIFIER,
		@PAGEROWID INT,
		@PAGETOTAL INT
		
	SELECT @TOTAL = COUNT(*) FROM #bq_styles
	SET @ROWID  = 1 


	WHILE @ROWID <= @TOTAL 
	BEGIN 
		SELECT @StyleID = StyleID FROM #bq_styles  WHERE ROWID =  @ROWID
			
		SET @PAGEROWID =1 
		SELECT @PAGETOTAL = COUNT(*) FROM #bq_pages
		
		WHILE @PAGEROWID <= @PAGETOTAL
		BEGIN 
			SELECT @PageID = WorkflowID
			FROM #bq_pages WHERE ROWID = @PAGEROWID
			

			IF @PageID = '40000000-0000-0000-0000-000000000000'
			BEGIN
				UPDATE pStyleHeader SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion, MUser = @MUser, MDate = @MDate  
				WHERE StyleID = @StyleID 
			END
			ELSE IF @PageID = '40000000-0000-0000-0000-000000000005'
			BEGIN
			
				UPDATE pStyleHeader SET SpecSketchID1 = @ImageID, SpecSketchVersion1 = @ImageVersion, MUser = @MUser, MDate = @MDate  
				WHERE StyleID = @StyleID 
				
				--UPDATE pStyleImage SET SpecSketchID1 = @ImageID, SpecSketchVersion1 = @ImageVersion WHERE StyleID = @StyleID 
				EXECUTE spx_StyleImageDevelopmentSpec_Linked_UPDATE 
					@StyleId=@StyleId,
					@StyleSet=1,@WorkflowID='40000000-0000-0000-0000-000000000005',
					@ImageID=@ImageID,
					@ImageVersion=@ImageVersion,
					@ModifiedBy  = NULL,
					@ModifiedDate=@MDate
				
			END
			ELSE IF @PageID = '40000000-0000-0000-0000-000000000006'
			BEGIN
				INSERT INTO pStyleImageItem(StyleImageItemMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked)
				VALUES(newid(), @PageID, @StyleID, 1, @ImageID, @ImageVersion, @MUser, @MDate, @MUser, @MDate, 0)     
			END
								
			SET @PAGEROWID  = @PAGEROWID  +1 
		END 
		
		SET @ROWID = @ROWID + 1 
	END 


	DROP TABLE #bq_pages
	DROP TABLE #bq_styles


END TRY
BEGIN CATCH 
	set @error = 1 
END CATCH 

IF @error = 0
BEGIN
	COMMIT TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID

END
ELSE	
BEGIN
	ROLLBACK TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '30000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID
END 




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09759', GetDate())
GO
