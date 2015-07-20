/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitNewTradePartner_SELECT]    Script Date: 01/09/2013 15:07:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitNewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitNewTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitNewTradePartner_SELECT]    Script Date: 01/09/2013 15:07:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitNewTradePartner_SELECT]
(@MaterialTradePartnerId UNIQUEIDENTIFIER)
AS 

SELECT  pMaterial.MaterialID, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, 
      pMaterial.MaterialNo, pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, 
      pMaterial.J, pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
      pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Notes, pMaterial.FactorySourced, pMaterial.MaterialType, pMaterial.MaterialColorRequired, 
      pMaterialTradePartner.MaterialTradePartnerId, pMaterialTradePartner.TradepartnerId, pMaterialTradePartner.TradepartnerVendorId, 
      pMaterialTradePartner.MaterialTradePartnerCustom1, pMaterialTradePartner.MaterialTradePartnerCustom2, pMaterialTradePartner.MaterialTradePartnerCustom3, 
      pMaterialTradePartner.MaterialTradePartnerCustom4, pMaterialTradePartner.MaterialTradePartnerCustom5, pMaterialTradePartner.MaterialTradePartnerCustom6, 
      pMaterialTradePartner.MaterialTradePartnerCustom7, pMaterialTradePartner.MaterialTradePartnerCustom8, pMaterialTradePartner.MaterialTradePartnerCustom9, 
      pMaterialTradePartner.MaterialTradePartnerCustom10, pMaterialTradePartner.MaterialTradePartnerCustom11, pMaterialTradePartner.MaterialTradePartnerCustom12, 
      pMaterialTradePartner.MaterialTradePartnerCustom13, pMaterialTradePartner.MaterialTradePartnerCustom14, pMaterialTradePartner.MaterialTradePartnerCustom15, 
      pMaterialTradePartner.MaterialTradePartnerCustom16, pMaterialTradePartner.MaterialTradePartnerCustom17, pMaterialTradePartner.MaterialTradePartnerCustom18, 
      pMaterialTradePartner.MaterialTradePartnerCustom19, pMaterialTradePartner.MaterialTradePartnerCustom20, pMaterialTradePartner.MaterialTradePartnerCustom21, 
      pMaterialTradePartner.MaterialTradePartnerCustom22, pMaterialTradePartner.MaterialTradePartnerCustom23, pMaterialTradePartner.MaterialTradePartnerCustom24, 
      pMaterialTradePartner.MaterialTradePartnerCustom25, pMaterialTradePartner.CDate, pMaterialTradePartner.CUser, pMaterialTradePartner.MDate, 
      pMaterialTradePartner.MUser, pMaterialTradePartner.MChange, pMaterialTradePartner.MaterialRequestWorkflowTempID, 
      uTradePartner.TradePartnerCode, uTradePartner.TradePartnerName
FROM  pMaterialTradePartner INNER JOIN
      uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID INNER JOIN
      pMaterial ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID
WHERE pMaterialTradePartner.MaterialTradePartnerId = @MaterialTradePartnerId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04733', GetDate())
GO
