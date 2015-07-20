IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMTemp_INSERTQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMTemp_INSERTQE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOMTemp_INSERTQE]
(@StyleID nvarchar(50),
@StyleSet int,
@MaterialID nvarchar(50),
@WorkflowItemID nvarchar(50),
@WorkflowID nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@CreatedBy nvarchar(200),
@CreatedDate DateTime,
@TradePartnerVendorID nvarchar(50) = NULL
)

AS 



DECLARE @TradePartnerID nvarchar(50)
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
    L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, MainMaterial, 
    StyleID,  StyleSet , UOM, WorkflowItemID, WorkflowID, StyleBOMDimensionId,
    TradePartnerID, TradePartnerVendorID, QuickAdd)
SELECT     MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L,
    M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
    VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, 
    @CreatedBy AS MUser, MChange, DChange, Action, 0 AS MainMaterial, @StyleID AS StyleID, 
    @StyleSet AS StyleSet ,UOM, @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId,
    @TradePartnerID AS TradePartnerId, @TradePartnerVendorID AS TradePartnerVendorId, 1  AS QuickAdd
FROM  pMaterial WITH (NOLOCK)
WHERE (MaterialID = @MaterialID)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03095'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03095', GetDate())

END

GO