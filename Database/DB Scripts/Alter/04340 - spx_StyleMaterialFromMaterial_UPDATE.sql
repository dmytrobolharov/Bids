/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialFromMaterial_UPDATE]    Script Date: 11/14/2012 14:17:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialFromMaterial_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialFromMaterial_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialFromMaterial_UPDATE]    Script Date: 11/14/2012 14:17:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleMaterialFromMaterial_UPDATE](
	@MaterialID UNIQUEIDENTIFIER, 
	@StyleMaterialID UNIQUEIDENTIFIER,
	@ModifiedBy NVARCHAR(200),
	@ModifiedDate DATETIME,
	@TeamID UNIQUEIDENTIFIER,
	@ChangeManagementEnabled INT
)
AS 

DECLARE 
	@StyleID UNIQUEIDENTIFIER,
	@LogChange INT,
	@MaterialImageID UNIQUEIDENTIFIER, 	@MaterialImageVersion INT,
	@SupplierID UNIQUEIDENTIFIER, 	@MaterialType INT,
	@MaterialNo NVARCHAR(50),	@MaterialName NVARCHAR(200),
	@A NVARCHAR(100), 	@B NVARCHAR(200),
	@C NVARCHAR(200),	@D NVARCHAR(200),
	@E NVARCHAR(200),	@F NVARCHAR(200),
	@G NVARCHAR(200),	@H NVARCHAR(200),
	@I NVARCHAR(200),	@J NVARCHAR(200), 
	@K NVARCHAR(200),	@L NVARCHAR(200),
	@M NVARCHAR(200),	@N NVARCHAR(200),
	@O NVARCHAR(200),	@P NVARCHAR(200),
	@Q NVARCHAR(200),	@R NVARCHAR(200),
	@S NVARCHAR(200),	@T NVARCHAR(200),
	@U NVARCHAR(200),	@V NVARCHAR(200),
	@X NVARCHAR(200),	@W NVARCHAR(200),
	@Y NVARCHAR(200),	@Z NVARCHAR(200),
	@Source NVARCHAR(200),	@Notes NVARCHAR(4000),
	@VendorPrice DECIMAL(19,3),	@VolumePrice DECIMAL(19,3), 
	@VolumePriceMinimum NVARCHAR(50),	@VendorProductionMin NVARCHAR(50),
	@VendorProductionLeadTime NVARCHAR(50),	@DetailYesNo INT,
	@UOM NVARCHAR(50), @MChange int


	SET @LogChange = 0 

	--** Check techpack
	IF EXISTS( SELECT * 
		FROM dbo.pStyleMaterials a 
			INNER JOIN dbo.pStyleHeader b ON a.StyleID = b.StyleID 
			INNER JOIN dbo.pTechPack c ON b.TechPackId = c.TechPackID 
		WHERE a.StyleMaterialID = @StyleMaterialID ) AND @ChangeManagementEnabled = 1
	BEGIN 
	
		
		SELECT @MaterialImageID = MaterialImageID ,  @MaterialImageVersion = MaterialImageVersion, 
			@SupplierID = SupplierID, @MaterialType = MaterialType, 
			@MaterialNo = MaterialNo, @MaterialName = MaterialName, 
			@A = A, @B = B, 
			@C = C, @D = D, 
			@E = E, @F = F, 
			@G = G, @H = H, 
			@I = I, @J = J, 
			@K = K, @L = L, 
			@M = M, @N = N, 
			@O = O, @P = P, 
			@Q = Q, @R = R, 
			@S = S, @T = T,
			@U = U, @V = V,
			@X = X,	@W = W,
			@Y = Y,	@Z = Z,
			@Source = Source,  @Notes = Notes, 
			@VendorPrice = VendorPrice, @VolumePrice = VolumePrice, 
			@VolumePriceMinimum = VolumePriceMinimum, 	@VendorProductionMin = VendorProductionMin, 
			@VendorProductionLeadTime = VendorProductionLeadTime, @DetailYesNo = DetailYesNo, 
			@MChange = MChange, @UOM = UOM,
			@StyleID = StyleID
		FROM dbo.pStyleMaterials
		WHERE StyleMaterialID = @StyleMaterialID
			
		SET @LogChange = 1 
	END 



 
 BEGIN
	UPDATE pStyleMaterials
	SET 
		pStyleMaterials.MaterialImageID = pMaterial.MaterialImageID , 
		pStyleMaterials.MaterialImageVersion = pMaterial.MaterialImageVersion, 
		pStyleMaterials.SupplierID = pMaterial.SupplierID, 
		pStyleMaterials.MaterialType = pMaterial.MaterialType, 
		pStyleMaterials.MaterialNo = pMaterial.MaterialNo, 
		pStyleMaterials.MaterialName = pMaterial.MaterialName, 
		pStyleMaterials.A = pMaterial.A, 
		pStyleMaterials.B = pMaterial.B, 
		pStyleMaterials.C = pMaterial.C, 
		pStyleMaterials.D = pMaterial.D, 
		pStyleMaterials.E = pMaterial.E, 
		pStyleMaterials.F = pMaterial.F, 
		pStyleMaterials.G = pMaterial.G, 
		pStyleMaterials.H = pMaterial.H, 
		pStyleMaterials.I = pMaterial.I, 
		pStyleMaterials.J = pMaterial.J, 
		pStyleMaterials.K = pMaterial.K, 
		pStyleMaterials.L = pMaterial.L, 
		pStyleMaterials.M = pMaterial.M, 
		pStyleMaterials.N = pMaterial.N, 
		pStyleMaterials.O = pMaterial.O, 
		pStyleMaterials.P = pMaterial.P, 
		pStyleMaterials.Q = pMaterial.Q, 
		pStyleMaterials.R = pMaterial.R, 
		pStyleMaterials.S = pMaterial.S, 
		pStyleMaterials.T = pMaterial.T,
		pStyleMaterials.U = pMaterial.U,
		pStyleMaterials.V = pMaterial.V,
		pStyleMaterials.X = pMaterial.X,
		pStyleMaterials.W = pMaterial.W,
		pStyleMaterials.Y = pMaterial.Y,
		pStyleMaterials.Z = pMaterial.Z,
		pStyleMaterials.Source = pMaterial.Source, 
		pStyleMaterials.Notes = pMaterial.Notes, 
		pStyleMaterials.VendorPrice = pMaterial.VendorPrice, 
		pStyleMaterials.VolumePrice = pMaterial.VolumePrice, 
		pStyleMaterials.VolumePriceMinimum = pMaterial.VolumePriceMinimum, 
		pStyleMaterials.VendorProductionMin = pMaterial.VendorProductionMin, 
		pStyleMaterials.VendorProductionLeadTime = pMaterial.VendorProductionLeadTime, 
		pStyleMaterials.DetailYesNo = pMaterial.DetailYesNo, 
		pStyleMaterials.MDate = @ModifiedDate, 
		pStyleMaterials.MUser = @ModifiedBy, 
		pStyleMaterials.MChange = pMaterial.MChange , 
		pStyleMaterials.UOM = pMaterial.UOM
	FROM  pMaterial INNER JOIN
       pStyleMaterials ON pMaterial.MaterialID = pStyleMaterials.MaterialID
	WHERE pStyleMaterials.StyleMaterialID = @StyleMaterialID 
	
	/*** Update BOM ***/
	UPDATE pStyleBOM SET
		pStyleBOM.MaterialNo = pMaterial.MaterialNo,
		pStyleBOM.MaterialName = pMaterial.MaterialName,
		pStyleBOM.MaterialCode = pMaterial.MaterialCode,
		pStyleBOM.MaterialImageID = pMaterial.MaterialImageID,
		pstyleBOM.MaterialImageVersion = pMaterial.MaterialImageVersion
	FROM pMaterial 
	INNER JOIN pStyleBOM ON pMaterial.MaterialID = pStyleBOM.MaterialID
	WHERE pStyleBOM.StyleMaterialID = @StyleMaterialID
