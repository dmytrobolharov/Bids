/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]    Script Date: 26.02.2015 17:07:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT]    Script Date: 26.02.2015 17:07:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleBOMMaterials_Review_SELECT](
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


DECLARE @MaterialID  UNIQUEIDENTIFIER


--** Get MaterialID
SELECT @MaterialID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 2



IF @MaterialID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE  #dbom(
		StyleBOMDimensionID UNIQUEIDENTIFIER
	)

	INSERT INTO #dbom (StyleBOMDimensionID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3

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
VALUES ('DB_Version', '6.1.0000', '09776', GetDate())
GO

