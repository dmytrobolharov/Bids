IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDBOMMaterial_Replace_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDBOMMaterial_Replace_UPDATE]
GO




CREATE PROCEDURE [dbo].[spx_StyleDBOMMaterial_Replace_UPDATE](
	@StyleBOMDimensionId UNIQUEIDENTIFIER,
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
	@MainMaterial INT,
	@WorkflowItemID NVARCHAR(50),
	@WorkflowID NVARCHAR(50)
	

BEGIN TRY
BEGIN TRANSACTION

--** Get current values
SELECT @RATING = Qty, @MaterialSize = MaterialSize, 
	@UOM  = UOM, @Colorway = Colorway, @Placement = Placement,
	@MaterialSort =  MaterialSort, @StyleID = StyleID, @StyleSet = StyleSet, @MainMaterial  = MainMaterial,
	@WorkflowItemID=WorkflowItemID, @WorkflowID=WorkflowID 
	FROM pStyleBOM WITH (NOLOCK) WHERE StyleMaterialID  = @StyleMaterialID 
	--and StyleBOMDimensionId=@StyleBOMDimensionId

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

--** Insert new Material 
DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER
SET @NewStyleMaterialID = NEWID()

INSERT INTO pStyleBOMTemp
    (MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, 
    L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, MainMaterial, 
    StyleID, StyleMaterialID, StyleSet , UOM, WorkflowItemID, WorkflowID, StyleBOMDimensionId,QuickAdd
    )
SELECT     MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L,
    M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, @MDate AS CDate, @MUser AS CUser, @MDate AS MDate, 
    @MUser AS MUser, MChange, DChange, Action, @MainMaterial AS MainMaterial, @StyleID AS StyleID, @NewStyleMaterialID AS StyleMaterialID, 
    @StyleSet AS StyleSet ,UOM, @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId,'3'
    FROM  pMaterial WITH (NOLOCK)
WHERE (MaterialID = @NewMaterialID)


SELECT * INTO #DimBOMTemp FROM  pStyleBOMTemp WITH (NOLOCK)
WHERE StyleMaterialID=@NewStyleMaterialID and  MaterialID = @NewMaterialID and QuickAdd='3'


Update #DimBOMTemp set StyleMaterialID=@StyleMaterialID
where StyleMaterialID=@NewStyleMaterialID  and  MaterialID = @NewMaterialID

Update pStyleBOM set 
StyleMaterialID=t.StyleMaterialID, StyleMaterialMasterID=t.StyleMaterialID, MainMaterial=t.MainMaterial,MaterialLining=t.MaterialLining, 
Development=t.Development, MiscColor=t.MiscColor, StyleSet=t.StyleSet, StyleID=t.StyleID, UOM=t.UOM, Qty=t.Qty, MaterialPrice=t.MaterialPrice, Ext=t.Ext, 
MaterialSize=t.MaterialSize, MaterialID=t.MaterialID, StyleBOMDimensionID=t.StyleBOMDimensionID, WorkflowItemId=t.WorkflowItemId, WorkflowId=t.WorkflowId,
MaterialPlacement=t.MaterialPlacement, MaterialPlacementCode=t.MaterialPlacementCode, MaterialPlacementDetail=t.MaterialPlacementDetail, 
MaterialImageID=t.MaterialImageID, MaterialImageVersion=t.MaterialImageVersion, NoColorMatch=t.NoColorMatch, SupplierID=t.SupplierID, 
ComponentTypeID=t.ComponentTypeID, MaterialType=t.MaterialType, MaterialNo=t.MaterialNo, MaterialName=t.MaterialName, 
Source=t.Source, Notes=t.Notes, Placement=t.Placement, VendorPrice=t.VendorPrice, VolumePrice=t.VolumePrice, VolumePriceMinimum=t.VolumePriceMinimum, 
VendorProductionMin=t.VendorProductionMin, VendorProductionLeadTime=t.VendorProductionLeadTime, DetailYesNo=t.DetailYesNo, ImageType=t.ImageType, 
height=t.height, width=t.width, CDate=t.CDate, CUser=t.CUser, MDate=t.MDate, 
MUser=t.MUser, MChange=t.MChange, SChange=t.SChange, 
DChange=t.DChange, CChange=t.CChange, Action=t.Action, ColorPlacement=t.ColorPlacement, Artwork=t.Artwork, License=t.License, Colorway=t.Colorway, 
A=t.A, B=t.B, C=t.C, D=t.D, E=t.E, F=t.F, G=t.G, H=t.H, I=t.I, J=t.J, K=t.K, L=t.L, M=t.M, N=t.N, O=t.O, P=t.P, Q=t.Q, R=t.R, S=t.S, T=t.T, U=t.U, V=t.V, W=t.W, X=t.X, Y=t.Y, Z=t.Z, 
MaterialLinked=t.MaterialLinked, MaterialTrack=t.MaterialTrack, TradePartnerID=t.TradePartnerID, TradePartnerVendorID=t.TradePartnerVendorID, MaterialBOM=t.MaterialBOM , 
MaterialSizeID=t.MaterialSizeID, StyleMaterialLinkID=t.StyleMaterialLinkID, MaterialCoreItemID=t.MaterialCoreItemID
from pStyleBOM b inner join #DimBOMTemp t on b.StyleMaterialID=t.StyleMaterialID
where b.StyleMaterialID=@StyleMaterialID

delete from pStyleBOMTemp	where StyleMaterialID=@NewStyleMaterialID and  MaterialID = @NewMaterialID and QuickAdd=3

drop table #DimBOMTemp

UPDATE pStyleBOM SET 
	Qty = @RATING, MaterialSize = @MaterialSize, MaterialSizeID = @MaterialSizeID,
	UOM = @UOM, Colorway = @Colorway, Placement = @Placement,
	MaterialSort = @MaterialSort
WHERE StyleMaterialID = @StyleMaterialID

/* commented as per WI#22481 */
--delete from pStyleBOMItem	where StyleMaterialID=@StyleMaterialID and StyleBOMDimensionId=@StyleBOMDimensionId

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
				@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008', -- pStyleBOM
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

COMMIT TRANSACTION
	select 1 as Success
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	select 0 as Success
END CATCH


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07332', GetDate())
GO
