IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BOMMaterialCoreToStyleMaterialTempLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BOMMaterialCoreToStyleMaterialTempLogic_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BOMMaterialCoreToStyleMaterialTempLogic_INSERT](
	@MainMaterial nvarchar(1),
	@StyleID nvarchar(40),
	@StyleMaterialID nvarchar(40),
	@StyleSet nvarchar(1),
	@MaterialCoreItemID nvarchar(40),
	@WorkflowItemID nvarchar(40),
	@WorkflowID nvarchar(40),
	@StyleBOMDimensionId nvarchar(40),
	@CreatedBy nvarchar(200),
	@CreatedDate nvarchar(50),
	@TradePartnerVendorID nvarchar(40) = NULL,
	@FilterUpdate NVARCHAR(max)
)
AS
 
DECLARE @TradePartnerID nvarchar(40)
IF @TradePartnerVendorID = '00000000-0000-0000-0000-000000000000' OR @TradePartnerVendorID = ''
	BEGIN
		SELECT @TradePartnerID = NULL, @TradePartnerVendorID = NULL  
	END
ELSE
	BEGIN
		SELECT @TradePartnerID = TradePartnerID FROM uTradePartnerVendor WHERE TradePartnerVendorID = @TradePartnerVendorID
	END

DECLARE @MaterialID nvarchar(40)

SELECT @MaterialID = MaterialID FROM pMaterialCoreItem WHERE MaterialCoreItemID = @MaterialCoreItemID


INSERT INTO pStyleBOMTemp
    (MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, 
    L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, MainMaterial, 
    StyleID, StyleMaterialID, StyleSet , UOM, WorkflowItemID, WorkflowID, StyleBOMDimensionId,
    TradePartnerID, TradePartnerVendorID)
SELECT     MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L,
    M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, 
    @CreatedBy AS MUser, MChange, DChange, Action, @MainMaterial AS MainMaterial, @StyleID AS StyleID, @StyleMaterialID AS StyleMaterialID, 
    @StyleSet AS StyleSet ,UOM, @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId,
    @TradePartnerID AS TradePartnerId, @TradePartnerVendorID AS TradePartnerVendorId
FROM  pMaterial WITH (NOLOCK)
WHERE (MaterialID = @MaterialID)

DECLARE @SQL NVARCHAR(4000)
IF @FilterUpdate IS NOT NULL
BEGIN
	SET @SQL  = 'UPDATE pStyleBOMTemp SET ' + @FilterUpdate + ' WHERE StyleMaterialID = ''' +  CAST(@StyleMaterialID AS NVARCHAR(50)) + ''''
	EXEC (@SQL)
END
ELSE
BEGIN
	UPDATE pStyleBOMTemp SET 
		MaterialSize = pMaterialCoreItem.MaterialSize, 
		Qty = pMaterialCoreItem.Qty, 
		UOM = pMaterialCoreItem.UOM, 
		MaterialPrice = pMaterialCoreItem.MaterialPrice, 
		Colorway = pMaterialCoreItem.Colorway, 
		Artwork = pMaterialCoreItem.Artwork, 
		License = pMaterialCoreItem.License, 
		Placement = pMaterialCoreItem.Placement
	FROM pMaterialCoreItem WHERE pMaterialCoreItem.MaterialCoreItemID = @MaterialCoreItemID
END

--** UPDATE MaterialSizeID
DECLARE @MaterialSizeID UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)

SELECT @MaterialSize = MaterialSize FROM pStyleBOMTemp WITH(NOLOCK) WHERE  StyleMaterialID = @StyleMaterialID

SELECT @MaterialSizeID = b.MaterialSizeID
FROM pMaterialCoreItem a WITH(NOLOCK)
	INNER JOIN pMaterialSize b WITH(NOLOCK) ON a.MaterialID = b.MaterialID
WHERE MaterialCoreItemID = @MaterialCoreItemID
	AND b.MaterialSize = @MaterialSize

UPDATE pStyleBOMTemp SET MaterialSizeID = @MaterialSizeID  WHERE StyleMaterialID = @StyleMaterialID

IF @FilterUpdate IS NOT NULL
BEGIN
	SET @SQL=NULL
	SET @SQL  = 'UPDATE pMaterialCoreItem SET ' + @FilterUpdate + ' WHERE MaterialCoreItemID = ''' +  CAST(@MaterialCoreItemID AS NVARCHAR(50)) + ''''
	EXEC (@SQL)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06377', GetDate())
GO
