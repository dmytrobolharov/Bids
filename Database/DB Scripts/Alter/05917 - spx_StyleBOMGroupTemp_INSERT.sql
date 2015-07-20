IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMGroupTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMGroupTemp_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[spx_StyleBOMGroupTemp_INSERT]
(@MainMaterial varchar(1),
@StyleID varchar(40),
@StyleMaterialID varchar(40),
@StyleSet varchar(1),
@MaterialCoreItemID varchar(40),
@WorkflowItemID nvarchar(40),
@WorkflowID nvarchar(40),
@StyleBOMDimensionId nvarchar(40),
@CreatedBy nvarchar(200),
@CreatedDate varchar(50),
@TradePartnerVendorID varchar(40) = NULL
)
AS 

DECLARE @TradePartnerID varchar(40)
DECLARE @MaterialID varchar(40) = '00000000-0000-0000-0000-000000000000'
DECLARE @Placement nvarchar(4000)
DECLARE @MaterialCount int
select @MaterialCount = COUNT(*) from pMaterialCoreItem WITH (NOLOCK) WHERE MaterialCoreItemID = @MaterialCoreItemID
IF @MaterialCount = 1
	BEGIN
		select @MaterialID = MaterialID, @Placement = Placement from pMaterialCoreItem WITH (NOLOCK) WHERE MaterialCoreItemID = @MaterialCoreItemID
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
    L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, MainMaterial, 
    StyleID, StyleMaterialID, StyleSet , UOM, WorkflowItemID, WorkflowID, StyleBOMDimensionId,
    TradePartnerID, TradePartnerVendorID)
SELECT     MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L,
    M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, @Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, 
    @CreatedBy AS MUser, MChange, DChange, Action, @MainMaterial AS MainMaterial, @StyleID AS StyleID, @StyleMaterialID AS StyleMaterialID, 
    @StyleSet AS StyleSet ,UOM, @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId,
    @TradePartnerID AS TradePartnerId, @TradePartnerVendorID AS TradePartnerVendorId
FROM  pMaterial WITH (NOLOCK)
WHERE (MaterialID = @MaterialID)



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05917', GetDate())
GO


