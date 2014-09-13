IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_Replace_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_StyleMaterial_Replace_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterial_Replace_UPDATE](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@NewMaterialID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@TeamID UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@ChangeManagementEnabled INT = 0,
	@BatchQueueJobID UNIQUEIDENTIFIER = NULL
)
AS

DECLARE 
	@StyleID UNIQUEIDENTIFIER, 
	@RATING NVARCHAR(18) ,
	@MaterialSize NVARCHAR(200),
	@MaterialSizeID UNIQUEIDENTIFIER ,
	@UOM NVARCHAR(50),
	@Colorway INT,
	@Placement NVARCHAR(4000),
	@MaterialSort NVARCHAR(5),
	@StyleSet INT,
	@MainMaterial INT


--** Get current values
SELECT @RATING = Qty, @MaterialSize = MaterialSize, 
	@UOM  = UOM, @Colorway = Colorway, @Placement = Placement,
	@MaterialSort =  MaterialSort, @StyleID = StyleID, @StyleSet = StyleSet, @MainMaterial  = MainMaterial
FROM pStyleMaterials WITH (NOLOCK) WHERE StyleMaterialID  = @StyleMaterialID

--** Check if the current Size is avaliable in the new Material 
SELECT @MaterialSizeID  = MaterialSizeID 
FROM pMaterialSize  WITH (NOLOCK) 
WHERE MaterialID = @NewMaterialID
	AND MaterialSize = @MaterialSize 

IF @MaterialSizeID IS NULL 
BEGIN
	SET @MaterialSizeID = '00000000-0000-0000-0000-000000000000'
	SET @MaterialSize = '*NA'
END 


---**Create a new Transaction Log 
DECLARE 
	@NewChangeTransID UNIQUEIDENTIFIER ,
	@ChangeTransTableID UNIQUEIDENTIFIER 
	
SET @ChangeTransTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008' -- pStyleHeader 

SET @NewChangeTransID = NULL

IF @ChangeManagementEnabled = 1 
BEGIN 

	----** TechPack exists ? 
	--IF EXISTS ( SELECT  * FROM dbo.pStyleHeader a
	--		INNER JOIN dbo.pTechPack b ON a.TechPackId =  b.TechPackID
	--		WHERE a.StyleID = @StyleID
	--)
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
				  @ChangeTransPageName ,
				  @ChangeTransTableID ,
				  @StyleID,
				  @TeamID,
				  @MDate, 
				  2 -- DELETE
				)
	END
END 


--** Delete stylematerial to be replaced
EXEC spx_StyleMaterial_DELETE 
	@StyleMaterialID = @StyleMaterialID,
	@ChangeTransID = @NewChangeTransID,
	@ChangeTransUserID  = @TeamID,
	@MUser = @MUser,
	@MDate = @MDate 
	

--** Insert new Material 
DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER
SET @NewStyleMaterialID = NEWID()

EXEC spx_StyleMaterialTemp_INSERT 
	@MainMaterial =  @MainMaterial , @StyleID = @StyleID, 
	@StyleMaterialID  = @NewStyleMaterialID, @StyleSet = @StyleSet, 
	@MaterialID = @NewMaterialID, @CreatedBy = @MUser, @CreatedDate = @MDate,
	@TradePartnerVendorID = NULL

UPDATE pStyleMaterialTemp SET 
	Qty = @RATING, MaterialSize = @MaterialSize, MaterialSizeID = @MaterialSizeID,
	UOM = @UOM, Colorway = @Colorway, Placement = @Placement,
	MaterialSort = @MaterialSort,
	BatchQJobID = @BatchQueueJobID
WHERE StyleMaterialID = @NewStyleMaterialID


EXECUTE spx_StyleMaterialPending_INSERT 
	@StyleMaterialID = @NewStyleMaterialID,    
	@StyleID = @StyleID, 
	@StyleSet = @StyleSet, 
	@CreatedDate = @MDate, 
	@CreatedBy = @MUser,
	@ChangeTransID =@NewChangeTransID,
	@ChangeTransUserID  = @TeamID


DECLARE @MaterialImageID UNIQUEIDENTIFIER
DECLARE @MaterialImageVersion INT
DECLARE @MaterialNo NVARCHAR (50)
DECLARE @MaterialName  NVARCHAR (200)
DECLARE @MaterialID UNIQUEIDENTIFIER


SELECT TOP  1  
	@MaterialID = MaterialID , 
	@MaterialImageID = MaterialImageID,
	@MaterialImageVersion  = MaterialImageVersion ,
	@MaterialNo = MaterialNo ,
	@MaterialName = MaterialName ,
	@StyleMaterialID = StyleMaterialID
FROM pStyleMaterials 
WHERE StyleID = @StyleID AND MainMaterial = 1



SET @MaterialID = NULL 

SELECT TOP 1 @MaterialID = MaterialID 
FROM pStyleMaterials 
WHERE StyleID = @StyleID
	AND MainMaterial = 1 


