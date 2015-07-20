IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorways_Review_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER

	
CREATE TABLE #bqsc_color(
	ROWID INT IDENTITY(1,1),
	ColorPaletteID UNIQUEIDENTIFIER,
	ColorCode NVARCHAR(200),
	ColorName NVARCHAR(200)
)	

	
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
	
	
--** Get Colors 
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3
	

SET @sySQL = 'INSERT INTO #bqsc_color ( ColorPaletteID, ColorCode, ColorName )
	SELECT a.ColorPaletteID, b.ColorCode, b.ColorName FROM ' + @syBatchQueueJobTable  + ' a 
		INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
	WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
EXECUTE	sp_executesql @sySQL


INSERT INTO  pBatchQueueStyleMaterialColorTmp  (StyleMaterialColorID, BatchQueueJobID, 
	ColorCode, ColorName, StyleMaterialID , ColorPaletteID, StyleID )
SELECT NEWID() AS StyleMaterialColorID, @BatchQueueJobID, 
	a.ColorCode, a.ColorName, b.StyleMaterialID , a.ColorPaletteID , @StyleID
FROM #bqsc_color a
	CROSS JOIN dbo.pStyleMaterials b
	LEFT OUTER JOIN pBatchQueueStyleMaterialColorTmp c ON  c.StyleMaterialID = b.StyleMaterialID 
		AND c.ColorPaletteID = a.ColorPaletteID
		AND c.BatchQueueJobID = @BatchQueueJobId
WHERE b.StyleID = @StyleID
AND c.StyleMaterialColorID IS NULL
AND b.Colorway = 1
AND b.StyleSet = '1'


-- Style without materials ? 
IF NOT EXISTS ( SELECT * FROM pBatchQueueStyleMaterialColorTmp WHERE BatchQueueJobID = @BatchQueueJobID  AND StyleID = @StyleID	) 
BEGIN
	INSERT INTO  pBatchQueueStyleMaterialColorTmp  ( StyleMaterialColorID, BatchQueueJobID, StyleID)
	VALUES (NEWID(), @BatchQueueJobID, @StyleID)
END 

--** Default color pitching 
UPDATE dbo.pBatchQueueStyleMaterialColorTmp
	SET MaterialColorID = e.MaterialColorID
FROM pBatchQueueStyleMaterialColorTmp a
	INNER JOIN dbo.pStyleMaterials  b ON a.StyleMaterialID = b.StyleMaterialID 
	INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
	INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
			AND e.MaterialID = b.MaterialID
	INNER JOIN dbo.pMaterialColorSeasonYear d ON d.MaterialColorID = e.MaterialColorID
			AND d.SeasonyearID = @SeasonyearID 
WHERE BatchQueueJobID = @BatchQueueJobID
AND b.StyleID = @StyleID
AND b.StyleSet = '1'
AND ISNULL(a.Reviewed,0) = 0 


DROP TABLE #bqsc_color

--** Materials with only 1 color 
CREATE TABLE #mat_1c(    
	MaterialID UNIQUEIDENTIFIER
)

INSERT INTO #mat_1c ( MaterialID )
SELECT b.materialID 
FROM  (
	SELECT DISTINCT b.MaterialID
	FROM  pBatchQueueStyleMaterialColorTmp a
		INNER JOIN dbo.pStyleMaterials b ON b.StyleMaterialID  =  a.StyleMaterialID
	WHERE a.BatchQueueJobID = @BatchQueueJobID
		AND b.StyleID = @StyleID
) foo 
	INNER JOIN pMaterialColor b ON foo.MaterialID =  b.MaterialID
	INNER JOIN dbo.pMaterialColorSeasonYear c ON c.MaterialColorID =  b.MaterialColorID AND c.SeasonYearID = @SeasonYearID
GROUP BY b.MaterialID
HAVING COUNT(*)  = 1 


UPDATE pBatchQueueStyleMaterialColorTmp
SET  MaterialColorID= d.MaterialColorID
FROM  pBatchQueueStyleMaterialColorTmp a 
	INNER JOIN dbo.pStyleMaterials b ON a.StyleMaterialID = b.StyleMaterialID
	INNER JOIN #mat_1c c ON c.MaterialID =  b.MaterialID
	INNER JOIN dbo.pMaterialColorSeasonYear d ON d.MaterialID = c.MaterialID AND d.SeasonYearID = @SeasonYearID
WHERE a.BatchQueueJobID = @BatchQueueJobID
AND b.StyleID = @StyleID
AND a.MaterialColorID IS NULL



DROP TABLE #mat_1c
-----


	
SELECT a.StyleMaterialID, a.ColorPaletteID, @SeasonYearID AS SeasonYearID, b.MaterialID,
	ISNULL(CAST(a.MaterialColorID AS NVARCHAR(40)),'') AS MaterialColorID,
	e.MaterialName, e.MaterialNo, e.MaterialCode,
	'<img src="../System/Control/ImageStream.ashx?S=50&V='  +  ISNULL(CAST(b.MaterialImageVersion  AS NVARCHAR(5)),'0')+  
	'&IID=' + ISNULL(CAST(b.MaterialImageID AS NVARCHAR(40)),'00000000-0000-0000-0000-000000000000') + '" />' AS ImagePath,
	c.ComponentOrder, b.MainMaterial
INTO #tmp2
FROM dbo.pBatchQueueStyleMaterialColorTmp a
	INNER JOIN dbo.pStyleMaterials b ON a.StyleMaterialID = b.StyleMaterialID 
	INNER JOIN pMaterial e ON e.MaterialID  = b.MaterialID
	INNER JOIN dbo.pComponentType c ON c.ComponentTypeID =  e.MaterialType
WHERE BatchQueueJobID = @BatchQueueJobId
	AND b.StyleID = @StyleID
	AND b.StyleSet = '1'



DECLARE @tableName NVARCHAR(50)
SET @tableName = '##' + REPLACE(CAST ( NEWID()AS NVARCHAR (50)), '-', '')

EXECUTE spx_Crosstab 
@DBFetch = 'SELECT * FROM #tmp2',
@DBWhere = NULL,
@DBPivot = NULL,
@DBField = 'ColorPaletteID',
@PCField = 'MaterialColorID',
@PCBuild = 'MAX',
@PCAdmin = NULL,
@DBAdmin = 0,
@DBTable = @tableName ,
@DBWrite = NULL,
@DBUltra = 0

DROP TABLE #tmp2

SET @sySQL = 'SELECT * FROM '  + @tableName + ' ORDER BY MainMaterial DESC, ComponentOrder ; DROP TABLE ' + @tableName 
EXEC sp_executesql @sySQL



GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02042'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02042', GetDate())

END	
GO