END	


--**  If material is the Main Material, Update pStyleHeader
BEGIN
	IF((SELECT MainMaterial FROM pStyleMaterials WITH (NOLOCK) WHERE StyleMaterialID = @StyleMaterialID) = 1)
		BEGIN
			UPDATE pStyleHeader
			SET pStyleHeader.StyleMaterialID = pStyleMaterials.StyleMaterialID		
				,pStyleHeader.MaterialImageID = pStyleMaterials.MaterialImageID		
				,pStyleHeader.MaterialImageVersion = pStyleMaterials.MaterialImageVersion		
				,pStyleHeader.MaterialID = pStyleMaterials.MaterialID		
				,pStyleHeader.MaterialNo = pStyleMaterials.MaterialNo		
				,pStyleHeader.MaterialName = pStyleMaterials.MaterialName
			FROM pStyleHeader INNER JOIN pStyleMaterials ON
			pStyleHeader.StyleID = pStyleMaterials.StyleID
			WHERE pStyleMaterials.StyleMaterialID = @StyleMaterialID
			AND pStyleMaterials.MainMaterial = 1
		END
END


IF @LogChange = 1 
BEGIN 

DECLARE 
	@nMaterialImageID UNIQUEIDENTIFIER, 	@nMaterialImageVersion INT,
	@nSupplierID UNIQUEIDENTIFIER, 	@nMaterialType INT,
	@nMaterialNo NVARCHAR(50),	@nMaterialName NVARCHAR(200),
	@nA NVARCHAR(100), 	@nB NVARCHAR(200),
	@nC NVARCHAR(200),	@nD NVARCHAR(200),
	@nE NVARCHAR(200),	@nF NVARCHAR(200),
	@nG NVARCHAR(200),	@nH NVARCHAR(200),
	@nI NVARCHAR(200),	@nJ NVARCHAR(200), 
	@nK NVARCHAR(200),	@nL NVARCHAR(200),
	@nM NVARCHAR(200),	@nN NVARCHAR(200),
	@nO NVARCHAR(200),	@nP NVARCHAR(200),
	@nQ NVARCHAR(200),	@nR NVARCHAR(200),
	@nS NVARCHAR(200),	@nT NVARCHAR(200),
	@nU NVARCHAR(200),	@nV NVARCHAR(200),
	@nX NVARCHAR(200),	@nW NVARCHAR(200),
	@nY NVARCHAR(200),	@nZ NVARCHAR(200),
	@nSource NVARCHAR(200),	@nNotes NVARCHAR(4000),
	@nVendorPrice DECIMAL(19,3),	@nVolumePrice DECIMAL(19,3), 
	@nVolumePriceMinimum NVARCHAR(50),	@nVendorProductionMin NVARCHAR(50),
	@nVendorProductionLeadTime NVARCHAR(50),	@nDetailYesNo INT,
	@nUOM NVARCHAR(50), @nMChange INT
	
	
	SELECT @nMaterialImageID = MaterialImageID ,  @nMaterialImageVersion = MaterialImageVersion, 
			@nSupplierID = SupplierID, @nMaterialType = MaterialType, 
			@nMaterialNo = MaterialNo, @nMaterialName = MaterialName, 
			@nA = A, @nB = B, 
			@nC = C, @nD = D, 
			@nE = E, @nF = F, 
			@nG = G, @nH = H, 
			@nI = I, @nJ = J, 
			@nK = K, @nL = L, 
			@nM = M, @nN = N, 
			@nO = O, @nP = P, 
			@nQ = Q, @nR = R, 
			@nS = S, @nT = T,
			@nU = U, @nV = V,
			@nX = X,	@nW = W,
			@nY = Y,	@nZ = Z,
			@nSource = Source,  @nNotes = Notes, 
			@nVendorPrice = VendorPrice, @nVolumePrice = VolumePrice, 
			@nVolumePriceMinimum = VolumePriceMinimum, 	@nVendorProductionMin = VendorProductionMin, 
			@nVendorProductionLeadTime = VendorProductionLeadTime, @nDetailYesNo = DetailYesNo, 
			@nMChange = MChange, @nUOM = UOM
	FROM dbo.pStyleMaterials
	WHERE StyleMaterialID = @StyleMaterialID
		
		
	DECLARE 
		@ChangeLogID UNIQUEIDENTIFIER,
		@ChangeTransID UNIQUEIDENTIFIER,
		@pBefore NVARCHAR(40),
		@pAfter NVARCHAR(40)
	
	SET @ChangeTransID =  NEWID()

	--** Insert Transaction 
	INSERT INTO pChangeTransaction( ChangeTransID, ChangeTransPageName , 
		ChangeTransTableID, ChangeTransTablePKID, ChangeTransUserID, ChangeTransDate, ChangeTransTypeID) 
	VALUES( @ChangeTransID, 'ASP.Material_Wizard_Style_Update.aspx', 
		'D612FAAE-7ACD-DF11-AF06-005056C00008', @StyleID, @TeamID, @ModifiedDate,0 )  -- ** ChangeTransTypeID=1 FOR UPDATE

				
	EXECUTE spx_ChangeLog_INSERTID
		@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008',
		@changeTransId = @ChangeTransID,
		@changeTablePKId = @StyleMaterialID,
		@changeUserId = @TeamID, 
		@ChangeUserName = @ModifiedBy,
		@changeDate = @ModifiedDate,
		@changeSort = '0000',
		@ShowResult = 0,
		@ChangeLogID = @ChangeLogID OUTPUT	
			
	IF @nMaterialImageID <> @MaterialImageID 
	BEGIN
		
		SET @pBefore = CAST( @MaterialImageID AS NVARCHAR(40))
		SET @pAfter = CAST( @nMaterialImageID AS NVARCHAR(40))
		
		-- Material Image
		EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,
			@ChangeSort = '0001',
			@ChangeFieldName = 'MaterialImageID',@ChangeFieldAlias = 'MaterialImageID',
			@ChangeBeforeValue = @pBefore, @ChangeAfterValue = @pAfter,
			@ChangeBeforeText = @pBefore, @ChangeAfterText = @pAfter
	END 
		
		
	IF @nMaterialImageVersion <> @MaterialImageVersion 
	BEGIN
		-- Material Image version
		EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,
			@ChangeSort = '0001',
			@ChangeFieldName = 'MaterialImageVersion',@ChangeFieldAlias = 'MaterialImageVersion',
			@ChangeBeforeValue = @MaterialImageVersion, @ChangeAfterValue = @nMaterialImageVersion,
			@ChangeBeforeText = @MaterialImageVersion, @ChangeAfterText = @nMaterialImageVersion
	END 
		

	IF @nMaterialNo <> @MaterialNo 
	BEGIN
		-- Material No
		EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,
			@ChangeSort = '0001',
			@ChangeFieldName = 'MaterialNo',@ChangeFieldAlias = 'MaterialNo',
			@ChangeBeforeValue = @MaterialNo, @ChangeAfterValue = @nMaterialNo,
			@ChangeBeforeText = @MaterialNo, @ChangeAfterText = @nMaterialNo
	END 
		
	IF @nMaterialName <> @MaterialName 
	BEGIN
		-- Material Name
		EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,
			@ChangeSort = '0001',
			@ChangeFieldName = 'MaterialName',@ChangeFieldAlias = 'MaterialName',
			@ChangeBeforeValue = @MaterialName, @ChangeAfterValue = @nMaterialName,
			@ChangeBeforeText = @MaterialName, @ChangeAfterText = @nMaterialName
	END 
		
		
	IF @nUOM <> @UOM 
	BEGIN
		-- UOM
		EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,
			@ChangeSort = '0001',
			@ChangeFieldName = 'UOM',@ChangeFieldAlias = 'UOM',
			@ChangeBeforeValue = @UOM, @ChangeAfterValue = @nUOM,
			@ChangeBeforeText = @UOM, @ChangeAfterText = @nUOM
	END 
		 

	IF @nJ<> @J 
	BEGIN
		-- Material Composition
		EXECUTE spx_ChangeLogItem_INSERT @ChangeLogID = @ChangeLogID, @ChangeTransID = @ChangeTransID,
			@ChangeSort = '0001',
			@ChangeFieldName = 'J',@ChangeFieldAlias = 'Composition',
			@ChangeBeforeValue = @J, @ChangeAfterValue = @nJ,
			@ChangeBeforeText = @J, @ChangeAfterText = @nJ
	END 
		
	IF NOT EXISTS ( SELECT  * FROM dbo.pChangeLogItem WHERE ChangeLogID = @ChangeLogID )
		DELETE FROM dbo.pChangeTransaction WHERE  ChangeTransID = @ChangeTransID

END 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04340', GetDate())
GO
