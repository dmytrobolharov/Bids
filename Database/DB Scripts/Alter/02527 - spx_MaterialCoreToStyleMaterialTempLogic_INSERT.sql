
/****** Object:  StoredProcedure [dbo].[spx_MaterialCoreToStyleMaterialTempLogic_INSERT]    Script Date: 12/30/2011 15:26:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreToStyleMaterialTempLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialCoreToStyleMaterialTempLogic_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreToStyleMaterialTempLogic_INSERT](
	@StyleID NVARCHAR(50),
	@StyleSet INT,
	@MaterialCoreItemID UNIQUEIDENTIFIER ,
	@Params NVARCHAR(4000),
	@CUser NVARCHAR(200) ,
	@CDate DATETIME
)
AS 


DECLARE @StyleMaterialID UNIQUEIDENTIFIER 
SET @StyleMaterialID  = NEWID()


INSERT INTO dbo.pStyleMaterialTemp(
	StyleMaterialID, MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, 
	L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,  Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
	MaterialPlacement, DetailYesNo, height, width, MChange, DChange, Ext, StyleID, StyleSet,
	CUser, CDate, MUser, MDate, MaterialCoreItemID
	--, UOM, Qty, MaterialPrice, MaterialSize, Placement, Artwork, License, Colorway,  MaterialSizeID 
)
SELECT     
	@StyleMaterialID AS StyleMaterialID, dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.NoColorMatch, dbo.pMaterial.SupplierID, 
	dbo.pMaterial.MaterialType, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.A, dbo.pMaterial.B, dbo.pMaterial.C, 
	dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, dbo.pMaterial.K, dbo.pMaterial.L, 
	dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, 
	dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.Source, 
	dbo.pMaterial.Notes, dbo.pMaterial.VendorPrice, dbo.pMaterial.VolumePrice, dbo.pMaterial.VolumePriceMinimum, dbo.pMaterial.VendorProductionMin, 
	dbo.pMaterial.VendorProductionLeadTime, dbo.pMaterial.MaterialPlacement, dbo.pMaterial.DetailYesNo, dbo.pMaterial.height, dbo.pMaterial.width, 
	dbo.pMaterial.MChange, dbo.pMaterial.DChange, dbo.pMaterialCoreItem.Ext, @StyleID, @StyleSet,
	dbo.pMaterialCoreItem.CUser, dbo.pMaterialCoreItem.CDate, dbo.pMaterialCoreItem.MUser, dbo.pMaterialCoreItem.MDate, @MaterialCoreItemID
	--,@UOM, @Qty, @MaterialPrice, @MaterialSize, @Placement, @Artwork, @License, @Colorway, @MaterialSizeID
FROM dbo.pMaterial WITH (NOLOCK) 
	INNER JOIN dbo.pMaterialCoreItem WITH (NOLOCK) ON dbo.pMaterial.MaterialID = dbo.pMaterialCoreItem.MaterialID
WHERE dbo.pMaterialCoreItem.MaterialCoreItemID = @MaterialCoreItemID


DECLARE @SQL NVARCHAR(4000)
SET @SQL  = 'UPDATE pStyleMaterialTemp SET ' + @Params + ' WHERE StyleMaterialID = ''' +  CAST(@StyleMaterialID AS NVARCHAR(50)) + ''''
EXEC (@SQL)

--** UPDATE MaterialSizeID
DECLARE @MaterialSizeID UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)

SELECT @MaterialSize = MaterialSize FROM pStyleMaterialTemp WITH(NOLOCK) WHERE  StyleMaterialID = @StyleMaterialID

SELECT @MaterialSizeID = b.MaterialSizeID
FROM pMaterialCoreItem a WITH(NOLOCK)
	INNER JOIN pMaterialSize b WITH(NOLOCK) ON a.MaterialID = b.MaterialID
WHERE MaterialCoreItemID = @MaterialCoreItemID
	AND b.MaterialSize = @MaterialSize

UPDATE pStyleMaterialTemp SET MaterialSizeID = @MaterialSizeID  WHERE StyleMaterialID = @StyleMaterialID

SET @SQL=NULL
SET @SQL  = 'UPDATE pMaterialCoreItem SET ' + @Params + ',MaterialSizeID = '+Convert(NVARCHAR(50),@MaterialSizeID)+' WHERE MaterialCoreItemID = ''' +  CAST(@MaterialCoreItemID AS NVARCHAR(50)) + ''''
EXEC (@SQL)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02527'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02527', GetDate())
END
GO