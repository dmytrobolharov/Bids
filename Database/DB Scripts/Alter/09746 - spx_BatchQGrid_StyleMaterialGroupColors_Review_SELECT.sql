/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT]    Script Date: 23.02.2015 17:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT]    Script Date: 23.02.2015 17:00:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


	
CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialCoreID UNIQUEIDENTIFIER
	
	
--** Get SeasonYearID
SELECT @SeasonYearID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 1



--** Get MaterialCoreID
SELECT @MaterialCoreID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 2


IF @SeasonYearID IS NOT NULL  AND @MaterialCoreID IS NOT NULL
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
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4



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
	DELETE FROM pBatchQueueStyleMaterialCoreColorTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND ColorCode + '//' + ColorName NOT IN  ( 
		SELECT ColorCode + '//' + ColorName FROM #color
	)

	--** Add colors
	INSERT INTO  pBatchQueueStyleMaterialCoreColorTmp
	( StyleMaterialCoreColorID , BatchQueueJobId, ColorCode, ColorName) 
	SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
	FROM #color
	WHERE ColorCode  + '//' + ColorName NOT IN (
		SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialCoreColorTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #color
	
	--** Default selection of colors
	UPDATE pBatchQueueStyleMaterialCoreColorTmp 
	SET MaterialCoreColorID = e.MaterialCoreColorID
	FROM pBatchQueueStyleMaterialCoreColorTmp a
		INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
		INNER JOIN pMaterialCoreColor e ON e.ColorPaletteID =  c.ColorPaletteID 
			AND e.MaterialCoreID = @MaterialCoreID
	WHERE a.BatchQueueJobId = @BatchQueueJobId
		AND  a.MaterialCoreColorID IS null
			
	
			
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialCoreID AS MaterialCoreID
	FROM pBatchQueueStyleMaterialCoreColorTmp a WITH(NOLOCK)
	WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialCoreID AS MaterialCoreID
	FROM pBatchQueueStyleMaterialCoreColorTmp a WITH(NOLOCK)
	WHERE 1 = 2 





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09746', GetDate())
GO
