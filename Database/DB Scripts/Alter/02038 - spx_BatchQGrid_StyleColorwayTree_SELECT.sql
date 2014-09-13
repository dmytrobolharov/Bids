IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT] (
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER = NULL
)
AS 


DECLARE 
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX)


--** Get StyleTable
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
AND BatchQueueJobSeq = 4

CREATE TABLE #bq001_st(
	ROWID INT IDENTITY(1,1),
	StyleID  UNIQUEIDENTIFIER, 
	StyleNo  NVARCHAR(200),
	ImagePath NVARCHAR(200),
	BatchQueueIcon NVARCHAR(200)  
)


SET @sySQL = 'INSERT INTO #bq001_st(StyleID, StyleNo, ImagePath) 
SELECT b.StyleID , b.StyleNo  
, ''<img src="../System/Control/ImageStream.ashx?S=050&V='''''' + 
	CAST(b.DesignSketchVersion AS NVARCHAR(5)) + ''''''&IID='''''' + 
	CAST(b.DesignSketchID AS NVARCHAR(40)) + ''''''" \>'' as  ImagePath
FROM ' + @syBatchQueueJobTable + ' a 
	INNER JOIN dbo.pStyleHeader  b ON a.StyleID	 =  b.StyleID '
	
EXEC sp_executesql @sySQL	


DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@tmpStyleID UNIQUEIDENTIFIER

SELECT @TOTAL  =  COUNT(*) FROM #bq001_st
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 
	SELECT @tmpStyleID = StyleID FROM #bq001_st WHERE ROWID = @ROWID 

	IF NOT EXISTS ( SELECT * FROM dbo.pBatchQueueStyleMaterialColorTmp WHERE BatchQueueJobID = @BatchQueueJobID AND StyleID = @tmpStyleID )
	BEGIN
		IF @tmpStyleID = @StyleID 
			UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_blue.gif'  WHERE ROWID = @ROWID
		ELSE 
			UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_gray.gif'  WHERE ROWID = @ROWID
	END
	ELSE IF EXISTS ( SELECT * FROM dbo.pBatchQueueStyleMaterialColorTmp  WHERE BatchQueueJobID = @BatchQueueJobID  AND Reviewed = 1  AND StyleID = @tmpStyleID	)
		UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_green.gif'  WHERE ROWID = @ROWID
	ELSE 
		UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_blue.gif'  WHERE ROWID = @ROWID

	SET @ROWID = @ROWID  + 1 
END 
	

SELECT c.Description + ' (' + c.StyleNo  + ') ' AS StyleDescription, c.StyleNo AS StyleTooltip, 
	c.StyleID, a.BatchQueueIcon
FROM #bq001_st a
	INNER JOIN dbo.pStyleHeader c ON c.StyleID  = a.StyleID 




DROP TABLE #bq001_st 

go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02038'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02038', GetDate())

END	
GO
	
		



