IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleMaterials' and COLUMN_NAME = N'MaterialSwing')
       BEGIN 
            ALTER TABLE pStyleMaterials ADD MaterialSwing int NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleMaterialTemp' and COLUMN_NAME = N'MaterialSwing')
       BEGIN 
            ALTER TABLE pStyleMaterialTemp ADD MaterialSwing int NULL
       END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_Replace_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterial_Replace_UPDATE]
GO


/*
Comment #01 - Clayton Parker June 23, 2010
Updated Procedure to capture new swingticket field as well as the lining field that wasnt
being copied on the replace.
*/

CREATE PROCEDURE [dbo].[spx_StyleMaterial_Replace_UPDATE](
@StyleMaterialID UNIQUEIDENTIFIER,
@NewMaterialID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME,
@TeamID UNIQUEIDENTIFIER,
@ChangeTransPageName NVARCHAR(200),
@ChangeManagementEnabled INT = 0
)
AS

DECLARE @StyleID UNIQUEIDENTIFIER 
DECLARE @RATING NVARCHAR(18) 
DECLARE @MaterialSize NVARCHAR(200)
DECLARE @MaterialSizeID UNIQUEIDENTIFIER 
DECLARE @UOM NVARCHAR(50)
DECLARE @Colorway INT
DECLARE @Placement NVARCHAR(4000)
DECLARE @MaterialSort NVARCHAR(5)
DECLARE @StyleSet INT
DECLARE @MainMaterial INT
DECLARE @MaterialLining INT -- #01
DECLARE @MaterialSwing INT	-- #01 

--***
--** Get current values
--***
SELECT @RATING = Qty, @MaterialSize = MaterialSize, 
	@UOM  = UOM, @Colorway = Colorway, @Placement = Placement,
	@MaterialSort =  MaterialSort, @StyleID = StyleID, @StyleSet = StyleSet, @MainMaterial  = MainMaterial,
	@MaterialLining = MaterialLining, @MaterialSwing = MaterialSwing 
FROM pStyleMaterials WITH (NOLOCK) WHERE StyleMaterialID  = @StyleMaterialID



--***
--** Check if the current Size is avaliable in the new Material 
--***
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

	--** TechPack exists ? 
	IF EXISTS ( SELECT  * FROM dbo.pStyleHeader a
			INNER JOIN dbo.pTechPack b ON a.TechPackId =  b.TechPackID
			WHERE a.StyleID = @StyleID
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
	

--***
--** Insert new Material 
--***
DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER
SET @NewStyleMaterialID = NEWID()

EXEC spx_StyleMaterialTemp_INSERT 
@MainMaterial =  @MainMaterial , @StyleID = @StyleID, 
@StyleMaterialID  = @NewStyleMaterialID, @StyleSet = @StyleSet, 
@MaterialID = @NewMaterialID, @CreatedBy = @MUser, @CreatedDate = @MDate,
@TradePartnerVendorID = NULL

UPDATE pStyleMaterialTemp  
SET Qty = @RATING, MaterialSize = @MaterialSize, MaterialSizeID = @MaterialSizeID,
UOM = @UOM, Colorway = @Colorway, Placement = @Placement,
MaterialSort = @MaterialSort, MaterialLining = @MaterialLining, MaterialSwing = @MaterialSwing		--#01
WHERE StyleMaterialID = @NewStyleMaterialID


EXECUTE spx_StyleMaterialPending_INSERT 
	@StyleMaterialID = @NewStyleMaterialID,    
	@StyleID = @StyleID, 
	@StyleSet = @StyleSet, 
	@CreatedDate = @MDate, 
	@CreatedBy = @MUser,
	@ChangeTransID =@NewChangeTransID,
	@ChangeTransUserID  = @TeamID



--***
--** Rearrange Transactions
--***
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






