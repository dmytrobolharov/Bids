IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialTradePartner_Print_SEL]'))
	DROP VIEW [dbo].[vwx_MaterialTradePartner_Print_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialTradePartner_Print_SEL]
AS
SELECT     a.MaterialTradePartnerId, a.SeasonYearID, a.MaterialId, a.MaterialTradePartnerCustom1, a.MaterialTradePartnerCustom3, b.MaterialType, 
                      b.MultiDimension, b.MaterialNo, b.MaterialName, b.A, b.D, b.E, b.O, b.J, b.S, b.Q, b.Source, b.R, b.H, b.I, b.K, b.N, b.M, b.T, b.P, b.U, b.UOM, b.W, b.X, 
                      b.Y, b.Z, b.V, b.VendorProductionMin, b.VendorProductionLeadTime, b.L, b.Notes, b.B, b.C, b.F, b.G
FROM         dbo.pMaterialTradePartner AS a WITH (NOLOCK) INNER JOIN
                      dbo.pMaterial AS b WITH (NOLOCK) ON a.MaterialId = b.MaterialID

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01983'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01983', GetDate())

END

GO



