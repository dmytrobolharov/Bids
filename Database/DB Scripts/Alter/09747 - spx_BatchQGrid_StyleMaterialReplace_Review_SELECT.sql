/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT]    Script Date: 24.02.2015 11:50:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT]    Script Date: 24.02.2015 11:50:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplace_Review_SELECT](
	@BatchQueuePagePkName nVARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable nVARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	,
	@ReturnSQLString INT = 0
)
AS 
BEGIN

DECLARE @MaterialID  UNIQUEIDENTIFIER


--** Get MaterialID to replace with 
SELECT @MaterialID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4


IF @MaterialID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE  #style(
		StyleID UNIQUEIDENTIFIER
	)

	INSERT INTO #style (StyleID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3


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


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09747', GetDate())
GO
