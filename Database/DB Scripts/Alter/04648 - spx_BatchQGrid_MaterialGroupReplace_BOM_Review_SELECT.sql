
/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_MaterialGroupReplace_BOM_Review_SELECT]    Script Date: 12/18/2012 13:57:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_MaterialGroupReplace_BOM_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_MaterialGroupReplace_BOM_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_MaterialGroupReplace_BOM_Review_SELECT]    Script Date: 12/18/2012 13:57:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_MaterialGroupReplace_BOM_Review_SELECT](
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




	--** Get BOM pages
	CREATE TABLE #BOMDimension(
		StyleBOMDimensionID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 4

	SET @sySQL = 'INSERT INTO #BOMDimension (StyleBOMDimensionID) SELECT StyleBOMDimensionID FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


	SELECT a.* FROM vwx_BatchQPage_DimensionalBOM_SEL a WITH(NOLOCK)
	INNER JOIN #BOMDimension b WITH(NOLOCK) ON a.StyleBOMDimensionID = b.StyleBOMDimensionID 
	
	DROP TABLE #BOMDimension



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04648', GetDate())
GO