UPDATE pStyleHeader SET 
	MaterialID = @MaterialID , 
	MaterialImageID = @MaterialImageID,
	MaterialImageVersion  = @MaterialImageVersion ,
	MaterialNo = @MaterialNo ,
	MaterialName = @MaterialName ,
	StyleMaterialID = @StyleMaterialID
WHERE StyleID = @StyleID 
	

--** Rearrange Transactions
IF @ChangeManagementEnabled = 1 AND @NewChangeTransID IS NOT NULL AND CAST(@NewChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
BEGIN 

	CREATE TABLE #tmp ( 
		ROWID INT IDENTITY(1,1),
		ChangeTransID UNIQUEIDENTIFIER DEFAULT NEWID(),
		StyleID UNIQUEIDENTIFIER, 
		NEW_StyleMaterialID UNIQUEIDENTIFIER,
		ChangeBeforeText NVARCHAR(400),
		ChangeAfterText NVARCHAR(400),
		NEW_MatName NVARCHAR(200),  
		NEW_MatNo NVARCHAR(200),
		NEW_MatType NVARCHAR(200)
	)

	INSERT INTO #tmp (StyleID,NEW_StyleMaterialID,
		ChangeBeforeText,ChangeAfterText,
		NEW_MatName,NEW_MatNo, NEW_MatType) 
	SELECT a.ChangeBeforeValue AS StyleID, c.ChangeTablePKID AS NEW_StyleMaterialID,
		b.ChangeBeforeText, a.ChangeAfterText,
		a.Custom_SMat_Name AS NEW_MatName, a.Custom_SMat_No AS NEW_MatNo, a.Custom_SMat_Type AS NEW_MatType
	FROM dbo.pChangeLogItem a WITH (NOLOCK) 
		INNER JOIN dbo.pChangeLogItem b WITH (NOLOCK) ON a.ChangeBeforeValue = b.ChangeAfterValue
		INNER JOIN pChangeLog c WITH (NOLOCK) ON c.ChangeLogID = a.ChangeLogID
		INNER JOIN pchangeLog d WITH (NOLOCK) ON d.ChangeLogID =  b.ChangeLogID
	WHERE a.ChangeTransID  = @NewChangeTransID


	DECLARE 
		@TOTAL INT,
		@ROWID INT,
		@New_StyleMaterialID UNIQUEIDENTIFIER,
		@ChangeBeforeText NVARCHAR(400),
		@ChangeAfterText NVARCHAR(400),
		@NEW_MatName NVARCHAR(200),
		@NEW_MatNo NVARCHAR(200),
		@NEW_MatType NVARCHAR(200),
		@ChangeLogID UNIQUEIDENTIFIER,
		@ChangeTransID UNIQUEIDENTIFIER
		
		
	SET @ROWID = 1
	SELECT @TOTAL = COUNT(*) FROM #tmp	

	WHILE @ROWID <= @TOTAL 
	BEGIN 
		SELECT 
			@ChangeTransID = ChangeTransID,
			@StyleID = StyleID,
			@New_StyleMaterialID = New_StyleMaterialID, 
			@ChangeBeforeText = ChangeBeforeText,
			@ChangeAfterText = ChangeAfterText,
			@NEW_MatName = NEW_MatName,
			@NEW_MatNo = NEW_MatNo,
			@NEW_MatType = NEW_MatType
		FROM #tmp WHERE ROWID = @ROWID

		SET @ChangeLogID = NULL 
		--** Insert transaction (Replace action)
		INSERT INTO dbo.pChangeTransaction 
				( ChangeTransID ,
				  ChangeTransPageName ,
				  ChangeTransTableID ,
				  ChangeTransTablePKID ,
				  ChangeTransUserID ,
				  ChangeTransDate,
				  ChangeTransTypeID
				)
		VALUES  ( @ChangeTransID,
				  @ChangeTransPageName ,
				  @ChangeTransTableID ,
				  @StyleID,
				  @TeamID,
				  @MDate, 
				  4 -- REPLACE
				)

		EXECUTE spx_ChangeLog_INSERTID
				@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008', -- pStyleMaterials
				@changeTransId = @ChangeTransID,
				@changeTablePKId = @New_StyleMaterialID,
				@changeUserId = @TeamID, 
				@ChangeUserName = @MUser,
				@changeDate = @MDate,
				@changeSort = '0000',
				@ShowResult = 0,
				@ChangeLogID = @ChangeLogID OUTPUT
					
			EXECUTE spx_ChangeLogItem_INSERT
				@ChangeLogID = @ChangeLogID,
				@ChangeTransID = @ChangeTransID,
				@ChangeFieldName = 'StyleMaterialID',
				@ChangeFieldAlias = 'StyleMaterialID',
				@ChangeBeforeValue = NULL,
				@ChangeAfterValue =  NULL,
				@ChangeBeforeText = @ChangeBeforeText,
				@ChangeAfterText = @ChangeAfterText,
				@ChangeSort = '0001'
				
		SET @ROWID = @ROWID + 1 
		
	END 


	--** Delete Transaction 
	DELETE FROM dbo.pChangeTransaction WHERE ChangeTransID = @NewChangeTransID

END 

GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02039'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02039', GetDate())
END
GO