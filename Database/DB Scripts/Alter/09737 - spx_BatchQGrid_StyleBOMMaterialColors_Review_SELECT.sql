/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleBOMMaterialColors_Review_SELECT]    Script Date: 24.02.2015 17:40:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleBOMMaterialColors_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleBOMMaterialColors_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleBOMMaterialColors_Review_SELECT]    Script Date: 24.02.2015 17:40:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleBOMMaterialColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE
	@MaterialID  UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@BatchQueueID UNIQUEIDENTIFIER,
	@MaterialColorID UNIQUEIDENTIFIER
	

SELECT @BatchQueueID = BatchQueueID 
FROM pBatchQueueJob
WHERE BatchQueueJobID = @BatchQueueJobID

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


IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE #BOMDimension(
		StyleBOMDimensionID UNIQUEIDENTIFIER
	)

	INSERT INTO #BOMDimension
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3


	CREATE TABLE #color (
		ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
	)
		
		--** Get all Colors of every BOM
	
	DECLARE @BOMDimensionCursor CURSOR
	DECLARE @CurrentBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @CurrentDimensionType UNIQUEIDENTIFIER
	DECLARE @CurrentBOMColorColumn nVARCHAR(200) = ''
	DECLARE @SQL NVARCHAR(MAX)
	
	SET @BOMDimensionCursor = CURSOR SCROLL
	FOR SELECT StyleBOMDimensionID FROM #BOMDimension
	
	OPEN @BOMDimensionCursor
	FETCH NEXT FROM @BOMDimensionCursor INTO @CurrentBOMDimensionID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SELECT @CurrentDimensionType = ItemDim1TypeId FROM pStyleBOMDimensionItem
		WHERE StyleBOMDimensionID = @CurrentBOMDimensionID
		
		-- Checking, which of pStyleBomDimensionItem item is the Colorway items
		DECLARE @ColorDimensionTypeID UNIQUEIDENTIFIER
		SELECT @ColorDimensionTypeID = DimTypeID
		FROM pStyleBOMDimType WHERE UPPER(RTRIM(LTRIM(DimTypeName)))='COLOR'
		
		IF @CurrentDimensionType = @ColorDimensionTypeID -- Color
		BEGIN
			SET @CurrentBOMColorColumn = 'ItemDim1Id'
		END
		ELSE
		BEGIN
			SELECT @CurrentDimensionType = ItemDim2TypeId FROM pStyleBOMDimensionItem
			WHERE StyleBOMDimensionID = @CurrentBOMDimensionID
			IF @CurrentDimensionType = @ColorDimensionTypeID
			BEGIN
				SET @CurrentBOMColorColumn = 'ItemDim2Id'
			END
			ELSE
			BEGIN
				SELECT @CurrentDimensionType = ItemDim3TypeId FROM pStyleBOMDimensionItem
				WHERE StyleBOMDimensionID = @CurrentBOMDimensionID
				IF @CurrentDimensionType = @ColorDimensionTypeID
				BEGIN
					SET @CurrentBOMColorColumn = 'ItemDim3Id'
				END
			END
		END
		
		IF @CurrentBOMColorColumn <> ''
		BEGIN
			SET @SQL = 'INSERT INTO #color(ColorCode, ColorName) 
			SELECT DISTINCT ColorCode, ColorName FROM pColorPalette 
			INNER JOIN pStyleColorway ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID 
			INNER JOIN pStyleBomDimensionItem ON pStyleColorway.StyleColorID = pStyleBOMDimensionItem.' + @CurrentBOMColorColumn + ' 
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = ''' + CAST(@CurrentBOMDimensionID AS nVARCHAR(50)) + '''
			AND ColorCode + ''\\'' + ColorName NOT IN (SELECT ColorCode + ''\\'' + ColorName FROM #color)'
			
			EXECUTE sp_executesql @SQL
			SET @SQL = ''
			SET @CurrentBOMColorColumn = ''
		END
		
		FETCH NEXT FROM @BOMDimensionCursor INTO @CurrentBOMDimensionID
	END

	DROP TABLE  #BOMDimension

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
		
		
	--** Check if there is onlyl 1 color available
	IF ( SELECT COUNT(*) FROM dbo.pMaterialColorSeasonYear 
	WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  ) = 1
	BEGIN
		
		SET @MaterialColorID = NULL
			
		SELECT @MaterialColorID = MaterialColorID 
		FROM dbo.pMaterialColorSeasonYear WITH(NOLOCK)
		WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  
		
		UPDATE pBatchQueueStyleMaterialColorTmp
		SET MaterialColorID = @MaterialColorID, Reviewed = 1
		WHERE BatchQueueJobId = @BatchQueueJobId
			AND ISNULL(Reviewed,0) = 0 
	
	END
	ELSE 
		--** Default color pitching
		UPDATE dbo.pBatchQueueStyleMaterialColorTmp
		SET MaterialColorID = e.MaterialColorID
		FROM pBatchQueueStyleMaterialColorTmp a
			INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
			INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
				AND e.MaterialID = @MaterialID
			INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
				AND b.SeasonyearID = @SeasonyearID 
		WHERE BatchQueueJobId = @BatchQueueJobId
			AND a.MaterialColorID IS NULL
			AND ISNULL(a.Reviewed,0) = 0
		
		
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
	FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
	WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
	FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
	WHERE 1 = 2 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09737', GetDate())
GO
