/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT]    Script Date: 24.02.2015 12:08:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT]    Script Date: 24.02.2015 12:08:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 



DECLARE 
	@MaterialID  UNIQUEIDENTIFIER,
	@MaterialReplaceWithID  UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
	

--** Get SeasonYearID
SELECT @SeasonYearID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 1

--** Get MaterialID
SELECT @MaterialID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 2

--** Get MaterialReplaceWithID
SELECT @MaterialReplaceWithID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4




IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL AND @MaterialReplaceWithID IS NOT NULL 
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


	CREATE TABLE #color (
		ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
	)
	
	--** Get all styleColors
	
	INSERT INTO #color (ColorCode, ColorName)
	SELECT DISTINCT d.ColorCode, d.ColorName
	FROM #style a
		INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
		INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
		INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
		INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
	WHERE c.SeasonYearID = @SeasonYearID
		AND LEN(ISNULL(d.ColorCode,'') ) > 0 
		AND LEN(ISNULL(d.ColorName,'')) > 0


	DROP TABLE  #style


	--** Remove colors
	DELETE FROM pBatchQueueStyleMaterialColorTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND ColorCode + '//' + ColorName NOT IN  ( 
		SELECT ColorCode + '//' + ColorName FROM #color
	)

	--** Add colors
	INSERT INTO  pBatchQueueStyleMaterialColorTmp
	( StyleMaterialColorID , BatchQueueJobId, ColorCode, ColorName) 
	SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
	FROM #color
	WHERE ColorCode  + '//' + ColorName NOT IN (
		SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #color
	
	

	UPDATE dbo.pBatchQueueStyleMaterialColorTmp
	SET MaterialColorID = e.MaterialColorID
	FROM pBatchQueueStyleMaterialColorTmp a
		INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
		INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
			AND e.MaterialID = @MaterialReplaceWithID
		INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
			AND b.SeasonyearID = @SeasonyearID 
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND  a.MaterialColorID IS NULL
		
		
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialReplaceWithID  AS MaterialID
	FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
	WHERE a.BatchQueueJobID = @BatchQueueJobID
	

END
ELSE 
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialReplaceWithID  AS MaterialID
	FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
	WHERE 1 = 2
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09748', GetDate())
GO
