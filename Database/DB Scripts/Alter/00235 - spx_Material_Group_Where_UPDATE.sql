IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Group_Where_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Group_Where_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_Material_Group_Where_UPDATE](
@StyleSeasonYearID UNIQUEIDENTIFIER, 
@MaterialCoreID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME 
)
AS


DECLARE @StyleID UNIQUEIDENTIFIER 
SELECT @StyleID = StyleID FROM pStyleSeasonYear WHERE StyleSeasonYearID  = @StyleSeasonYearID 


CREATE TABLE #mci (
ROWID INT IDENTITY(1,1),
MaterialCoreItemID UNIQUEIDENTIFIER, 
MaterialID UNIQUEIDENTIFIER, 
UOM NVARCHAR(50),
QTY NVARCHAR(18), 
MaterialSize NVARCHAR(100),
MaterialSizeID UNIQUEIDENTIFIER,
Placement NVARCHAR(4000),
Artwork INT, 
License INT,
Colorway INT
)


DECLARE @StyleMaterialID UNIQUEIDENTIFIER
DECLARE @MaterialCoreItemID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER
DECLARE @UOM NVARCHAR(50)
DECLARE @QTY NVARCHAR(18) 
DECLARE @MaterialSize NVARCHAR(100)
DECLARE @MaterialSizeID UNIQUEIDENTIFIER
DECLARE @Placement NVARCHAR(4000)
DECLARE @Artwork INT
DECLARE @License INT
DECLARE @Colorway INT


INSERT INTO #mci (  MaterialCoreItemID, MaterialID, UOM, QTY, MaterialSize, MaterialSizeID, Placement, Artwork, License, Colorway)
SELECT a.MaterialCoreItemID, a.MaterialID, a.UOM, a.QTY , a.MaterialSize, b.MaterialSizeID, a.Placement, a.Artwork, a.License, a.Colorway
FROM pMaterialCoreItem a
INNER JOIN pMaterial c ON a.MaterialID =  c.MaterialID 
LEFT OUTER JOIN pMaterialSize b ON  a.MaterialSize = b.MaterialSize AND a.MaterialID = b.MaterialID
WHERE MaterialCoreID = @MaterialCoreID 



DECLARE @ROWID INT
DECLARE @TOTAL INT

--***
--** Update StyleMaterials
--***
SET @ROWID = 1
SELECT @TOTAL =  COUNT(*) FROM  #mci 

WHILE @ROWID <= @TOTAL 
BEGIN 


	SELECT @MaterialCoreItemID = MaterialCoreItemID, @MaterialID = MaterialID, @UOM = UOM, 
	@QTY = QTY, @MaterialSize = MaterialSize, @MaterialSizeID = MaterialSizeID, @Placement = Placement, 
	@Artwork = Artwork, @License = License, @Colorway =  Colorway
	FROM #mci WHERE ROWID = @ROWID 

	
	IF ( SELECT COUNT(*) FROM pStyleMaterials
		WHERE StyleID = @StyleID
		AND  StyleMaterialLinkID = @MaterialCoreItemID ) = 0
	BEGIN
	
		--***
		--** Insert material
		--***
	
		SET @StyleMaterialID = NEWID()
        
        IF @QTY = ''
		   SET @QTY = NULL
		ELSE
		   SET @QTY = CAST(@QTY AS DECIMAL(18,2))
	
		INSERT INTO pStyleMaterials ( StyleMaterialID , StyleMaterialMasterID, MainMaterial,StyleSet, StyleID, 
			MaterialID , MaterialImageID , MaterialImageVersion, MaterialType, MaterialNo, MaterialName, 
			A,B, C, D ,E, F, G,H, I, J , K, L, M , N, O, P, Q, R, S, T, 
			U, V,W, X, Y, Z, Notes, 
			CUser, CDate,MUser,MDate, MChange, Colorway,
			UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialSizeID, Placement, 
			Artwork, License, StyleMaterialLinkID, MultiCloth)
			
		SELECT  @StyleMaterialID, NEWID() AS StyleMaterialMasterID, 0, 1 AS StyleSet, @StyleID, a.MaterialID, ISNULL(a.MaterialImageID,'00000000-0000-0000-0000-000000000000') AS MaterialImageID, 
		  ISNULL(a.MaterialImageVersion,1) AS MaterialImageVersion, a.MaterialType, a.MaterialNo, a.MaterialName, a.A, a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, a.R, a.S, a.T, a.U, 
		  a.V, a.W, a.X, a.Y, a.Z, a.Notes, 
		  @MUser AS CUser, @MDate AS CDate, @MUser AS MUser, @MDate AS MDate, a.MChange, @Colorway AS Colorway, 
		  @UOM AS UOM, @QTY AS Qty, 0 AS MaterialPrice, NULL AS Ext, @MaterialSize AS MaterialSize, @MaterialSizeID AS MaterialSizeID, @Placement AS Placement, 
		  @Artwork  AS Artwork, @License AS License, @MaterialCoreItemID AS StyleMaterialLinkID, 1 AS MultiCloth
		FROM pMaterial AS a 
		WHERE MaterialID = @MaterialID		
		
		select Colorway from pStyleMaterials where StyleMaterialID = @StyleMaterialID 
	
	END 
	ELSE
	BEGIN

		--***
		--** Update material
		--***
		IF @QTY = ''
		   SET @QTY = NULL
		ELSE
		   SET @QTY = CAST(@QTY AS DECIMAL(18,2))

     
		UPDATE pStyleMaterials SET 
		UOM = @UOM,  Qty = @QTY,  MaterialSize = @MaterialSize,  MaterialSizeID = @MaterialSizeID , 
		Placement = @Placement , Artwork =@Artwork, License = @License , Colorway =@Colorway
		WHERE StyleID = @StyleID AND StyleMaterialLinkID = @MaterialCoreItemID

	END


	
	SET @ROWID = @ROWID + 1 
END 

DROP TABLE #mci

--***
--** Update Color chips
--***

DECLARE @MaterialCoreColorItemID UNIQUEIDENTIFIER
DECLARE @MaterialColorID UNIQUEIDENTIFIER

CREATE TABLE #color(
ROWID INT IDENTITY(1,1) , 
MaterialCoreColorItemID UNIQUEIDENTIFIER,
MaterialColorID UNIQUEIDENTIFIER
)

INSERT INTO #color ( MaterialCoreColorItemID, MaterialColorID ) 
SELECT MaterialCoreColorItemID, MaterialColorID FROM pMaterialCoreColorItem WHERE MaterialCoreID = @MaterialCoreID

SET @ROWID = 1
SELECT @TOTAL =  COUNT(*) FROM  #color 

WHILE @ROWID <= @TOTAL 
BEGIN 
	SELECT @MaterialCoreColorItemID = MaterialCoreColorItemID, @MaterialColorID = MaterialColorID
	FROM #color WHERE ROWID = @ROWID 
	
	UPDATE pStyleColorwayItem SET 
	MaterialColorID = @MaterialColorID 
	WHERE StyleID = @StyleID AND MaterialCoreColorItemID = @MaterialCoreColorItemID
	
	SET @ROWID = @ROWID + 1 
END 

DROP TABLE #color


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '235', GetDate())

GO




