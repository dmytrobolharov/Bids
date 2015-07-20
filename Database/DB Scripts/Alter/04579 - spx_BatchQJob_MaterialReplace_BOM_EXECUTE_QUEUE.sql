/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE_QUEUE]    Script Date: 12/07/2012 17:01:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE_QUEUE]
GO


/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE_QUEUE]    Script Date: 12/07/2012 17:01:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_MaterialReplace_BOM_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS
	
DECLARE 	
	@BatchQueueJobTable	NVARCHAR(200),
	@SQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@OldMaterialID  UNIQUEIDENTIFIER,
	@TOTAL INT, 
	@ROWID INT, 
	@tmpStyleMaterialID UNIQUEIDENTIFIER,
	@tmpMaterialID UNIQUEIDENTIFIER,
	@tmpStyleBOMDimensionID UNIQUEIDENTIFIER,
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
SELECT @BatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @SQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @BatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @SQL, @ParmDefinition,
	@pMaterialID = @OldMaterialID OUTPUT
	


CREATE TABLE #bqsm(
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialID UNIQUEIDENTIFIER,
	StyleBOMDimensionId UNIQUEIDENTIFIER
)



--** Get BOM Items
SELECT @BatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3

SET @SQL = 'INSERT INTO #bqsm ( StyleMaterialID , MaterialID, StyleBOMDimensionId ) 
	 SELECT  b.StyleMaterialID, b.MaterialID, a.StyleBOMDimensionId FROM ' + @BatchQueueJobTable + ' a 
		INNER JOIN pStyleBOM b ON a.StyleBOMDimensionId =  b.StyleBOMDimensionId 
	 WHERE b.MaterialID = ''' + CAST(@OldMaterialID  AS NVARCHAR(40))+ ''' AND a.BatchQueueJobId = ''' +  
	 CAST(@BatchQueueJobId AS NVARCHAR(40)) + ''' '  
EXECUTE	sp_executesql @SQL


--** Material to replace
--** Get MaterialID
SELECT @BatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 4


SET @SQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @BatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @SQL, @ParmDefinition,
	@pMaterialID = @NewMaterialID OUTPUT

SELECT @TOTAL = COUNT(*) FROM #bqsm
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 

	SELECT @tmpStyleMaterialID = StyleMaterialID , 
		@tmpMaterialID = MaterialID, @tmpStyleBomDimensionID = StyleBOMDimensionId 
	FROM #bqsm WHERE ROWID = @ROWID 

	EXECUTE spx_StyleMaterial_ReplaceBOM_UPDATE
		@StyleMaterialID  = @tmpStyleMaterialID,
		@NewMaterialID = @NewMaterialID,
		@MUser= @MUser,
		@MDate = @MDate
	
	SET @ROWID =  @ROWID + 1 
END 

--** UpdateColorways

DECLARE 
	@ColorRowID INT ,
	@ColorTotal INT ,
	@MaterialColorID UNIQUEIDENTIFIER,
	@ColorName  NVARCHAR(200),
	@ColorCode  NVARCHAR(200),
	@CurrentDimensionType UNIQUEIDENTIFIER,
	@CurrentBOMColorColumn VARCHAR(200) = '',
	@sySQL NVARCHAR(MAX)
	
CREATE TABLE #bq_color(
	ROWID INT IDENTITY(1,1),
	ColorCode NVARCHAR(200) COLLATE database_default,
	ColorName NVARCHAR(200) COLLATE database_default,
	MaterialColorID UNIQUEIDENTIFIER
)


INSERT INTO #bq_color(ColorCode, ColorName, MaterialColorID)
SELECT ColorCode, ColorName, MaterialColorID
FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
WHERE BatchQueueJobID = @BatchQueueJobID
	AND MaterialColorID IS NOT NULL 


