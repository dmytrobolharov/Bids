/****** Object:  StoredProcedure [dbo].[spx_StyleMaterial_ReplaceBOM_UPDATE]    Script Date: 12/07/2012 13:16:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_ReplaceBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterial_ReplaceBOM_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterial_ReplaceBOM_UPDATE]    Script Date: 12/07/2012 13:16:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterial_ReplaceBOM_UPDATE](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@NewMaterialID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS
BEGIN

	UPDATE pStyleBOM SET MaterialID = @NewMaterialID
	WHERE StyleMaterialID = @StyleMaterialID

	UPDATE pStyleBOM
	SET 
	MaterialCode = mat.MaterialCode, MaterialNo = mat.MaterialNo, MaterialName = mat.MaterialName, 
	MaterialImageID = mat.MaterialImageID, MaterialImageVersion = mat.MaterialImageVersion, MaterialType = mat.MaterialType,
	VendorPrice = mat.VendorPrice, VolumePrice = mat.VolumePrice, VolumePriceMinimum = mat.VolumePriceMinimum,
	VendorProductionMin = mat.VendorProductionMin, VendorProductionLeadTime = mat.VendorProductionLeadTime,
	SupplierID = mat.SupplierID, NoColorMatch = mat.NoColorMatch, [Source] = mat.[Source],
	Notes = mat.Notes, DetailYesNo = mat.DetailYesNo, height = mat.height, width = mat.width,
	TradePartnerID = mat.TradePartnerID, TradePartnerVendorID = mat.TradePartnerVendorID,
	UOM = mat.UOM, MChange = mat.MChange,
	A = mat.A, B = mat.B, C = mat.C, D = mat.D, E = mat.E, F = mat.F, G = mat.G, H = mat.H,
	I = mat.I, J = mat.J, K = mat.K, L = mat.L, M = mat.M, N = mat.N, O = mat.O, P = mat.P,
	Q = mat.Q, R = mat.R, S = mat.S, T = mat.T, U = mat.U, V = mat.V, W = mat.W, X = mat.X,
	Y = mat.Y, Z = mat.Z, MUser = @MUser, MDate = @MDate
	FROM pStyleBOM
	INNER JOIN pMaterial mat ON pStyleBOM.MaterialID = mat.MaterialID
	WHERE StyleMaterialID = @StyleMaterialID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04578', GetDate())
GO
