IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialCoreItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreItem_INSERT](
@MaterialID nvarchar(50),
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@MaterialCoreID uniqueidentifier
)
AS 

DECLARE @MaterialCoreItemID UNIQUEIDENTIFIER 
SET @MaterialCoreItemID  = NEWID()


INSERT INTO dbo.pMaterialCoreItem (MaterialCoreItemID, MaterialID, CDate, CUser, MDate, MUser, MaterialCoreID)
VALUES  (@MaterialCoreItemID, @MaterialID, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy, @MaterialCoreID)

/*

Uncommented by KRISHAN :- To make sure, the material gets added for each Style..

This will be called from the materialcore / batch update

--***
--** MultiCloth Logic ! 
--***
*/
CREATE TABLE #style (
ROWID INT IDENTITY (1,1),
StyleID  UNIQUEIDENTIFIER 
)

INSERT INTO #style  (StyleID) 
SELECT StyleID 
FROM pStyleHeader 
WHERE MaterialCoreID = @MaterialCoreID 

DECLARE @TOTAL INT
DECLARE @ROWID INT 
DECLARE @StyleID UNIQUEIDENTIFIER 
DECLARE @StyleMaterialID UNIQUEIDENTIFIER 

SELECT @TOTAL = COUNT(*) FROM  #style 
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL 
BEGIN

	SELECT @StyleID = StyleID FROM #style WHERE ROWID = @ROWID 
	SET @StyleMaterialID = NEWID()
	
	INSERT INTO pStyleMaterials ( StyleMaterialID , StyleMaterialMasterID, MainMaterial,StyleSet, StyleID, 
		MaterialID , MaterialImageID , MaterialImageVersion, MaterialType, MaterialNo, MaterialName, 
		A,B, C, D ,E, F, G,H, I, J , K, L, M , N, O, P, Q, R, S, T, 
		U, V,W, X, Y, Z, Notes, CUser, CDate,MUser,MDate, MChange, Colorway,
		UOM, Qty, MaterialPrice, Ext, MaterialSize, Placement, Artwork, License, StyleMaterialLinkID, MultiCloth)
	SELECT  @StyleMaterialID, NEWID() AS StyleMaterialMasterID, 0, 1 AS StyleSet, @StyleID, a.MaterialID, ISNULL(a.MaterialImageID,'00000000-0000-0000-0000-000000000000') AS MaterialImageID, 
	  ISNULL(a.MaterialImageVersion,1) AS MaterialImageVersion, a.MaterialType, a.MaterialNo, a.MaterialName, a.A, a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, a.R, a.S, a.T, a.U, 
	  a.V, a.W, a.X, a.Y, a.Z, a.Notes, @CreatedBy AS CreatedBy, @CreatedDate AS CreatedDate, @CreatedBy AS ModifiedBy, @CreatedDate AS ModifiedDate, a.MChange, 1 AS Colorway, 
	  a.UOM, 0 AS Qty, 0 AS MaterialPrice, NULL, NULL, NULL, 
	  0  AS Artwork, 0 AS License, @MaterialCoreItemID, 1 AS MultiCloth
	FROM pMaterial AS a 
	WHERE MaterialID = @MaterialID

  			
	SET @ROWID = @ROWID + 1 
END 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '234', GetDate())

GO














