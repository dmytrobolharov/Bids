IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMGroupTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMGroupTemp_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_StyleBOMGroupTemp_INSERT]
(@MainMaterial nvarchar(1),
@StyleID nvarchar(40),
@StyleMaterialID nvarchar(40),
@StyleSet nvarchar(1),
@MaterialCoreItemID nvarchar(40),
@WorkflowItemID nvarchar(40),
@WorkflowID nvarchar(40),
@StyleBOMDimensionId nvarchar(40),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(50),
@TradePartnerVendorID nvarchar(40) = NULL
)
AS 

DECLARE @TradePartnerID nvarchar(40)
DECLARE @MaterialID nvarchar(40) = '00000000-0000-0000-0000-000000000000'
DECLARE @QTY nvarchar(18)
DECLARE @Placement nvarchar(4000)
DECLARE @MaterialCount int
select @MaterialCount = COUNT(*) from pMaterialCoreItem WITH (NOLOCK) WHERE MaterialCoreItemID = @MaterialCoreItemID
IF @MaterialCount = 1
	BEGIN
		select @MaterialID = MaterialID, @QTY = Qty, @Placement = Placement from pMaterialCoreItem WITH (NOLOCK) WHERE MaterialCoreItemID = @MaterialCoreItemID
	END
	
IF @TradePartnerVendorID = '00000000-0000-0000-0000-000000000000' OR @TradePartnerVendorID = ''
	BEGIN
		SELECT @TradePartnerID = NULL, @TradePartnerVendorID = NULL  
	END
ELSE
	BEGIN
		SELECT @TradePartnerID = TradePartnerID FROM uTradePartnerVendor WHERE TradePartnerVendorID = @TradePartnerVendorID
	END

--SELECT @TradePartnerID


INSERT INTO pStyleBOMTemp
    (MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, 
    L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Qty, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, MainMaterial, 
    StyleID, StyleMaterialID, StyleSet , UOM, WorkflowItemID, WorkflowID, StyleBOMDimensionId,
    TradePartnerID, TradePartnerVendorID)
SELECT     MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L,
    M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, @QTY, @Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, 
    @CreatedBy AS MUser, MChange, DChange, Action, @MainMaterial AS MainMaterial, @StyleID AS StyleID, @StyleMaterialID AS StyleMaterialID, 
    @StyleSet AS StyleSet ,UOM, @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId,
    @TradePartnerID AS TradePartnerId, @TradePartnerVendorID AS TradePartnerVendorId
FROM  pMaterial WITH (NOLOCK)
WHERE (MaterialID = @MaterialID)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06337', GetDate())
GO