SELECT @TOTAL = COUNT(*) FROM #bqsm 
SELECT @ColorTotal  =  COUNT(*) FROM #bq_color
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 
	SELECT @tmpStyleMaterialID = StyleMaterialID, 
			@tmpStyleBomDimensionID = StyleBOMDimensionId
	FROM #bqsm WHERE ROWID = @ROWID
	
	SET @ColorRowID = 1 
	
	WHILE @ColorRowID <= @ColorTotal 
	BEGIN
		SELECT @MaterialColorID = MaterialColorID, @ColorCode = ColorCode,
			@ColorName = ColorName 
		FROM #bq_color WHERE ROWID = @ColorRowID
		
		SELECT @CurrentDimensionType = ItemDim1TypeId FROM pStyleBOMItem
		WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID AND StyleMaterialID = @tmpStyleMaterialID
		
		-- Checking, which of pStyleBOMItem item is the Colorway items
		IF @CurrentDimensionType = 'E6FC79E6-19DA-E011-853F-001B21B1D4DF' -- Color
			SET @CurrentBOMColorColumn = 'ItemDim1Name'
		ELSE
		BEGIN
			SELECT @CurrentDimensionType = ItemDim2TypeId FROM pStyleBOMItem
			WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID AND StyleMaterialID = @tmpStyleMaterialID
			IF @CurrentDimensionType = 'E6FC79E6-19DA-E011-853F-001B21B1D4DF' 
				SET @CurrentBOMColorColumn = 'ItemDim2Name'
			ELSE
			BEGIN
				SELECT @CurrentDimensionType = ItemDim3TypeId FROM pStyleBOMItem
				WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID AND StyleMaterialID = @tmpStyleMaterialID
				IF @CurrentDimensionType = 'E6FC79E6-19DA-E011-853F-001B21B1D4DF'
					SET @CurrentBOMColorColumn = 'ItemDim3Name'
			END
		END
		
		-- If current BOM has colorway
		IF @CurrentBOMColorColumn <> ''
		BEGIN
			
			SET @sySQL = 'UPDATE pStyleBOMItem SET MaterialColorId = ''' + CAST(@MaterialColorID AS VARCHAR(40))+ '''
				WHERE ' + @CurrentBOMColorColumn +  ' = ''' + @ColorName + ''' 
				AND StyleMaterialID = ''' + CAST(@tmpStyleMaterialID AS VARCHAR(40)) + '''
				AND StyleBOMDimensionID = ''' + CAST(@tmpStyleBOMDimensionID AS VARCHAR(40)) + ''''
			
			EXECUTE sp_executesql @sySQL
			SET @sySQL = ''
			SET @CurrentBOMColorColumn = ''
			
		END
	
	SET @ColorRowID = @ColorRowID + 1	
	END

	SET @ROWID = @ROWID + 1 
END	

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
	@OldText NVARCHAR(200),
	@SizeTotal INT = 0,
	@SizeRowID INT = 0
	
INSERT INTO #bq_ms ( OldSizeID , NewSizeID,  OldText, NewText)
SELECT a.MaterialSizeOldID, a.MaterialSizeNewID,b.MaterialSize, c.MaterialSize
FROM pBatchQueueStyleMaterialSizeTmp a
	INNER JOIN dbo.pMaterialSize b ON a.MaterialSizeOldID  =  b.MaterialSizeID
	LEFT OUTER JOIN dbo.pMaterialSize c ON c.MaterialSizeID = a.MaterialSizeNewID
WHERE BatchQueueJobID = @BatchQueueJobID


SELECT @SizeTotal =  COUNT(*) FROM #bq_ms 
SELECT @TOTAL = COUNT(*) FROM #bqsm 
SET @ROWID = 1


WHILE @ROWID <= @TOTAL 
BEGIN

	SET @SizeRowID = 1
	
	SELECT @tmpStyleMaterialID = StyleMaterialID, 
		@tmpStyleBomDimensionID = StyleBOMDimensionId
	FROM #bqsm WHERE ROWID = @ROWID
	
	WHILE @SizeRowID <= @SizeTotal
	BEGIN
		SELECT @OldSizeID = OldSizeID, @NewSizeID = NewSizeID ,
			@OldText =OldText, @NewText =NewText
		FROM #bq_ms  WHERE ROWID = @SizeRowID
		
		UPDATE pStyleBOM
		SET MaterialSize = @NewText ,
			MaterialSizeID = @NewSizeID
		WHERE MaterialSize = @OldText AND MaterialSizeID = @OldSizeID
		AND StyleMaterialID = @tmpStyleMaterialID AND StyleBOMDimensionId = @tmpStyleBomDimensionID
	
		SET @SizeRowID = @SizeRowID + 1
	END
		
	SET @ROWID = @ROWID + 1 
END 


DROP TABLE #bq_color
DROP TABLE #bqsm
DROP TABLE #bq_ms

UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
WHERE BatchQueueJobID = @BatchQueueJobID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04579', GetDate())
GO
