/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_MaterialReplace_UPDATE]    Script Date: 06/05/2013 14:45:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_MaterialReplace_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_MaterialReplace_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_MaterialReplace_UPDATE]    Script Date: 06/05/2013 14:45:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_MaterialReplace_UPDATE]
	-- Add the parameters for the stored procedure here
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@NewMaterialID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@ReplaceAll INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @ReplaceAll = 0
	BEGIN
	
		UPDATE pStyleBOM
		SET MaterialID = tbl.MaterialID, 
			MaterialImageID = tbl.MaterialImageID, 
			MaterialImageVersion = tbl.MaterialImageVersion, 
			NoColorMatch = tbl.NoColorMatch, 
			SupplierID = tbl.SupplierID, 
			MaterialType = tbl.MaterialType, 
			MaterialNo = tbl.MaterialNo, 
			MaterialName = tbl.MaterialName, 
			A = tbl.A, 
			B = tbl.B, 
			C = tbl.C, 
			D = tbl.D, 
			E = tbl.E, 
			F = tbl.F, 
			G = tbl.G, 
			H = tbl.H, 
			I = tbl.I, 
			J = tbl.J, 
			K = tbl.K, 
			L = tbl.L,
			M = tbl.M, 
			N = tbl.N, 
			O = tbl.O, 
			P = tbl.P, 
			Q = tbl.Q, 
			R = tbl.R, 
			S = tbl.S, 
			T = tbl.T, 
			U = tbl.U, 
			V = tbl.V, 
			W = tbl.W, 
			X = tbl.X, 
			Y = tbl.Y, 
			Z = tbl.Z, 
			[Source] = tbl.[Source], 
			Notes = tbl.Notes, 
			VendorPrice = tbl.VendorPrice, 
			VolumePrice = tbl.VolumePrice, 
			VolumePriceMinimum = tbl.VolumePriceMinimum, 
			VendorProductionMin = tbl.VendorProductionMin, 
			VendorProductionLeadTime = tbl.VendorProductionLeadTime, 
			MaterialPlacement = tbl.MaterialPlacement, 
			DetailYesNo = tbl.DetailYesNo, 
			height = tbl.height, 
			width = tbl.width,
			MDate = @MDate,
			MUser = @MUser
		FROM 
		(
			SELECT * FROM pMaterial WHERE MaterialID = @NewMaterialID
		) tbl
		WHERE StyleMaterialID = @StyleMaterialID AND StyleBOMDimensionId = @StyleBOMDimensionID
	
	END
	ELSE
	BEGIN
		
		DECLARE @OldMaterialID UNIQUEIDENTIFIER
		SELECT @OldMaterialID = MaterialID FROM pStyleBOM WHERE StyleMaterialID = @StyleMaterialID
		
		UPDATE pStyleBOM
		SET MaterialID = tbl.MaterialID, 
			MaterialImageID = tbl.MaterialImageID, 
			MaterialImageVersion = tbl.MaterialImageVersion, 
			NoColorMatch = tbl.NoColorMatch, 
			SupplierID = tbl.SupplierID, 
			MaterialType = tbl.MaterialType, 
			MaterialNo = tbl.MaterialNo, 
			MaterialName = tbl.MaterialName, 
			A = tbl.A, 
			B = tbl.B, 
			C = tbl.C, 
			D = tbl.D, 
			E = tbl.E, 
			F = tbl.F, 
			G = tbl.G, 
			H = tbl.H, 
			I = tbl.I, 
			J = tbl.J, 
			K = tbl.K, 
			L = tbl.L,
			M = tbl.M, 
			N = tbl.N, 
			O = tbl.O, 
			P = tbl.P, 
			Q = tbl.Q, 
			R = tbl.R, 
			S = tbl.S, 
			T = tbl.T, 
			U = tbl.U, 
			V = tbl.V, 
			W = tbl.W, 
			X = tbl.X, 
			Y = tbl.Y, 
			Z = tbl.Z, 
			[Source] = tbl.[Source], 
			Notes = tbl.Notes, 
			VendorPrice = tbl.VendorPrice, 
			VolumePrice = tbl.VolumePrice, 
			VolumePriceMinimum = tbl.VolumePriceMinimum, 
			VendorProductionMin = tbl.VendorProductionMin, 
			VendorProductionLeadTime = tbl.VendorProductionLeadTime, 
			MaterialPlacement = tbl.MaterialPlacement, 
			DetailYesNo = tbl.DetailYesNo, 
			height = tbl.height, 
			width = tbl.width,
			MDate = @MDate,
			MUser = @MUser
		FROM 
		(
			SELECT * FROM pMaterial WHERE MaterialID = @NewMaterialID
		) tbl
		WHERE pStyleBOM.MaterialID = @OldMaterialID AND StyleBOMDimensionId = @StyleBOMDimensionID
	
	END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05810', GetDate())
GO
