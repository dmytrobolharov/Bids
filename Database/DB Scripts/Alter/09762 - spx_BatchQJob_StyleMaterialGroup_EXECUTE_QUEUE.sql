/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleMaterialGroup_EXECUTE_QUEUE]    Script Date: 23.02.2015 17:03:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_StyleMaterialGroup_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialGroup_EXECUTE_QUEUE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_StyleMaterialGroup_EXECUTE_QUEUE]    Script Date: 23.02.2015 17:03:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJob_StyleMaterialGroup_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS


DECLARE 
	@error INT 
	SET @error = 0 


DECLARE 
	@MaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@MaterialCoreItemID UNIQUEIDENTIFIER


DECLARE 
	@MUser NVARCHAR(200),
	@NewStyleMaterialID UNIQUEIDENTIFIER,
	@ROWID INT,
	@TOTAL INT,
	@TeamID  UNIQUEIDENTIFIER,
	@NewChangeTransID UNIQUEIDENTIFIER ,
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@BBUsage NVARCHAR(200)
			
BEGIN TRAN
BEGIN TRY			

	--** Get Styles 
	CREATE TABLE  #bq_style(
		StyleID UNIQUEIDENTIFIER
	)
	CREATE TABLE  #bq_coreItem(
		MaterialCoreItemID UNIQUEIDENTIFIER
	)	

	INSERT INTO #bq_style (StyleID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4

	INSERT INTO #bq_coreItem (MaterialCoreItemID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3


	--** Get STYLE material GROUP ITEMS
	CREATE TABLE #bq_mg(
		ROWID INT IDENTITY(1,1),
		MaterialID UNIQUEIDENTIFIER,
		StyleID UNIQUEIDENTIFIER,
		MaterialCoreItemID  UNIQUEIDENTIFIER,
		TransactionID UNIQUEIDENTIFIER,
		NewStyleMaterialID UNIQUEIDENTIFIER
	)


	INSERT INTO #bq_mg (MaterialID ,StyleID, MaterialCoreItemID, NewStyleMaterialID )
	SELECT c.MaterialID, a.StyleID, b.MaterialCoreItemID, NEWID() AS NewStyleMaterialID 
	FROM #bq_style  a
		CROSS JOIN  #bq_coreItem b
		INNER JOIN dbo.pMaterialCoreItem c ON b.MaterialCoreItemID = c.MaterialCoreItemID


	--INSERT INTO #bq_mg (MaterialID ,StyleID, MaterialCoreItemID, NewStyleMaterialID )
	--SELECT b.MaterialID,a.StyleID, a.MaterialCoreItemID, NEWID() AS NewStyleMaterialID 
	--FROM pBatchQueueStyleMaterialCoreItemTmp a WITH(NOLOCK)
	--	INNER JOIN dbo.pMaterialCoreItem b  WITH(NOLOCK) ON a.MaterialCoreItemID = b.MaterialCoreItemID 
	--WHERE BatchQueueJobID =  @BatchQueueJobID


	SET @ChangeTransTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008' -- pStyleHeader 

	-- User name
	SELECT @MUser = ISNULL(b.UserName,'') + ' '  +  ISNULL(b.LastName,''),
		@TeamID = b.TeamID
	FROM dbo.pBatchQueueJob a
		INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID = b.TeamID
	WHERE BatchQueueJobID = @BatchQueueJobID


	SET @ROWID = 1 
	SELECT @TOTAL =  COUNT(*) FROM #bq_mg 

	WHILE @ROWID <= @TOTAL 
	BEGIN 

		SELECT @MaterialID  = MaterialID ,@StyleID = StyleID, @MaterialCoreItemID  = MaterialCoreItemID,
			@NewChangeTransID = TransactionID, @NewStyleMaterialID = NewStyleMaterialID
		FROM #bq_mg WHERE ROWID = @ROWID
		
				

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
					  '' ,
					  @ChangeTransTableID ,
					  @StyleID,
					  @TeamID,
					  @MDate, 
					  1 -- INSERT
					)
			UPDATE #bq_mg SET TransactionID = @NewChangeTransID WHERE StyleID = @StyleID
		END	
				
		EXEC spx_StyleMaterialTemp_INSERT 
			@MainMaterial =  0, 
			@StyleID = @StyleID, 
			@StyleMaterialID  = @NewStyleMaterialID, 
			@StyleSet = 1, 
			@MaterialID = @MaterialID, 
			@CreatedBy = @MUser, 
			@CreatedDate = @MDate,
			@TradePartnerVendorID = NULL
			
		-- update with Values from pMaterialCoreItem 
		UPDATE pStyleMaterialTemp  
		SET
			MaterialSizeID = b.MaterialSizeID,
			MaterialSize = b.MaterialSize,
			Qty =  a.Qty,
			UOM = a.UOM,
			Colorway =  ISNULL(a.Colorway,0),
			Placement = a.Placement,
			BatchQJobID = @BatchQueueJobID,
			MaterialCoreItemID = @MaterialCoreItemID 
		FROM dbo.pMaterialCoreItem a
			LEFT OUTER JOIN dbo.pMaterialSize b ON a.MaterialSize =  b.MaterialSize
				AND a.MaterialID =  b.MaterialID
		WHERE a.MaterialCoreItemID = @MaterialCoreItemID 

		EXECUTE spx_StyleMaterialPending_Linked_INSERT 
			@StyleMaterialID = @NewStyleMaterialID,    
			@StyleID = @StyleID, 
			@StyleSet = 1, 
			@CreatedDate = @MDate, 
			@CreatedBy = @MUser,
			@ChangeTransID =@NewChangeTransID,
			@ChangeTransUserID  = @TeamID	

		SET @ROWID = @ROWID + 1 
	END  -- while  #bq_mg

	DROP TABLE #bq_mg



	--** UpdateColorways
	CREATE TABLE #sm2(
		ROWID INT IDENTITY(1,1),
		StyleMaterialID UNIQUEIDENTIFIER,
		MaterialCoreItemID  UNIQUEIDENTIFIER
	)


	INSERT INTO #sm2(StyleMaterialID, MaterialCoreItemID)
	SELECT StyleMaterialID,MaterialCoreItemID
	FROM dbo.pStyleMaterials WITH(NOLOCK) 
	WHERE BatchQJobID = @BatchQueueJobID
			
			
	DECLARE 
		@ColorRowID INT ,
		@ColorTotal INT ,
		@MaterialCoreColorID UNIQUEIDENTIFIER,
		@ColorName  NVARCHAR(200),
		@ColorCode  NVARCHAR(200)
									
									
	CREATE TABLE #bq_color(
		ROWID INT IDENTITY(1,1),
		ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
		ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
		MaterialCoreColorID UNIQUEIDENTIFIER
	)


	INSERT INTO #bq_color(ColorCode, ColorName, MaterialCoreColorID)
	SELECT ColorCode, ColorName, MaterialCoreColorID
	FROM pBatchQueueStyleMaterialCoreColorTmp WITH(NOLOCK)
	WHERE BatchQueueJobID = @BatchQueueJobID
		AND MaterialCoreColorID IS NOT NULL 


	SELECT @ColorTotal = COUNT(*) FROM #bq_color 
	SET @ColorRowID = 1 

	WHILE @ColorRowID <= @ColorTotal
	BEGIN 

		SELECT @MaterialCoreColorID = MaterialCoreColorID, @ColorCode = ColorCode,
			@ColorName = ColorName 
		FROM #bq_color WHERE ROWID = @ColorRowID

		
		UPDATE pStyleColorwayItem
		SET MaterialColorID = e.MaterialColorID,
			MaterialCoreColorItemID = e.MaterialCoreColorItemID
		FROM dbo.pStyleColorwayItem a
			INNER JOIN dbo.pStyleMaterials b ON a.StyleMaterialID =  b.StyleMaterialID
			INNER JOIN dbo.pStyleColorway c ON c.StyleColorID =  a.StyleColorID
			INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
			INNER JOIN dbo.pMaterialCoreColorItem  e  ON e.MaterialCoreColorID = @MaterialCoreColorID
				AND e.MaterialID =  a.MaterialID
		WHERE b.BatchQJobID = @BatchQueueJobID
			AND  d.ColorName =  @ColorName  
			AND d.ColorCode  =  @ColorCode
		
		SET @ColorRowID = @ColorRowID + 1 
		
	END 


	DROP TABLE #sm2
	DROP TABLE #bq_color

END TRY
BEGIN CATCH 
	set @error = 1 
END CATCH 

select @error AS Result

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

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09762', GetDate())
GO
