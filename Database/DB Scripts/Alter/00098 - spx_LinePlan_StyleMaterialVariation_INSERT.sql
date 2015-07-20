IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_StyleMaterialVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_StyleMaterialVariation_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_LinePlan_StyleMaterialVariation_INSERT]
(
@LinePlanItemID  UNIQUEIDENTIFIER,
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(50)
)
AS


CREATE TABLE #tempStyleMaterials (
RecID int IDENTITY(1,1)  NOT NULL,
StyleMaterialID  uniqueidentifier ROWGUIDCOL  NOT NULL ,
StyleMaterialMasterID uniqueidentifier,
Colorway nvarchar (3),
)


CREATE TABLE #tempCopyStyleMaterials (
	RecID int IDENTITY(1,1)  NOT NULL,
	StyleMaterialID  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	StyleMaterialMasterID uniqueidentifier,
	CopyStyleMaterialID uniqueidentifier,
	MainMaterial int,
	Development bit,
	StyleSet int,
	StyleID uniqueidentifier,
	UOM nvarchar (50),
	Qty nvarchar (18),
	MaterialPrice money,
	Ext money,
	MaterialSize nvarchar (200),
	MaterialID uniqueidentifier,
	MaterialPlacement bit,
	MaterialPlacementCode nvarchar (4),
	MaterialPlacementDetail nvarchar (200),
	MaterialImageID uniqueidentifier,
	MaterialImageVersion int,
	NoColorMatch int,
	SupplierID nvarchar (50),
	ComponentTypeID int,
	MaterialType int,
	MaterialNo nvarchar (50),
	MaterialName nvarchar (200),
	A nvarchar (100),
	B nvarchar (100),
	C nvarchar (100),
	D nvarchar (100),
	E nvarchar (100),
	F nvarchar (100),
	G nvarchar (100),
	H nvarchar (100),
	I nvarchar (100),
	J nvarchar (100),
	K nvarchar (100),
	L nvarchar (100),
	M nvarchar (100),
	N nvarchar (100),
	O nvarchar (100),
	P nvarchar (100),
	Q nvarchar (100),
	R nvarchar (100),
	S nvarchar (100),
	T nvarchar (100),
	U nvarchar (100),
	V nvarchar (100),
	W nvarchar (100),
	X nvarchar (100),
	Y nvarchar (100),
	Z nvarchar (100),
	Source nvarchar (200),
	Notes nvarchar (4000),
	Placement nvarchar (4000),
	VendorPrice decimal(19, 3),
	VolumePrice decimal(19, 3),
	VolumePriceMinimum nvarchar (50),
	VendorProductionMin nvarchar (50),
	VendorProductionLeadTime nvarchar (50),
	DetailYesNo int,
	ImageType nvarchar (50),
	height nvarchar (18),
	width nvarchar (18),
	CDate datetime,
	CUser nvarchar (200),
	MDate datetime,
	MUser nvarchar (200),
	MChange int,
	SChange int,
	DChange int,
	CChange int,
	Action nvarchar (50),
	ColorPlacement nvarchar (4000),
	Artwork nvarchar (3),
	License nvarchar (3),
	Colorway nvarchar (3),
	MaterialSort varchar (5),
	MaterialTrack int,
	MaterialLinked int,
	MaterialLining int,
	MaterialSizeID UNIQUEIDENTIFIER,
	TradePartnerID UNIQUEIDENTIFIER,
	TradePartnerVendorID UNIQUEIDENTIFIER,
	CopyMaterialID UNIQUEIDENTIFIER
)





CREATE TABLE #tempStyleSeasonYear(
RecID INT IDENTITY (1,1),
StyleSeasonYearID UNIQUEIDENTIFIER, 
StyleSeason NVARCHAR(50),  
StyleYear NVARCHAR(50), 
SeasonYearID UNIQUEIDENTIFIER, 
NewStyleSeasonYearID UNIQUEIDENTIFIER
)



DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE @Row_Color_Count int
DECLARE @Row_Color_Loop int

DECLARE @Season VARCHAR(100)
DECLARE @Year VARCHAR(100)
DECLARE @SeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleCopyType VARCHAR(50)


	

		
BEGIN

	INSERT INTO #tempStyleMaterials	(StyleMaterialMasterID, StyleMaterialID, Colorway)
	SELECT StyleMaterialMasterId, StyleMaterialID, Colorway
	FROM pStyleMaterials WITH (NOLOCK)
	WHERE (StyleID = @StyleID)


	DECLARE @StyleMaterialMasterID uniqueidentifier
	DECLARE @StyleMaterialID uniqueidentifier
	DECLARE @NewStyleMaterialID uniqueidentifier
	DECLARE @Colorway nvarchar(3)

	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleMaterials)
	
	WHILE @Row_Loop <= @Row_Count 
	BEGIN
		SELECT @StyleMaterialMasterID = StyleMaterialMasterID, @StyleMaterialID = StyleMaterialID, @Colorway = Colorway 
		FROM #tempStyleMaterials WHERE RecID = @Row_Loop
		
		BEGIN
			-- New StyleMaterial in temp table 
			SET @NewStyleMaterialID = newid()
			INSERT INTO #tempCopyStyleMaterials
				(StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
				MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O,
				P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
				DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange,  SChange, DChange, 
				CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining , CopyStyleMaterialID, MaterialSizeID, 
				TradePartnerID, TradePartnerVendorID, CopyMaterialID)
			SELECT @NewStyleMaterialID, MainMaterial, StyleSet, @NewStyleID AS StyleID, UOM, 
				Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
				ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,Source, Notes, 
				Placement AS Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, 
				ImageType, ColorPlacement, Artwork, License, Colorway, @CreatedDate AS CDate, @CreatedBy AS CUser, 
				@CreatedDate AS MDate, @CreatedBy AS MUser, MChange, SChange, DChange, CChange, Action, newid() AS StyleMaterialMasterId , 
				Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining, StyleMaterialID  AS CopyStyleMaterialID, MaterialSizeID, 
				TradePartnerID, TradePartnerVendorID, MaterialID
			FROM pStyleMaterials WITH (NOLOCK)
			WHERE (StyleMaterialID = @StyleMaterialID)
				
														
		END			
		SET @Row_Loop = @Row_Loop + 1
	END
END


	INSERT INTO pStyleMaterials (
		StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
		MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, 
		A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,
		Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
		DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange,  SChange, DChange, 
		CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining, CopyStyleMaterialID, 
		MaterialSizeID, TradePartnerID, TradePartnerVendorID )
	SELECT 
		StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
		MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, 
		A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,
		Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
		DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy, MChange, SChange, DChange, 
		CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining , CopyStyleMaterialID, 
		MaterialSizeID, TradePartnerID, TradePartnerVendorID
	FROM #tempCopyStyleMaterials
	
	
	
	DECLARE @StyleMaterialIDTmp  AS uniqueidentifier   

	SELECT TOP 1 @StyleMaterialIDTmp = StyleMaterialID FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleID = @NewStyleID AND MainMaterial = 1 

	UPDATE pStyleHeader SET StyleMaterialID = @StyleMaterialIDTmp
	WHERE StyleID = @NewStyleID





	



BEGIN

	DROP TABLE #tempStyleMaterials
	DROP TABLE #tempCopyStyleMaterials
	DROP TABLE #tempStyleSeasonYear
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '098', GetDate())

GO














