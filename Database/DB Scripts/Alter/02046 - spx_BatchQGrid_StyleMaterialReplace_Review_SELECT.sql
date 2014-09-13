IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT](
	@BatchQueuePagePkName VARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable VARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	,
	@ReturnSQLString INT = 0
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MaterialID  UNIQUEIDENTIFIER


--** Get MaterialID to replace with 
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 4


SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT


IF @MaterialID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE  #style(
		StyleID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


	--** Remove styles not selected
	DELETE FROM pBatchQueueStyleMaterialTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND StyleID NOT IN  ( SELECT StyleID FROM #style)


	--** Add styles selected
	INSERT INTO  pBatchQueueStyleMaterialTmp
	( StyleMaterialID , BatchQueueJobId, StyleID, MaterialID ) 
	SELECT NEWID(), @BatchQueueJobId, StyleID, @MaterialID
	FROM #style 
	WHERE StyleID NOT IN (
		SELECT StyleID FROM pBatchQueueStyleMaterialTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #style

	SELECT a.*, b.StyleNo, b.Description, b.CustomField14 
	FROM pBatchQueueStyleMaterialTmp a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT a.*, b.StyleNo, b.Description, b.CustomField14 
	FROM pBatchQueueStyleMaterialTmp a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	WHERE 1 = 2 



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02046'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02046', GetDate())
END
GO