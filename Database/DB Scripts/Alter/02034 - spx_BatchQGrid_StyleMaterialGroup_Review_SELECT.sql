IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroup_Review_SELECT](
	@BatchQueuePagePkName VARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable VARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	
)
AS 



DECLARE 
	@tmpBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MaterialCoreID  UNIQUEIDENTIFIER


--** Get MaterialCoreID
SELECT @tmpBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialCoreID = MaterialCoreID FROM ' + @tmpBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialCoreID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialCoreID = @MaterialCoreID OUTPUT



IF @MaterialCoreID IS NOT NULL
BEGIN 


	--** Get Styles 
	CREATE TABLE  #bq_style(
		StyleID UNIQUEIDENTIFIER
	)
	CREATE TABLE  #bq_coreItem(
		MaterialCoreItemID UNIQUEIDENTIFIER
	)	

	--** Style table 
	SELECT @tmpBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 4

	SET @sySQL = 'INSERT INTO #bq_style (StyleID) SELECT StyleID  FROM ' + @tmpBatchQueueJobTable 
	PRINT @sySQL 
	EXECUTE sp_executesql @sySQL


	--** MaterialCoreItem table 
	SELECT @tmpBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #bq_coreItem (MaterialCoreItemID) SELECT MaterialCoreItemID FROM ' + @tmpBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


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


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02034'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02034', GetDate())

END	
GO