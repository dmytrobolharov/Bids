IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialTemp_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialTemp_INSERT]
(@MainMaterial varchar(1),
@StyleID varchar(40),
@StyleMaterialID varchar(40),
@StyleSet varchar(1),
@MaterialID varchar(40),
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

--SELECT @TradePartnerID

BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO pStyleMaterialTemp
			(MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, 
			L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
			VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, MainMaterial, 
			StyleID, StyleMaterialID, StyleSet , UOM, TradePartnerID, TradePartnerVendorID)
		SELECT     MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L,
			M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
			VendorProductionLeadTime, MaterialPlacement, DetailYesNo, height, width, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, 
			@CreatedBy AS MUser, MChange, DChange, Action, @MainMaterial AS MainMaterial, @StyleID AS StyleID, @StyleMaterialID AS StyleMaterialID, 
			@StyleSet AS StyleSet ,UOM, @TradePartnerID AS TradePartnerId, @TradePartnerVendorID AS TradePartnerVendorId
		FROM  pMaterial WITH (NOLOCK)
		WHERE (MaterialID = @MaterialID)

	COMMIT TRANSACTION
	select 1 as Success
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	select 0 as Success
END CATCH

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05530', GetDate())
GO

