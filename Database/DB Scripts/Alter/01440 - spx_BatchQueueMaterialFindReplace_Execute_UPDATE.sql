IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplace_Execute_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplace_Execute_UPDATE]
GO 


CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_Execute_UPDATE(
	@BachQTransactionID UNIQUEIDENTIFIER
)
AS


DECLARE @Error INT 
SET @Error = 0 

BEGIN TRANSACTION 

BEGIN TRY

	DECLARE 
		@BatchQueueMaterialReplaceID UNIQUEIDENTIFIER,
		@CUser NVARCHAR(200),
		@CDate DATETIME,
		@TeamID UNIQUEIDENTIFIER 


	SELECT 
		@BatchQueueMaterialReplaceID = BatchQueueMaterialReplaceID,
		@CUser = CUser,
		@CDate = CDate,
		@TeamID =  TeamID
	FROM bBatchQueuMaterialReplaceTransactionTmp WITH(NOLOCK)
	WHERE BachQTransactionID = @BachQTransactionID


	DECLARE 
		@TOTAL INT,
		@ROWID INT,
		@MaterialColorFindID UNIQUEIDENTIFIER,
		@MaterialColorReplaceID UNIQUEIDENTIFIER,
		@MaterialSizeFindID UNIQUEIDENTIFIER,
		@MaterialSizeReplaceID UNIQUEIDENTIFIER,
		@StyleMaterialID UNIQUEIDENTIFIER
		

	--** Replace MaterialColor
	CREATE TABLE #mc(
		ROWID INT IDENTITY(1,1),
		MaterialColorFindID UNIQUEIDENTIFIER,
		MaterialColorReplaceID UNIQUEIDENTIFIER
	)

	INSERT INTO #mc(
		MaterialColorFindID, 
		MaterialColorReplaceID
	)
	SELECT MaterialColorFindID, MaterialColorReplaceID
	FROM dbo.bBatchQueuMaterialColorReplaceTmp WITH(NOLOCK)
	WHERE BachQTransactionID = @BachQTransactionID


	SET @ROWID = 1
	SELECT @TOTAL = COUNT(*) FROM #mc

	WHILE @ROWID <= @TOTAL
	BEGIN

		SELECT @MaterialColorFindID = MaterialColorFindID, @MaterialColorReplaceID = MaterialColorReplaceID
		FROM #mc WHERE ROWID = @ROWID

		UPDATE c
		SET c.MaterialColorID = @MaterialColorReplaceID
		FROM dbo.bBatchQueueMaterialReplaceStyle a
			INNER JOIN dbo.pStyleColorway b ON a.StyleID = b.StyleID
			INNER JOIN dbo.pStyleColorwayItem  c  ON c.StyleColorID =  b.StyleColorID 
		WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID
		AND c.MaterialColorID  = @MaterialColorFindID
		
		SET @ROWID =  @ROWID + 1 
		
	END

	DROP TABLE #mc

	--** Replace MaterialSize 
	DECLARE 
		@MaterialFindID UNIQUEIDENTIFIER,
		@MaterialReplaceID UNIQUEIDENTIFIER

		
	SELECT @MaterialFindID = MaterialFindID, @MaterialReplaceID = MaterialReplaceID
	FROM bBatchQueueMaterialReplace WITH(NOLOCK)
	WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID


	CREATE TABLE #ms(
		ROWID INT IDENTITY(1,1),
		MaterialSizeFindID UNIQUEIDENTIFIER,
		MaterialSizeReplaceID UNIQUEIDENTIFIER
	)

	INSERT INTO #ms(MaterialSizeFindID, MaterialSizeReplaceID)
	SELECT MaterialSizeFindID, MaterialSizeReplaceID FROM dbo.bBatchQueuMaterialSizeReplaceTmp
	WHERE BachQTransactionID = BachQTransactionID


	SET @ROWID = 1
	SELECT @TOTAL =COUNT(*) FROM #ms

	WHILE @ROWID <= @TOTAL
	BEGIN 

		SELECT 
			@MaterialSizeFindID = MaterialSizeFindID, 
			@MaterialSizeReplaceID = MaterialSizeReplaceID
		FROM #ms WHERE ROWID = @ROWID 

		UPDATE b
		SET MaterialSizeID = @MaterialSizeReplaceID
		FROM dbo.bBatchQueueMaterialReplaceStyle a
			INNER JOIN dbo.pStyleMaterials b ON b.StyleID =  a.StyleID 
		WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID
			AND b.MaterialID = @MaterialFindID
			AND b.MaterialSizeID = @MaterialSizeFindID	
		
		SET @ROWID = @ROWID + 1 
	END 

	DROP TABLE #ms

	--** Update Material in 
	--		pStyleMaterials => MaterialID = NEWMaterial, 
	--		pStyleColorwayItem => MaterialID = NEWMaterial, 
	--		pStyleSourcingItem = > TradepartnerVendorID = NULL, MaterialPrice = 0 

	CREATE TABLE #sm(
		ROWID INT IDENTITY (1,1),
		StyleMaterialID UNIQUEIDENTIFIER
	)


	INSERT INTO #sm( StyleMaterialID)
	SELECT b.StyleMaterialID
	FROM dbo.bBatchQueueMaterialReplaceStyle a
		INNER JOIN dbo.pStyleMaterials b ON a.StyleID = b.StyleID AND b.MaterialID = @MaterialFindID
	WHERE A.BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

	SET @ROWID = 1 
	SELECT @TOTAL = COUNT(*)  FROM #sm 

	WHILE @ROWID <= @TOTAL
	BEGIN
		SELECT @StyleMaterialID = StyleMaterialID FROM #sm WHERE ROWID = @ROWID 
		
		UPDATE dbo.pStyleMaterials 
		SET MaterialID = @MaterialReplaceID
		WHERE StyleMaterialID = @StyleMaterialID 
		
		
		UPDATE a
		SET MaterialImageID = b.MaterialImageID,
			MaterialImageVersion = b.MaterialImageVersion,
			MaterialType = b.MaterialType,
			Materialno =  b.MaterialNo,
			Materialname = b.MaterialName,
			A = b.A,
			B = b.B,
			C = b.C,
			D = b.D,
			E = b.E,
			F = b.F,
			G = b.G,
			H = b.H,
			I = b.I,
			J = b.J,
			K = b.K,
			L = b.L,
			M = b.M,
			N = b.N,
			O = b.O,
			P = b.P,
			Q = b.Q,
			R = b.R,
			S = b.S,
			T = b.T,
			U = b.U,
			V = b.V,
			X = b.X,
			Y = b.Y,
			Z = b.Z,
			Source = b.Source,
			Notes =  b.Notes,
			CDate = @CDate,
			CUser = @CUser,
			MDate = @CDate,
			MUser = @CUser, 
			MChange = b.MChange, 
			TradePartnerID = NULL,
			TradePartnerVendorID =  NULL
		FROM dbo.pStyleMaterials a
			INNER JOIN dbo.pMaterial b ON a.MaterialID =  b.MaterialID 
		WHERE a.StyleMaterialID = @StyleMaterialID
		

		UPDATE pStyleColorwayItem
		SET MaterialID = @MaterialReplaceID
		WHERE StyleMaterialID = @StyleMaterialID		

		UPDATE dbo.pStyleSourcingItem
		SET TradePartnerVendorID = NULL ,
			MaterialPrice =	0 
		WHERE StyleMaterialID = @StyleMaterialID 
		
		
		SET @ROWID = @ROWID + 1 
	END
	

END TRY
BEGIN CATCH 
	SET @Error = 1 
	
END CATCH 


IF @Error = 0
	COMMIT TRANSACTION
ELSE	
	ROLLBACK TRANSACTION 
	


DELETE bBatchQueuMaterialColorReplaceTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialColorReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	

DELETE bBatchQueuMaterialSizeReplaceTmp 
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialSizeReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	


DELETE bBatchQueuMaterialReplaceTransactionTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
WHERE a.TeamID = @TeamID		
	

DELETE FROM dbo.bBatchQueueMaterialReplace
WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01440', GetDate())
GO




