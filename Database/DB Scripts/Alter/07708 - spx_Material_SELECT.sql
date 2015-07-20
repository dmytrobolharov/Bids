IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Material_SELECT](@MaterialID uniqueidentifier)
AS 

SELECT ComponentDescription ,  MaterialID, TempID, TempNo, MaterialImageID, MaterialImageVersion, MaterialImageDetailID, MaterialImageDetailVersion, NoColorMatch, SupplierID, MaterialType, MaterialNo, 
   MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
   VendorProductionLeadTime, MaterialPlacement, DetailYesNo, ImageType1, height, width, a.CDate, a.CUser, a.MDate, a.MUser, MChange, DChange, Action, Status, a.Active, MultiDimension, 
   UOM, MaterialCode, MaterialCodeNo, SAPCode, SAPControl, MaterialColorRequired, FactorySourced, TradePartnerID, TradePartnerVendorID, HeaderLocked, MaterialTemplateID
FROM   pMaterial a WITH (NOLOCK) ,  pComponentType b WITH (NOLOCK)
WHERE     a.MaterialID = @MaterialID 
AND a.MaterialType = b.ComponentTypeID 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07708', GetDate())
GO
