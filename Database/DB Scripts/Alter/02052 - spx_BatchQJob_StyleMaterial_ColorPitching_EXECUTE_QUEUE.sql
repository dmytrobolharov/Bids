IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleMaterial_ColorPitching_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS


DECLARE @error INT 
SET @error = 0 


BEGIN TRAN 

BEGIN TRY 

	DECLARE 
		@syBatchQueueJobTable  NVARCHAR(200),
		@ParmDefinition NVARCHAR(200),
		@sySQL NVARCHAR(MAX),
		@MaterialID UNIQUEIDENTIFIER
		
	--** Get MaterialID
	SELECT @syBatchQueueJobTable = BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 2

	SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
		' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXECUTE	sp_executesql @sySQL, @ParmDefinition,
		@pMaterialID = @MaterialID OUTPUT



	--** Get Styles 
	CREATE TABLE #tmp24saaStyle(	
		StyleID UNIQUEIDENTIFIER
	)
	
	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #tmp24saaStyle (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL		

	
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


GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02052'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02052', GetDate())
END	
GO