IF OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT] (
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER = NULL
)
AS 

CREATE TABLE #bq001_st(
	ROWID INT IDENTITY(1,1),
	StyleID  UNIQUEIDENTIFIER, 
	StyleNo  NVARCHAR(200),
	ImagePath NVARCHAR(200),
	BatchQueueIcon NVARCHAR(200)  
)

INSERT INTO #bq001_st(StyleID, StyleNo, ImagePath) 
SELECT style.StyleID, style.StyleNo,  
       dbo.fnx_GetStreamingImageHTML(style.DesignSketchID, style.DesignSketchVersion, 50, '')
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
INNER JOIN pStyleHeader style ON style.StyleID = rec.BatchQueuePagePki
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4

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

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10349', GetUTCDate())
GO
