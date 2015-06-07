/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT]    Script Date: 23.02.2015 16:56:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT]    Script Date: 23.02.2015 16:56:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT](
	@BatchQueuePagePkName nVARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable nVARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	
)
AS 



DECLARE	@MaterialCoreID  UNIQUEIDENTIFIER


SELECT @MaterialCoreID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 2



IF @MaterialCoreID IS NOT NULL
BEGIN 


	--** Get Styles 
	CREATE TABLE  #bq_style(
		StyleID UNIQUEIDENTIFIER
	)
	CREATE TABLE  #bq_coreItem(
		MaterialCoreItemID UNIQUEIDENTIFIER
	)	

	INSERT INTO #bq_style (StyleID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4

	INSERT INTO #bq_coreItem (MaterialCoreItemID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3


	--** Remove styles not selected
	DELETE FROM pBatchQueueStyleMaterialCoreItemTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND StyleID NOT IN  ( SELECT StyleID FROM #bq_style)

	--** Remove MaterialCoreItems not selected
	DELETE FROM pBatchQueueStyleMaterialCoreItemTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND MaterialCoreItemID NOT IN  ( SELECT MaterialCoreItemID FROM #bq_coreItem)


	--** Add styles selected
	INSERT INTO  pBatchQueueStyleMaterialCoreItemTmp
	(  BatchQueueStyleMaterialCoreItemTmpID , BatchQueueJobId, StyleID, MaterialCoreItemID ) 
	SELECT NEWID(), @BatchQueueJobId, a.StyleID, b.MaterialCoreItemID
	FROM #bq_style a
		CROSS JOIN #bq_coreItem b
		LEFT OUTER JOIN pBatchQueueStyleMaterialCoreItemTmp c ON c.StyleID = a.StyleID AND c.MaterialCoreItemID =  b.MaterialCoreItemID
	WHERE c.StyleID IS NULL  AND c.MaterialCoreItemID IS NULL 
	
	

	SELECT DISTINCT a.StyleID, b.StyleNo, b.Description, b.CustomField14
	FROM #bq_style a 
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	
	
	
	DROP TABLE #bq_style
	DROP TABLE #bq_coreItem

	--SELECT DISTINCT a.StyleID, b.StyleNo, b.Description
	--FROM pBatchQueueStyleMaterialCoreItemTmp a WITH(NOLOCK)
	--	INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	--WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT DISTINCT a.StyleID, b.StyleNo, b.Description, b.CustomField14
	FROM pBatchQueueStyleMaterialCoreItemTmp a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	WHERE 1 = 2
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09745', GetDate())
GO
