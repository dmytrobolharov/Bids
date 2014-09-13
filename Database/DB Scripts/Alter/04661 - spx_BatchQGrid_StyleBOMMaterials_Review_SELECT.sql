/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]    Script Date: 12/17/2012 16:43:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]    Script Date: 12/17/2012 16:43:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT](
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
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MaterialID  UNIQUEIDENTIFIER


--** Get MaterialID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT



IF @MaterialID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE  #dbom(
		StyleBOMDimensionID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #dbom (StyleBOMDimensionID) SELECT StyleBOMDimensionID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


	--** Remove styles not selected
	DELETE FROM pBatchQueueStyleMaterialTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND StyleBOMDimensionID NOT IN  ( SELECT StyleBOMDimensionID FROM #dbom)

	--** Add styles selected
	INSERT INTO  pBatchQueueStyleMaterialTmp
	( StyleMaterialID , BatchQueueJobId, StyleBOMDimensionID, MaterialID, Colorway ) 
	SELECT NEWID(), @BatchQueueJobId, StyleBOMDimensionID, @MaterialID,  1   
	FROM #dbom 
	WHERE StyleBOMDimensionID NOT IN (
		SELECT StyleID FROM pBatchQueueStyleMaterialTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #dbom

	SELECT a.*, b.StyleNo, b.Description , b.WorkFlowItemName, b.CustomField14
	FROM pBatchQueueStyleMaterialTmp a WITH(NOLOCK)
		INNER JOIN dbo.vwx_BatchQPage_DimensionalBOM_SEL b WITH(NOLOCK) ON a.StyleBOMDimensionID = b.StyleBOMDimensionID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT a.*, b.StyleNo, b.Description , b.WorkFlowItemName, b.CustomField14
	FROM pBatchQueueStyleMaterialTmp a WITH(NOLOCK)
		INNER JOIN dbo.vwx_BatchQPage_DimensionalBOM_SEL b WITH(NOLOCK) ON a.StyleBOMDimensionID = b.StyleBOMDimensionID 
	WHERE 1 = 2


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04661', GetDate())
GO
