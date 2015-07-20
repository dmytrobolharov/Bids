/****** Object:  StoredProcedure [dbo].[spx_StyleBOMTemp_INSERT]    Script Date: 09/06/2011 11:30:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMTemp_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMTemp_INSERT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[spx_StyleBOMTemp_INSERT]
(@MainMaterial varchar(1),
@StyleID varchar(40),
@StyleMaterialID varchar(40),
@StyleSet varchar(1),
@MaterialID varchar(40),
@WorkflowItemID nvarchar(40),
@WorkflowID nvarchar(40),
@StyleBOMDimensionId nvarchar(40),
@CreatedBy varchar(200),
@CreatedDate varchar(50),
@TradePartnerVendorID varchar(40) = NULL
)
AS 

DECLARE @TradePartnerID varchar(40)
IF @TradePartnerVendorID = '00000000-0000-0000-0000-000000000000' OR @TradePartnerVendorID = ''
	BEGIN
		SELECT @TradePartnerID = NULL, @TradePartnerVendorID = NULL  
	END
ELSE
	BEGIN
		SELECT @TradePartnerID = TradePartnerID FROM uTradePartnerVendor WHERE TradePartnerVendorID = @TradePartnerVendorID
	END

SELECT @TradePartnerID


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

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01859'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01859', GetDate())
END

GO