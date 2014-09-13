IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleMaterialColorway_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialColorway_EXECUTE_QUEUE]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialColorway_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS


DECLARE 
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER,
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200), 
	@ColorName  NVARCHAR(200)
	


DECLARE @error INT 
SET @error = 0 

UPDATE pBatchQueueStyleMaterialColorTmp
SET ColorCode = b.ColorCode, ColorName = b.ColorName 
FROM pBatchQueueStyleMaterialColorTmp 
	INNER JOIN dbo.pColorPalette b ON pBatchQueueStyleMaterialColorTmp.ColorPaletteID = b.ColorPaletteID
WHERE pBatchQueueStyleMaterialColorTmp.BatchQueueJobID = @BatchQueueJobID


BEGIN TRAN 

	BEGIN TRY 


	SET @ChangeTransTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008' -- pStyleHeader 

	SELECT @MUser = ISNULL(b.UserName,'') + ' '  +  ISNULL(b.LastName,''),
		@TeamID = b.TeamID
	FROM dbo.pBatchQueueJob a
		INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID = b.TeamID
	WHERE BatchQueueJobID = @BatchQueueJobID


	--** Get Seasonyear
	SELECT @syBatchQueueJobTable = BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

	SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID  FROM ' + @syBatchQueueJobTable + ' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXECUTE	sp_executesql @sySQL, @ParmDefinition,
		@pSeasonYearID = @SeasonYearID OUTPUT


	--** get colors
	CREATE TABLE #bq_color89 (
		ROWID INT IDENTITY(1,1),
		ColorPaletteID UNIQUEIDENTIFIER,
		ColorCode NVARCHAR(200),
		ColorName NVARCHAR(200)
	)

	SELECT @syBatchQueueJobTable = BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #bq_color89 ( ColorPaletteID, ColorCode, ColorName )
		SELECT a.ColorPaletteID, b.ColorCode, b.ColorName  FROM ' + @syBatchQueueJobTable + ' a WITH(NOLOCK) 
			INNER JOIN dbo.pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID
		WHERE a.BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
		
	EXECUTE	sp_executesql @sySQL
	

	--** Get Styles 
	CREATE TABLE #bq_st89 (
		ROWID INT IDENTITY(1,1),
		StyleID UNIQUEIDENTIFIER
	)
	
	
	SELECT @syBatchQueueJobTable = BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 4
	
	SET @sySQL = 'INSERT INTO #bq_st89( StyleID )
		SELECT a.StyleID  FROM ' + @syBatchQueueJobTable + ' a WITH(NOLOCK) 
		WHERE a.BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '	

	EXECUTE	sp_executesql @sySQL


	DECLARE 
		@ROWID INT,
		@TOTAL INT,
		@StyleID UNIQUEIDENTIFIER,
		@NewChangeTransID UNIQUEIDENTIFIER,
		@ColorRowid INT,
		@ColorTotal INT,
		@ColorPaletteID UNIQUEIDENTIFIER,
		@tmpColorpaletteID UNIQUEIDENTIFIER
		

	SELECT @TOTAL = COUNT(*) FROM #bq_st89
	SET @ROWID  = 1 


	WHILE @ROWID <= @TOTAL 
	BEGIN 
		SELECT @StyleID =  StyleID FROM #bq_st89  WHERE ROWID =  @ROWID
		SET @NewChangeTransID =  NULL 

		--** TechPack exists ? 
		IF EXISTS ( SELECT  * FROM dbo.pStyleHeader a WITH(NOLOCK) INNER JOIN dbo.pTechPack b ON 
			a.TechPackId =  b.TechPackID WHERE a.StyleID = @StyleID
		)
		
		BEGIN 
			SET @NewChangeTransID =  NEWID()
			INSERT INTO dbo.pChangeTransaction 
					( ChangeTransID ,
					  ChangeTransPageName ,
					  ChangeTransTableID ,
					  ChangeTransTablePKID ,
					  ChangeTransUserID ,
					  ChangeTransDate,
					  ChangeTransTypeID
					)
			VALUES  ( @NewChangeTransID,
					  'ASP.batchq_stylematerialcolorway_review_aspx' ,
					  @ChangeTransTableID ,
					  @StyleID,
					  @TeamID,
					  @MDate, 
					  1 -- INSERT
					)
		END	
		
		
		SET @ColorRowid =1 
		SELECT @ColorTotal = COUNT(*) FROM #bq_color89
		
		WHILE @ColorRowid <= @ColorTotal
		BEGIN 
			SELECT @ColorPaletteID = ColorPaletteID, @ColorCode = ISNULL(ColorCode,''),  @ColorName = ISNULL(ColorName,'')
			FROM #bq_color89 WHERE ROWID = @ColorRowid
			
			SET @tmpColorpaletteID = NULL
			
			IF LEN(@ColorCode) > 0 
			BEGIN
				SELECT @tmpColorpaletteID = b.ColorpaletteID
				FROM dbo.pStyleColorway a	
					INNER JOIN dbo.pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
				WHERE a.StyleID = @StyleID
					AND b.ColorCode = @ColorCode 
			END 
			
			IF @tmpColorpaletteID IS NULL 
			BEGIN 
				SET @tmpColorpaletteID = @ColorpaletteID
				
				EXECUTE dbo.spx_StyleColorwayFromColor_INSERT
					@StyleID = @StyleID,
					@StyleSet = '1',
					@ColorPaletteID = @ColorpaletteID,
					@CUser  = @MUser,
					@CDate = @MDate,
					@AllSizeClasses = 0,
					@SeasonYearID = @SeasonYearID,
					@ChangeTransID = NULL,
					@ChangeTransUserID = @TeamID,
					@ChangeTransPageName = 'ASP.batchq_stylematerialcolorway_review_aspx'				
					
				
			END 
		
			--*** Update Colorchips 	
			UPDATE pStyleColorwayItem 
			SET MaterialColorID = e.MaterialColorID
			FROM dbo.pStyleColorwayItem  WITH(NOLOCK)
				INNER JOIN dbo.pStyleColorway b WITH(NOLOCK) ON pStyleColorwayItem.StyleColorID =  b.StyleColorID 
					AND b.StyleID = @StyleID
				INNER JOIN dbo.pColorPalette d WITH(NOLOCK)ON d.ColorPaletteID = b.ColorPaletteID
				INNER JOIN pBatchQueueStyleMaterialColorTmp  e ON e.ColorCode =  d.ColorCode
					AND e.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
			WHERE e.BatchQueueJobID = @BatchQueueJobID
			AND d.ColorCode = @ColorCode
							
			SET @ColorRowid  = @ColorRowid  +1 
		END 
		
		SET @ROWID = @ROWID + 1 
	END 



	DROP TABLE #bq_st89
	DROP TABLE #bq_color89

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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02044'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02044', GetDate())
END	
GO