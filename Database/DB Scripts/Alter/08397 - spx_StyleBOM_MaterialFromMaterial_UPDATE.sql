IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_MaterialFromMaterial_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_MaterialFromMaterial_UPDATE]
GO

Create PROCEDURE [dbo].[spx_StyleBOM_MaterialFromMaterial_UPDATE](
	@MaterialID UNIQUEIDENTIFIER, 
	@StyleMaterialID UNIQUEIDENTIFIER,
	@ModifiedBy NVARCHAR(200),
	@ModifiedDate DATETIME,
	@TeamID UNIQUEIDENTIFIER,
	@ChangeManagementEnabled INT
)
AS 

	UPDATE pStyleBOM
	SET 
		pStyleBOM.MaterialImageID = pMaterial.MaterialImageID , 
		pStyleBOM.MaterialImageVersion = pMaterial.MaterialImageVersion, 
		pStyleBOM.SupplierID = pMaterial.SupplierID, 
		pStyleBOM.MaterialType = pMaterial.MaterialType, 
		pStyleBOM.MaterialNo = pMaterial.MaterialNo, 
		pStyleBOM.MaterialName = pMaterial.MaterialName, 
		pStyleBOM.A = pMaterial.A, 
		pStyleBOM.B = pMaterial.B, 
		pStyleBOM.C = pMaterial.C, 
		pStyleBOM.D = pMaterial.D, 
		pStyleBOM.E = pMaterial.E, 
		pStyleBOM.F = pMaterial.F, 
		pStyleBOM.G = pMaterial.G, 
		pStyleBOM.H = pMaterial.H, 
		pStyleBOM.I = pMaterial.I, 
		pStyleBOM.J = pMaterial.J, 
		pStyleBOM.K = pMaterial.K, 
		pStyleBOM.L = pMaterial.L, 
		pStyleBOM.M = pMaterial.M, 
		pStyleBOM.N = pMaterial.N, 
		pStyleBOM.O = pMaterial.O, 
		pStyleBOM.P = pMaterial.P, 
		pStyleBOM.Q = pMaterial.Q, 
		pStyleBOM.R = pMaterial.R, 
		pStyleBOM.S = pMaterial.S, 
		pStyleBOM.T = pMaterial.T,
		pStyleBOM.U = pMaterial.U,
		pStyleBOM.V = pMaterial.V,
		pStyleBOM.X = pMaterial.X,
		pStyleBOM.W = pMaterial.W,
		pStyleBOM.Y = pMaterial.Y,
		pStyleBOM.Z = pMaterial.Z,
		pStyleBOM.Source = pMaterial.Source, 
		pStyleBOM.Notes = pMaterial.Notes, 
		pStyleBOM.VendorPrice = pMaterial.VendorPrice, 
		pStyleBOM.VolumePrice = pMaterial.VolumePrice, 
		pStyleBOM.VolumePriceMinimum = pMaterial.VolumePriceMinimum, 
		pStyleBOM.VendorProductionMin = pMaterial.VendorProductionMin, 
		pStyleBOM.VendorProductionLeadTime = pMaterial.VendorProductionLeadTime, 
		pStyleBOM.DetailYesNo = pMaterial.DetailYesNo, 
		pStyleBOM.MDate = @ModifiedDate, 
		pStyleBOM.MUser = @ModifiedBy, 
		pStyleBOM.MChange = pMaterial.MChange , 
		pStyleBOM.UOM = pMaterial.UOM
	FROM  pMaterial INNER JOIN
       pStyleBOM ON pMaterial.MaterialID = pStyleBOM.MaterialID
	WHERE pStyleBOM.StyleMaterialID IN (
		SELECT StyleMaterialID 
		FROM pStyleBOM
		WHERE StyleBOMDimensionId = (
			SELECT StyleBOMDimensionId 
			FROM pstylebom
			WHERE StyleMaterialID = @StyleMaterialID)
		AND MaterialID = (
			SELECT MaterialID 
			FROM pstylebom
			WHERE StyleMaterialID = @StyleMaterialID))

--**  If material is the Main Material, Update pStyleHeader

	IF((SELECT MainMaterial FROM pStyleBOM WITH (NOLOCK) WHERE StyleMaterialID = @StyleMaterialID) = 1)
		BEGIN
			UPDATE pStyleHeader
			SET pStyleHeader.StyleMaterialID = pStyleBOM.StyleMaterialID		
				,pStyleHeader.MaterialImageID = pStyleBOM.MaterialImageID		
				,pStyleHeader.MaterialImageVersion = pStyleBOM.MaterialImageVersion		
				,pStyleHeader.MaterialID = pStyleBOM.MaterialID		
				,pStyleHeader.MaterialNo = pStyleBOM.MaterialNo		
				,pStyleHeader.MaterialName = pStyleBOM.MaterialName
			FROM pStyleHeader INNER JOIN pStyleBOM ON
			pStyleHeader.StyleID = pStyleBOM.StyleID
			WHERE pStyleBOM.StyleMaterialID IN (
			SELECT StyleMaterialID 
			FROM pStyleBOM
			WHERE StyleBOMDimensionId = (
				SELECT StyleBOMDimensionId 
				FROM pstylebom
				WHERE StyleMaterialID = @StyleMaterialID)
			AND MaterialID = (
				SELECT MaterialID 
				FROM pstylebom
				WHERE StyleMaterialID = @StyleMaterialID))
			AND pStyleBOM.MainMaterial = 1
		END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08397', GetDate())
GO