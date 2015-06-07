/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE]    Script Date: 24.02.2015 15:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE]    Script Date: 24.02.2015 15:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS
BEGIN

DECLARE @error INT 
SET @error = 0 


BEGIN TRAN 

BEGIN TRY 

	DECLARE @MaterialID UNIQUEIDENTIFIER
		
	--** Get MaterialID
	SELECT @MaterialID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 2

	--** Get Styles 
	CREATE TABLE #tmp24saaStyle(	
		StyleID UNIQUEIDENTIFIER
	)

	INSERT INTO #tmp24saaStyle (StyleID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3
	
	--** Get Colors 
	CREATE TABLE #tmpColor2142(
		ROWID INT IDENTITY(1,1),
		ColorCode NVARCHAR(200),
		ColorName NVARCHAR(200),
		MaterialColorID UNIQUEIDENTIFIER
	)
	
	INSERT INTO  #tmpColor2142 (ColorCode, ColorName, MaterialColorID)
	SELECT ColorCode, ColorName, MaterialColorID
	FROM pBatchQueueStyleMaterialColorTmp
	WHERE BatchQueueJobId = @BatchQueueJobId


	DECLARE
		@TOTAL INT,
		@ROWID INT,
		@ColorCode NVARCHAR(200),
		@ColorName NVARCHAR(200),
		@MaterialColorID UNIQUEIDENTIFIER
		
	
	SET @ROWID = 1 
	SELECT @TOTAL = COUNT(*) FROM #tmpColor2142
	
	WHILE @ROWID  <= @TOTAL 
	BEGIN
		SELECT @ColorCode = ColorCode, @ColorName = ColorName, @MaterialColorID = MaterialColorID
		FROM #tmpColor2142 WHERE ROWID = @ROWID 
	
		
		UPDATE pStyleColorwayItem 
		SET MaterialColorID = @MaterialColorID
		FROM dbo.pStyleColorwayItem a
			INNER JOIN dbo.pStyleColorway b ON a.StyleColorID = b.StyleColorID 
			INNER JOIN #tmp24saaStyle c ON c.StyleID =  a.StyleID
			INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  b.ColorPaletteID
			INNER JOIN dbo.pStyleMaterials e ON e.StyleMaterialID = a.StyleMaterialID
		WHERE d.ColorCode = @ColorCode  AND d.ColorName = @ColorName
			AND e.MaterialID = @MaterialID
		
	
		SET @ROWID = @ROWID + 1 
	END
	

	DROP TABLE #tmp24saaStyle
	DROP TABLE #tmpColor2142	
	
END TRY
BEGIN CATCH 
	set @error = 1 
END CATCH 

IF @error = 0
BEGIN
	COMMIT TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID

END
ELSE	
BEGIN
	ROLLBACK TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '30000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID
END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09760', GetDate())
GO
