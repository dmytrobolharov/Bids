/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_BOMMaterialGroupColors_Review_SELECT]    Script Date: 03/18/2014 13:12:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_BOMMaterialGroupColors_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_BOMMaterialGroupColors_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_BOMMaterialGroupColors_Review_SELECT]    Script Date: 03/18/2014 13:12:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



	
CREATE PROCEDURE [dbo].[spx_BatchQGrid_BOMMaterialGroupColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialCoreID UNIQUEIDENTIFIER
	
	
--** Get SeasonYearID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT



--** Get MaterialCoreID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialCoreID = MaterialCoreID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialCoreID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialCoreID = @MaterialCoreID OUTPUT


IF @SeasonYearID IS NOT NULL  AND @MaterialCoreID IS NOT NULL
BEGIN 

	--** Get Styles 
	CREATE TABLE #BOMDimension(
		StyleBOMDimensionID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 4

	SET @sySQL = 'INSERT INTO #BOMDimension (StyleBOMDimensionID) SELECT StyleBOMDimensionID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL
	SET @sySQL = ''


	CREATE TABLE #color (
		ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
	)
	
	
	
	--** Get all Colors of every BOM
	
	DECLARE @BOMDimensionCursor CURSOR
	DECLARE @CurrentBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @CurrentDimensionType UNIQUEIDENTIFIER
	DECLARE @CurrentBOMColorColumn VARCHAR(200) = ''
	
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
			SET @sySQL = 'INSERT INTO #color(ColorCode, ColorName) 
			SELECT DISTINCT ColorCode, ColorName FROM pColorPalette 
			INNER JOIN pStyleColorway ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID 
			INNER JOIN pStyleBomDimensionItem ON pStyleColorway.StyleColorID = pStyleBOMDimensionItem.' + @CurrentBOMColorColumn + ' 
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = ''' + CAST(@CurrentBOMDimensionID AS VARCHAR(50)) + '''
			AND ColorCode + ''\\'' + ColorName NOT IN (SELECT ColorCode + ''\\'' + ColorName FROM #color)'
			
			EXECUTE sp_executesql @sySQL
			SET @sySQL = ''
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
VALUES ('DB_Version', '0.5.0000', '07257', GetDate())
GO
