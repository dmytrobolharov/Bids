

/****** Object:  StoredProcedure [dbo].[spx_BatchQ_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQ_SELECT](
@TeamID UNIQUEIDENTIFIER = NULL
)
AS 


SELECT * FROM pBatchQueue

GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_DELETE]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_DELETE]
(
	 @BatchQueueJobID uniqueidentifier
	,@BatchQueueID uniqueidentifier

)
AS 

BEGIN
	DECLARE
		@BatchQueueJobTable varchar(200),
		@BatchQueueJobItemID uniqueidentifier
	
	DECLARE @BatchQueueIndex INT, @BatchQueueRowCount INT

	SET @BatchQueueIndex = 1

	SET NOCOUNT ON

	BEGIN	

		SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex, BatchQueueJobTable 		  
		INTO #BatchQueueJob      
		FROM pBatchQueueJobItem 
		WHERE BatchQueueJobID = @BatchQueueJobID 
		ORDER BY BatchQueueJobSeq ASC    
		
		SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueJob)

			WHILE @BatchQueueIndex <= @BatchQueueRowCount 
				BEGIN
											
					SELECT @BatchQueueJobTable = BatchQueueJobTable
						FROM #BatchQueueJob WHERE BatchQueueIndex = @BatchQueueIndex							
						
							EXEC('IF OBJECT_ID(''dbo.' + @BatchQueueJobTable + ''') IS NOT NULL   
							BEGIN DROP TABLE ' + @BatchQueueJobTable + ' END')  				  
					
							
					
					SET @BatchQueueIndex = @BatchQueueIndex + 1
				END
		
		DROP TABLE #BatchQueueJob 
		
		BEGIN
			DELETE FROM pBatchQueueJobItem WHERE BatchQueueJobID = @BatchQueueJobID 
			DELETE FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID 
		END
		
	SET NOCOUNT OFF
	END
END	
	
	

	
	
	
		
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_SELECT](
@TeamID UNIQUEIDENTIFIER 
)
AS 


SELECT pBatchQueueJob.BatchQueueJobID, pBatchQueueJob.BatchQueueID, pBatchQueueJob.BatchQueueJobDate, pBatchQueueJob.BatchQueueJobTeamID, 
      pBatchQueueJob.BatchQueueJobStatusID, pBatchQueueJob.BatchQueueJobCompleted, pBatchQueue.BatchQueueTypeID, pBatchQueue.BatchQueueName, 
      pBatchQueue.BatchQueueDesc, pBatchQueue.BatchQueueUrl, pBatchQueue.BatchQueueIcon
FROM  pBatchQueueJob INNER JOIN
      pBatchQueue ON pBatchQueueJob.BatchQueueID = pBatchQueue.BatchQueueID
WHERE  pBatchQueueJob.BatchQueueJobTeamID = @TeamID     
ORDER BY pBatchQueueJob.BatchQueueJobDate DESC

GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobDep_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJobDep_SELECT](
@BatchQueuePageID UNIQUEIDENTIFIER,
@BatchQueueJobID UNIQUEIDENTIFIER
)
AS 

SELECT pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
  pBatchQueuePageType.BatchQueuePagePkID
FROM pBatchQueuePageDep INNER JOIN
  pBatchQueueJobItem ON pBatchQueuePageDep.BatchQueuePageRelationID = pBatchQueueJobItem.BatchQueuePageID INNER JOIN
  pBatchQueuePage ON pBatchQueueJobItem.BatchQueuePageID = pBatchQueuePage.BatchQueuePageID INNER JOIN
  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
WHERE (pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID) AND 
  (pBatchQueuePageDep.BatchQueuePageID = @BatchQueuePageID)
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobItem_DELETE]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJobItem_DELETE]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePagePkID varchar(40),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueId uniqueidentifier,
	@CUser NVarChar(200),
	@CDate datetime
)
AS 

	
DECLARE @TempTableName varchar(200)
	
	SELECT @TempTableName = '__' + 
		REPLACE(CAST(@BatchQueueJobId AS VARCHAR(40)),'-','') 
		+ '_' +
		REPLACE(CAST(@BatchQueuePageId AS VARCHAR(40)),'-','');	
	
DECLARE @SQLCountString NVARCHAR(500);	
DECLARE @SQLString NVARCHAR(500);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @CountInt INT

	SET @SQLCountString = N'DELETE FROM dbo.' + @TempTableName + '  WHERE ' + @BatchQueuePagePkName + ' = @BatchQueuePagePkID AND BatchQueueJobItemId = @BatchQueueJobItemId'
	EXEC sp_executesql @SQLCountString, N'@BatchQueueJobItemId varchar(40), @BatchQueuePagePkID varchar(40)', @BatchQueueJobItemId, @BatchQueuePagePkID

	--IF @CountInt = 0
	--BEGIN
	--	SET @SQLString =N'INSERT INTO dbo.' + @TempTableName + ' 
	--										(' + @BatchQueuePagePkName + ', 
	--										BatchQueueJobId, 
	--										BatchQueueJobItemId,
	--										BatchQueuePageId,
	--										BatchQueueId,
	--										CUser,
	--										CDate)		
	--									VALUES 
	--										(@BatchQueuePagePkID,
	--										@BatchQueueJobId, 
	--										@BatchQueueJobItemId, 
	--										@BatchQueuePageId,
	--										@BatchQueueId,
	--										@CUser,
	--										@CDate)'
						
	--	SET @ParmDefinition = N'@BatchQueuePagePkID varchar(40),
	--							@BatchQueuePageID varchar(40),
	--							@BatchQueueJobId varchar(40),
	--							@BatchQueueJobItemId varchar(40),
	--							@BatchQueueId varchar(40),						
	--							@CUser NVarChar(200),
	--							@CDate datetime'
													

	--	EXEC sp_executesql @SQLString, @ParmDefinition,
	--									@BatchQueuePagePkID,
	--									@BatchQueuePageID,
	--									@BatchQueueJobId,
	--									@BatchQueueJobItemId,
	--									@BatchQueueId,						
	--									@CUser,
	--									@CDate

	--END



	
	
		
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobItem_INSERT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJobItem_INSERT]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePagePkID uniqueidentifier,
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueId uniqueidentifier,
	@CUser NVarChar(200),
	@CDate datetime
)
AS 

--DECLARE
--	@BatchQueuePagePkName varchar(200),
--	@BatchQueuePagePkID uniqueidentifier,
--	@BatchQueuePageID uniqueidentifier,
--	@BatchQueueJobId uniqueidentifier,
--	@BatchQueueJobItemId uniqueidentifier,
--	@BatchQueueId uniqueidentifier,
--	@CUser NVarChar(200),
--	@CDate datetime

--SELECT
--	@BatchQueuePagePkName='SeasonYearID',
--	@BatchQueuePagePkID='707e203b-11be-47ea-b60b-3a7c8d083c22',
--	@BatchQueuePageId='f2e871c3-db7b-e011-9848-005056c00008',
--	@BatchQueueJobItemId='476c2bee-b980-e011-bdd7-ed0068fd7da4',
--	@BatchQueueJobId='7f45c780-63c8-4bbf-88c2-ed8f5046685e',
--	@BatchQueueID='90000000-0000-0000-0000-000000000001',
--	@CUser=N'Daniel Pak',
--	@CDate='2011-05-17 15:45:59'

	
DECLARE @TempTableName varchar(200)
	
	SELECT @TempTableName = '__' + 
		REPLACE(CAST(@BatchQueueJobId AS VARCHAR(40)),'-','') 
		+ '_' +
		REPLACE(CAST(@BatchQueuePageId AS VARCHAR(40)),'-','');	
	
DECLARE @SQLCountString NVARCHAR(500);	
DECLARE @SQLString NVARCHAR(500);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @CountInt INT

	SET @SQLCountString = N'SELECT @cnt = COUNT(*) FROM dbo.' + @TempTableName + '  WHERE ' + @BatchQueuePagePkName + ' = @BatchQueuePagePkID'
	EXEC sp_executesql @SQLCountString, N'@BatchQueuePagePkID varchar(40), @cnt INT OUTPUT', @BatchQueuePagePkID, @cnt = @CountInt OUTPUT

	IF @CountInt = 0
	BEGIN
		SET @SQLString =N'INSERT INTO dbo.' + @TempTableName + ' 
											(' + @BatchQueuePagePkName + ', 
											BatchQueueJobId, 
											BatchQueueJobItemId,
											BatchQueuePageId,
											BatchQueueId,
											CUser,
											CDate)		
										VALUES 
											(@BatchQueuePagePkID,
											@BatchQueueJobId, 
											@BatchQueueJobItemId, 
											@BatchQueuePageId,
											@BatchQueueId,
											@CUser,
											@CDate)'
						
		SET @ParmDefinition = N'@BatchQueuePagePkID varchar(40),
								@BatchQueuePageID varchar(40),
								@BatchQueueJobId varchar(40),
								@BatchQueueJobItemId varchar(40),
								@BatchQueueId varchar(40),						
								@CUser NVarChar(200),
								@CDate datetime'
													

		EXEC sp_executesql @SQLString, @ParmDefinition,
										@BatchQueuePagePkID,
										@BatchQueuePageID,
										@BatchQueueJobId,
										@BatchQueueJobItemId,
										@BatchQueueId,						
										@CUser,
										@CDate

	END



	
	
		
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJobNew_INSERT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
		@BatchQueuePagePkiName varchar(200),
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

			WHILE @BatchQueueIndex <= @BatchQueueRowCount 
				BEGIN
											
					SELECT @BatchQueuePageID = BatchQueuePageID, @BatchQueuePagePkiName = BatchQueuePagePkID 
						FROM #BatchQueueJob WHERE BatchQueueIndex = @BatchQueueIndex	
						
					DECLARE @TempTableName varchar(200)						
						--Create temp table name
						SELECT @TempTableName = '__' + 
							REPLACE(CAST(@BatchQueueJobID AS VARCHAR(40)),'-','') + '_' + 
							REPLACE(CAST(@BatchQueuePageId AS VARCHAR(40)),'-','')						
			
					INSERT INTO pBatchQueueJobItem(BatchQueueJobID, BatchQueuePageID, BatchQueueJobSeq, BatchQueueJobTable)
						VALUES(@BatchQueueJobID, @BatchQueuePageID, @BatchQueueIndex, @TempTableName) 

						
						EXEC('IF OBJECT_ID(''dbo.' + @TempTableName + ''') IS NULL   
						BEGIN CREATE TABLE ' + @TempTableName + '
						 (
						 TempId [int] IDENTITY(1,1) NOT NULL,' +
						 @BatchQueuePagePkiName + ' UNIQUEIDENTIFIER NOT NULL,' +
						 @BatchQueuePagePkiName + '_TMP UNIQUEIDENTIFIER NULL,
						 BatchQueueJobId UNIQUEIDENTIFIER NULL,
						 BatchQueueJobItemId UNIQUEIDENTIFIER NULL,
						 BatchQueuePageId UNIQUEIDENTIFIER NULL,
						 BatchQueueId UNIQUEIDENTIFIER NULL,
						 CUser VARCHAR(200),
						 CDate DATETIME,
						 CONSTRAINT pk_' + @TempTableName + ' PRIMARY KEY (TempId)
						 )  END')  				  
					
					SET @BatchQueueIndex = @BatchQueueIndex + 1
				END
		
		DROP TABLE #BatchQueueJob 

	SET NOCOUNT OFF
	END
END	
	
	

	
	
	
		
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQPage_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQPage_SELECT](
@BatchQueuePageID UNIQUEIDENTIFIER,
@BatchQueueJobID UNIQUEIDENTIFIER
)
AS 

SELECT pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID, 
	  pBatchQueuePage.BatchQueuePageOrder, pBatchQueuePage.CUser, pBatchQueuePage.CDate, pBatchQueuePage.MUser, 
	  pBatchQueuePage.MDate, pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, 
	  pBatchQueuePageType.BatchQueuePageXmlSearch, pBatchQueuePageType.BatchQueuePageXmlForm, pBatchQueuePageType.BatchQueuePageXmlSelected,
	  pBatchQueuePageType.BatchQueuePageRecType, pBatchQueuePageType.BatchQueuePageRecMax,
	  pBatchQueuePageType.BatchQueuePageXmlGrid, pBatchQueuePageType.BatchQueuePageUrl, pBatchQueuePageType.BatchQueuePagePkID, 
	  pBatchQueueJobItem.BatchQueueJobItemID, pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, 
	  pBatchQueueJobItem.BatchQueueJobTable
FROM  pBatchQueuePage INNER JOIN
	  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID INNER JOIN
	  pBatchQueueJobItem ON pBatchQueuePage.BatchQueuePageID = pBatchQueueJobItem.BatchQueuePageID
WHERE pBatchQueuePage.BatchQueuePageID = @BatchQueuePageID AND 
		pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID 


GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQPageNav_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQPageNav_SELECT](
@BatchQueueID UNIQUEIDENTIFIER = NULL
)
AS 

SELECT '00000000-0000-0000-0000-000000000000' AS BatchQueuePageID,
	'00000000-0000-0000-0000-000000000000' AS BatchQueuePageTypeID,
	BatchQueueID,
	BatchQueueName AS BatchQueuePageTypeName,
	BatchQueueDesc AS BatchQueuePageTypeDesc,
	'BatchQ_Page.aspx' AS BatchQueuePageUrl,
	'' AS BatchQueuePageOrder
FROM pBatchQueue WHERE BatchQueueID = @BatchQueueID
UNION
SELECT pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID,  
      pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, pBatchQueuePageType.BatchQueuePageUrl,
      pBatchQueuePage.BatchQueuePageOrder
FROM pBatchQueuePage INNER JOIN
      pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
WHERE pBatchQueuePage.BatchQueueID = @BatchQueueID
ORDER BY 7



GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQStartPageUrl_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQStartPageUrl_SELECT](
@BatchQueueID UNIQUEIDENTIFIER 
)
AS 

SELECT TOP 1 pBatchQueuePageType.BatchQueuePageUrl, pBatchQueuePage.BatchQueueID
FROM pBatchQueuePage INNER JOIN
      pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
WHERE pBatchQueuePage.BatchQueueID = @BatchQueueID
ORDER BY pBatchQueuePage.BatchQueuePageOrder ASC

GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQType_SELECT]    Script Date: 05/31/2011 11:15:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQType_SELECT](
@TeamID UNIQUEIDENTIFIER = NULL
)
AS 


SELECT * FROM pBatchQueueType 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01482', GetDate())
GO

