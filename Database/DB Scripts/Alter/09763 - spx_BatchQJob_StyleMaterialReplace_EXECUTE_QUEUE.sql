/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE_QUEUE]    Script Date: 24.02.2015 12:18:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE_QUEUE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE_QUEUE]    Script Date: 24.02.2015 12:18:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialReplace_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS
	
DECLARE 	
	@SQL NVARCHAR(MAX),
	@OldMaterialID  UNIQUEIDENTIFIER,
	@TOTAL INT, 
	@ROWID INT, 
	@tmpStyleMaterialID UNIQUEIDENTIFIER,
	@tmpMaterialID UNIQUEIDENTIFIER,
	@tmpStyleID UNIQUEIDENTIFIER,
	@StyleMaterialToReplaceID UNIQUEIDENTIFIER ,
	@MUser NVARCHAR(200),
	@NewMaterialID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
	
	
SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID


SELECT @MUser = ISNULL(b.FirstName,'') + ' ' + ISNULL(b.LastName,'')
FROM dbo.pBatchQueueJob a WITH(NOLOCK)
	INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID =  b.TeamID
WHERE BatchQueueJobID = @BatchQueueJobID



--** Material to replace
--** Get MaterialID
SELECT @OldMaterialID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 2

CREATE TABLE #bqsm(
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialID UNIQUEIDENTIFIER,
	StyleID UNIQUEIDENTIFIER
)

INSERT INTO #bqsm (StyleMaterialID, MaterialID, StyleID)
SELECT StyleMaterialID, MaterialID, StyleID
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
INNER JOIN pStyleMaterials mat ON mat.StyleID = rec.BatchQueuePagePki
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3 AND mat.MaterialID = @OldMaterialID

--** Material to replace
--** Get MaterialID
SELECT @NewMaterialID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4
		


SELECT @TOTAL = COUNT(*) FROM #bqsm
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 

	SELECT @tmpStyleMaterialID = StyleMaterialID , 
		@tmpMaterialID = MaterialID, @tmpStyleID = StyleID 
	FROM #bqsm WHERE ROWID = @ROWID 

	EXECUTE spx_StyleMaterial_Replace_UPDATE
		@StyleMaterialID  = @tmpStyleMaterialID,
		@NewMaterialID = @NewMaterialID,
		@MUser= @MUser,
		@MDate = @MDate,
		@TeamID = @TeamID,
		@ChangeTransPageName = '',
		@ChangeManagementEnabled =0,
		@BatchQueueJobID =  @BatchQueueJobID
	
	SET  @ROWID =  @ROWID + 1 
END 

DROP TABLE #bqsm


--** UpdateColorways

CREATE TABLE #sm2(
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER,
	MainMaterial INT
)


INSERT INTO #sm2(StyleMaterialID, MainMaterial)
SELECT StyleMaterialID, MainMaterial
FROM dbo.pStyleMaterials WITH(NOLOCK) 
WHERE BatchQJobID = @BatchQueueJobID

DECLARE 
	@ColorRowID INT ,
	@ColorTotal INT ,
	@MaterialColorID UNIQUEIDENTIFIER,
	@ColorName  NVARCHAR(200),
	@ColorCode  NVARCHAR(200),
	@MainMaterial INT
	
CREATE TABLE #bq_color(
	ROWID INT IDENTITY(1,1),
	ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
	ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
	MaterialColorID UNIQUEIDENTIFIER
)


INSERT INTO #bq_color(ColorCode, ColorName, MaterialColorID)
SELECT ColorCode, ColorName, MaterialColorID
FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
WHERE BatchQueueJobID = @BatchQueueJobID
	AND MaterialColorID IS NOT NULL 


SELECT @TOTAL = COUNT(*) FROM #sm2 
SELECT @ColorTotal  =  COUNT(*) FROM #bq_color
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 
	SELECT @tmpStyleMaterialID = StyleMaterialID, @MainMaterial = MainMaterial
	FROM #sm2 WHERE ROWID = @ROWID
	
	SET @ColorRowID = 1 
	
	WHILE @ColorRowID <= @ColorTotal 
	BEGIN
		SELECT @MaterialColorID = MaterialColorID, @ColorCode = ColorCode,
			@ColorName = ColorName 
		FROM #bq_color WHERE ROWID = @ColorRowID
	
		UPDATE pStyleColorwayItem 
		SET MaterialColorID = @MaterialColorID
		FROM pStyleColorwayItem a
			INNER JOIN dbo.pStyleColorway b ON a.StyleColorID = b.StyleColorID	
			INNER JOIN dbo.pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
		WHERE StyleMaterialID  = @tmpStyleMaterialID
			AND ISNULL(c.ColorCode,'') = @ColorCode
			AND ISNULL(c.ColorName,'') = @ColorName
			
		SET @ColorRowID = @ColorRowID  + 1 
	END  -- While colors
	
	
	IF @MainMaterial = 1 
	BEGIN 
		--** Update pStyleHeader 
		UPDATE  dbo.pStyleHeader
		SET StyleMaterialID = a.StyleMaterialID, 
			MaterialImageID = a.MaterialImageID, 
			MaterialImageVersion = a.MaterialImageVersion, 
			MaterialID = a.MaterialID, 
			MaterialNo = a.MaterialNo, 
			MaterialName = a.MaterialName  
		FROM dbo.pStyleMaterials a
			INNER JOIN dbo.pStyleHeader ON dbo.pStyleHeader.StyleID = a.StyleID
		WHERE a.StyleMaterialID = @tmpStyleMaterialID  

	END 	
	

	SET @ROWID = @ROWID + 1 
END		

DROP TABLE #sm2
DROP TABLE #bq_color



--*** replace MaterialSize

CREATE TABLE #bq_ms(
	ROWID INT IDENTITY(1,1),
	OldSizeID UNIQUEIDENTIFIER,
	NewSizeID UNIQUEIDENTIFIER,
	NewText NVARCHAR(200),
	OldText NVARCHAR(200)

)

DECLARE 
	@OldSizeID UNIQUEIDENTIFIER,
	@NewSizeID UNIQUEIDENTIFIER,
	@NewText NVARCHAR(200),
	@OldText NVARCHAR(200)
	
INSERT INTO #bq_ms ( OldSizeID , NewSizeID,  OldText, NewText)
SELECT a.MaterialSizeOldID, a.MaterialSizeNewID,b.MaterialSize, c.MaterialSize
FROM pBatchQueueStyleMaterialSizeTmp a
	INNER JOIN dbo.pMaterialSize b ON a.MaterialSizeOldID  =  b.MaterialSizeID
	LEFT OUTER JOIN dbo.pMaterialSize c ON c.MaterialSizeID = a.MaterialSizeNewID
WHERE BatchQueueJobID = @BatchQueueJobID


SET @ROWID = 1 
SELECT @TOTAL =  COUNT(*) FROM #bq_ms 

WHILE @ROWID <= @TOTAL 
BEGIN
	SELECT @OldSizeID = OldSizeID, @NewSizeID = NewSizeID ,
		@OldText =OldText, @NewText =NewText
	FROM #bq_ms  WHERE ROWID = @ROWID

	
	UPDATE dbo.pStyleMaterials
	SET MaterialSize = @NewText ,
		MaterialSizeID = @NewSizeID
	FROM dbo.pStyleMaterials a
	WHERE a.BatchQJobID = @BatchQueueJobID
		AND a.MaterialSize = @OldText
		
	SET @ROWID = @ROWID + 1 
END 



UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
WHERE BatchQueueJobID = @BatchQueueJobID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09763', GetDate())
GO
