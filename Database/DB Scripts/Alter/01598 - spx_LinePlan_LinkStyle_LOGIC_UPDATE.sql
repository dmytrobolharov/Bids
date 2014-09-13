IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_LinkStyle_LOGIC_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_LinkStyle_LOGIC_UPDATE]
GO

CREATE PROCEDURE dbo.spx_LinePlan_LinkStyle_LOGIC_UPDATE(
@LinePlanRangeID UNIQUEIDENTIFIER,
@MaterialCoreID UNIQUEIDENTIFIER,
@NewStyleLinkID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 


DECLARE @StyleMaterialID UNIQUEIDENTIFIER
DECLARE @MaterialCoreItemID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER
DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @ROWID INT
DECLARE @TOTAL INT
DECLARE @S_ROWID INT
DECLARE @S_TOTAL INT


CREATE TABLE #sty(
	ROWID INT IDENTITY (1,1),
	StyleID UNIQUEIDENTIFIER
)

INSERT INTO #sty(StyleID ) 
SELECT StyleID FROM pStyleHeader WHERE StyleLinkID = @NewStyleLinkID 



CREATE TABLE #mci (
	ROWID INT IDENTITY (1,1),
	MaterialCoreItemID UNIQUEIDENTIFIER,
	MaterialID UNIQUEIDENTIFIER,
	StyleMaterialID UNIQUEIDENTIFIER,
	MultiCloth INT 
)


SET @S_ROWID = 1 
SELECT @S_TOTAL =  COUNT(*) FROM #sty 

--***
--** Get materials from all styles (to do the merge)
--*** 
WHILE @S_ROWID <= @S_TOTAL 
BEGIN 

	SELECT @StyleID = StyleID FROM #sty WHERE ROWID =@S_ROWID 

	INSERT INTO #mci (MaterialCoreItemID, MaterialID, MultiCloth, StyleMaterialID )
	SELECT NEWID() AS MaterialCoreItemID, MaterialID, 0, StyleMaterialID 
	FROM pStyleMaterials 
	WHERE StyleID = @StyleID
	AND StyleMaterialLinkID NOT IN( 
		SELECT MaterialCoreItemID FROM pMaterialCoreItem 
		WHERE MaterialCoreID = @MaterialCoreID 
	) 
	AND MainMaterial = 0 

	SET @S_ROWID = @S_ROWID + 1 
END 


--SELECT * FROM #mci


SET @ROWID = 1 
SELECT @TOTAL = COUNT(*) FROM #mci

WHILE @ROWID <= @TOTAL
BEGIN 

	SELECT @MaterialCoreItemID = MaterialCoreItemID, @MaterialID = MaterialID,
	@StyleMaterialID = StyleMaterialID 
	FROM #mci WHERE ROWID  = @ROWID


	SET @S_ROWID = 1 
	SELECT @S_TOTAL =  COUNT(*) FROM #sty 

	WHILE @S_ROWID <= @S_TOTAL 
	BEGIN 

		SELECT @StyleID = StyleID FROM #sty WHERE ROWID =@S_ROWID 

		IF (	SELECT COUNT(*) FROM pStyleMaterials 
				WHERE StyleMaterialID = @StyleMaterialID 
				AND StyleID = @StyleID
			) = 0 
		BEGIN
			--PRINT 'INSERT'
			INSERT INTO pStyleMaterials(
			StyleMaterialID, StyleMaterialMasterID,
			StyleMaterialLinkID,CopyStyleMaterialID,
			MainMaterial, Development,
			MiscColor,
			StyleSet,
			StyleID,
			UOM, Qty, MaterialPrice, Ext,
			MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode,
			MaterialPlacementDetail, MaterialImageID, MaterialImageVersion,
			NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo,
			MaterialName, 
			A, B, C, D, E,F, G, H, I, J,K, L, M,N,O,P, Q,R, S, T, U,
			V,W, X,Y, Z,Source, Notes, Placement, VendorPrice, VolumePrice,
			VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime,
			DetailYesNo, ImageType, height,
			width, CDate, CUser, MDate, MUser, MChange,
			SChange, DChange, CChange,Action,
			ColorPlacement, Artwork, License,
			Colorway, MaterialSort,
			MaterialTrack, MaterialLinked, MaterialDimension,
			MaterialSizeA0, MaterialSizeA1,MaterialSizeA2, MaterialSizeA3,
			MaterialSizeA4, MaterialSizeA5,
			MaterialSizeA6, MaterialSizeA7,MaterialSizeA8, MaterialSizeA9,
			MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, MaterialSizeA13,
			MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17,
			MaterialSizeA18, MaterialSizeA19, MaterialSizeB0, MaterialSizeB1,
			MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5,
			MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9,
			MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13,
			MaterialSizeB14, MaterialSizeB15, MaterialSizeB16,
			MaterialSizeB17, MaterialSizeB18, MaterialSizeB19,
			MaterialLining, MaterialSizeID, MaterialPackLabelGroupID,
			TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode,
			MultiCloth)
			SELECT 
			NEWID() AS StyleMaterialID, NULL AS StyleMaterialMasterID,
			@MaterialCoreItemID AS StyleMaterialLinkID,NULL AS CopyStyleMaterialID,
			0 AS MainMaterial, Development,
			MiscColor,
			StyleSet,
			StyleID,
			UOM, Qty, MaterialPrice, Ext,
			MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode,
			MaterialPlacementDetail, MaterialImageID, MaterialImageVersion,
			NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo,
			MaterialName, 
			A, B, C, D, E,F, G, H, I, J,K, L, M,N,O,P, Q,R, S, T, U,
			V,W, X,Y, Z,Source, Notes, Placement, VendorPrice, VolumePrice,
			VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime,
			DetailYesNo, ImageType, height,
			width, CDate, CUser, MDate, MUser, MChange,
			SChange, DChange, CChange,Action,
			ColorPlacement, Artwork, License,
			Colorway, MaterialSort,
			MaterialTrack, MaterialLinked, MaterialDimension,
			MaterialSizeA0, MaterialSizeA1,MaterialSizeA2, MaterialSizeA3,
			MaterialSizeA4, MaterialSizeA5,
			MaterialSizeA6, MaterialSizeA7,MaterialSizeA8, MaterialSizeA9,
			MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, MaterialSizeA13,
			MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17,
			MaterialSizeA18, MaterialSizeA19, MaterialSizeB0, MaterialSizeB1,
			MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5,
			MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9,
			MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13,
			MaterialSizeB14, MaterialSizeB15, MaterialSizeB16,
			MaterialSizeB17, MaterialSizeB18, MaterialSizeB19,
			MaterialLining, MaterialSizeID, MaterialPackLabelGroupID,
			TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode,
			0 AS MultiCloth
			FROM pStyleMaterials 
			WHERE StyleMaterialID = @StyleMaterialID
		END 
		ELSE
		BEGIN 
			--PRINT 'UPDATE'
			UPDATE pStyleMaterials SET StyleMaterialLinkID = @MaterialCoreItemID
			WHERE StyleMaterialID = @StyleMaterialID
		END 

		SET @S_ROWID = @S_ROWID + 1 
	END 

	SET @ROWID = @ROWID + 1 
END 



--***
--** Call procedure to synchronize material group  ????
--***





GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01598'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01598', GetDate())
END	

GO

