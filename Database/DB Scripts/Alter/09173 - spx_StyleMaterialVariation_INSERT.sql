
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialVariation_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterialVariation_INSERT] (
	@StyleID uniqueidentifier,
	@NewStyleID uniqueidentifier,
	@CreatedBy nvarchar(200),
	@CreatedDate nvarchar(50), 
	@ColorsSelected int  = 0 
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
	MaterialSort nvarchar (5),
	MaterialTrack int,
	MaterialLinked int,
	MaterialLining int,
	MaterialSizeID UNIQUEIDENTIFIER,
	TradePartnerID UNIQUEIDENTIFIER,
	TradePartnerVendorID UNIQUEIDENTIFIER,
	CopyMaterialID UNIQUEIDENTIFIER
)

CREATE TABLE #tempStyleColorway (
	RecID int IDENTITY(1,1)  NOT NULL,
	StyleColorID  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	StyleID uniqueidentifier,
	StyleSet int,
	StyleColorStandardID uniqueidentifier,
	StyleColorNo nvarchar (200) ,						
	StyleColorName nvarchar (200) ,
	MainColor nvarchar (100) ,
	Sort nvarchar (10) ,
	Version int,
	CDate datetime,
	CUser nvarchar (200),
	MDate datetime,
	MUser nvarchar (200),
	CopyStyleColorID UNIQUEIDENTIFIER ,
	ColorPaletteID UNIQUEIDENTIFIER ,
	SAPCode NVARCHAR(200),
	PLMCode NVARCHAR(200)
	
) 

CREATE TABLE #tempCopyStyleColorway (
	RecID int IDENTITY(1,1)  NOT NULL,
	StyleColorID  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	StyleID uniqueidentifier,
	StyleSet int,
	StyleColorStandardID uniqueidentifier,
	StyleColorNo nvarchar (200) ,						
	StyleColorName nvarchar (200) ,
	MainColor nvarchar (100) ,
	Sort nvarchar (10) ,
	Version int,
	CDate datetime,
	CUser nvarchar (200),
	MDate datetime,
	MUser nvarchar (200) ,
	CopyStyleColorID UNIQUEIDENTIFIER , 
	ColorPaletteID UNIQUEIDENTIFIER,
	SAPCode NVARCHAR(200),
	PLMCode NVARCHAR(200)
) 

CREATE TABLE #tempStyleColorwayItem (
	RecID int IDENTITY(1,1)  NOT NULL,
	StyleColorItemID  uniqueidentifier,
	StyleColorItemMasterID uniqueidentifier, 
	StyleColorID uniqueidentifier,
	StyleID uniqueidentifier,
	StyleSet int,
	StyleMaterialID uniqueidentifier,
	MaterialID uniqueidentifier,
	MaterialColorID uniqueidentifier,
	CDate datetime,
	CUser nvarchar (200),
	MDate datetime,
	MUser nvarchar (200)
) 

CREATE TABLE #tempCopyStyleColorwayItem (
	RecID int IDENTITY(1,1)  NOT NULL,
	StyleColorItemID  uniqueidentifier,
	StyleColorItemMasterID uniqueidentifier, 
	StyleColorID uniqueidentifier,
	StyleID uniqueidentifier,
	StyleSet int,
	StyleMaterialID uniqueidentifier,
	MaterialID uniqueidentifier,
	MaterialColorID uniqueidentifier,
	CDate datetime,
	CUser nvarchar (200),
	MDate datetime,
	MUser nvarchar (200)
) 

CREATE TABLE #tempStyleSeasonYear(
RecID INT IDENTITY (1,1),
StyleSeasonYearID UNIQUEIDENTIFIER, 
StyleSeason NVARCHAR(50),  
StyleYear NVARCHAR(50), 
SeasonYearID UNIQUEIDENTIFIER, 
NewStyleSeasonYearID UNIQUEIDENTIFIER
)

CREATE TABLE #tempStyleColorwaySeasonYear (
RecID INT IDENTITY (1,1),
StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
StyleSeasonYearID UNIQUEIDENTIFIER,
StyleColorwayID UNIQUEIDENTIFIER,
StyleColorDelivery1 INT,
StyleColorDelivery2 INT,
StyleColorDelivery3 INT,
StyleColorDelivery4 INT,
StyleColorStatus  INT,
Units  INT,
ColorType NVARCHAR(5) ,
SampleStatus  INT ,
NewStyleColorwayID UNIQUEIDENTIFIER,
NewStyleSeasonYearID UNIQUEIDENTIFIER,
DesignImageFrontID UNIQUEIDENTIFIER,
DesignImageFrontVersion INT,
DesignImageBackID UNIQUEIDENTIFIER,
DesignImageBackVersion INT
)


DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE @Row_Color_Count int
DECLARE @Row_Color_Loop int

DECLARE @Season nVARCHAR(100)
DECLARE @Year nVARCHAR(100)
DECLARE @SeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleCopyType nVARCHAR(50)


BEGIN

	-- Original ! 
	IF @ColorsSelected = 1 
		INSERT INTO #tempStyleColorway
    			(StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, 
				MUser , ColorPaletteID, SAPCode, PLMCode)
		SELECT StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, @CreatedDate AS CDate, @CreatedBy AS CUser, 
    			@CreatedDate AS MDate, @CreatedBy AS MUser , ColorPaletteID, SAPCode, PLMCode
		FROM pStyleColorway WITH (NOLOCK)
		WHERE (StyleID = @StyleID) 
		AND (StyleColorID IN (SELECT StyleColorwayID FROM pStyleColorwayTemp WITH (NOLOCK) WHERE NewStyleID = @NewStyleID))
	ELSE 
		INSERT INTO #tempStyleColorway
    			(StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, 
				MUser , ColorPaletteID, SAPCode, PLMCode)
		SELECT StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, @CreatedDate AS CDate, @CreatedBy AS CUser, 
    			@CreatedDate AS MDate, @CreatedBy AS MUser , ColorPaletteID, SAPCode, PLMCode
		FROM pStyleColorway WITH (NOLOCK)
		WHERE (StyleID = @StyleID) 
		

	DECLARE @StyleColorID uniqueidentifier 	
	DECLARE @NewStyleColorID uniqueidentifier 	
	
	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleColorway)

	WHILE @Row_Loop <= @Row_Count 
	BEGIN
		SELECT @StyleColorID = StyleColorID FROM  #tempStyleColorway WHERE RecID = @Row_Loop
		SET @NewStyleColorID = newid()
	
		-- New Colorways, keeping track of original in CopyStyleColorID 
		INSERT INTO #tempCopyStyleColorway
		(StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, 
		MUser, CopyStyleColorID, ColorPaletteID , SAPCode, PLMCode)
		SELECT @NewStyleColorID, @NewStyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, @CreatedDate AS CDate, @CreatedBy AS CUser, 
		@CreatedDate AS MDate, @CreatedBy AS MUser, StyleColorID, ColorPaletteID, SAPCode, PLMCode
		FROM pStyleColorway WITH (NOLOCK)
		WHERE (StyleColorID = @StyleColorID)
	
		SET @Row_Loop = @Row_Loop + 1
	END
END	
	
-- FIX StyleColorItemMasterID	
BEGIN	
	-- Original Colorway items !!

	IF @ColorsSelected = 1 
		INSERT INTO #tempStyleColorwayItem
		(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
		SELECT StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser
		FROM  pStyleColorwayItem WITH (NOLOCK)
		WHERE (StyleID = @StyleID) 
		AND (StyleColorID IN (SELECT StyleColorwayID FROM pStyleColorwayTemp WHERE NewStyleID = @NewStyleID))
	ELSE 
		INSERT INTO #tempStyleColorwayItem
		(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
		SELECT StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser
		FROM  pStyleColorwayItem WITH (NOLOCK)
		WHERE (StyleID = @StyleID) 
		

	
	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleColorwayItem)
	
	DECLARE @StyleColorItemID uniqueidentifier 	
	DECLARE @StyleColorItemMasterID  uniqueidentifier 	

	WHILE @Row_Loop <= @Row_Count 
	BEGIN
		SELECT @StyleColorItemMasterID = StyleColorItemMasterID, @StyleColorItemID = StyleColorItemID 
		FROM  #tempStyleColorwayItem WHERE RecID = @Row_Loop
	
		IF @StyleColorItemMasterID IS NULL
		BEGIN
			UPDATE #tempStyleColorwayItem SET StyleColorItemMasterID = newid() WHERE StyleColorItemID = @StyleColorItemID	
			--UPDATE pStyleColorwayItem SET StyleColorItemMasterID = newid() WHERE StyleColorItemID = @StyleColorItemID
		END	

		SET @Row_Loop = @Row_Loop + 1
	END
END	


		
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
				@CreatedDate AS MDate, @CreatedBy AS MUser, MChange, SChange, DChange, CChange, Action, @StyleMaterialMasterID AS StyleMaterialMasterId , 
				Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining, StyleMaterialID  AS CopyStyleMaterialID, MaterialSizeID, 
				TradePartnerID, TradePartnerVendorID, MaterialID
			FROM pStyleMaterials WITH (NOLOCK)
			WHERE (StyleMaterialID = @StyleMaterialID)
				
			---Style Colorway--------------------------------------------
			
			SET @Row_Color_Loop = 1
			SET @Row_Color_Count = (SELECT COUNT(*) FROM #tempStyleColorway)
														
			IF @Colorway = 1
			BEGIN
				WHILE @Row_Color_Loop <= @Row_Color_Count
				BEGIN
							
					SELECT @StyleColorID = StyleColorID FROM  #tempStyleColorway WHERE RecID = @Row_Color_Loop
					SELECT @NewStyleColorID = StyleColorID FROM  #tempCopyStyleColorway WHERE RecID = @Row_Color_Loop

					
					INSERT INTO #tempCopyStyleColorwayItem
					(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
					SELECT newid() AS StyleColorItemID, StyleColorItemMasterID, @NewStyleColorID, @NewStyleID, StyleSet, @NewStyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser
					FROM  #tempStyleColorwayItem
					WHERE StyleColorID = @StyleColorID AND StyleMaterialID = @StyleMaterialID		
							
					SET @Row_Color_Loop = @Row_Color_Loop + 1
				END
			END
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
	

	INSERT INTO dbo.pStyleColorway
		(StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, MUser , 
		CopyStyleColorID , ColorPaletteID, SAPCode, PLMCode)
	SELECT StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, GETDATE(), @CreatedBy, GETDATE(), @CreatedBy, 
		CopyStyleColorID, ColorPaletteID, SAPCode, PLMCode
	FROM #tempCopyStyleColorway
	
	INSERT INTO dbo.pStyleColorwayItem
		(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
	SELECT StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, GETDATE(), @CreatedBy, GETDATE(), @CreatedBy
	FROM  #tempCopyStyleColorwayItem	

	DECLARE @StyleMaterialIDTmp  AS uniqueidentifier   

	SELECT TOP 1 @StyleMaterialIDTmp = StyleMaterialID FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleID = @NewStyleID AND MainMaterial = 1 

	UPDATE pStyleHeader SET StyleMaterialID = @StyleMaterialIDTmp
	WHERE StyleID = @NewStyleID






--*************************************************************************************
-- Season year

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @NewStyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @StyleNo NVARCHAR(20) 

SELECT @StyleNo = StyleNo, @Season = CustomField5, @Year = CustomField6 
FROM pStyleHeader WHERE StyleID = @NewStyleID

--SELECT StyleNo, CustomField5, CustomField6  FROM pStyleHeader WHERE StyleID = @NewStyleID


INSERT INTO #tempStyleSeasonYear( StyleSeasonYearID , StyleSeason ,StyleYear,SeasonYearID, NewStyleSeasonYearID )
SELECT StyleSeasonYearID,  StyleSeason, StyleYear , SeasonYearID , NEWID() AS StyleSeasonYearID 
FROM pStyleSeasonYear WHERE StyleID = @StyleID


INSERT INTO #tempStyleColorwaySeasonYear (StyleColorwaySeasonYearID, StyleSeasonYearID, StyleColorwayID, 
StyleColorDelivery1,StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus,
Units, ColorType, SampleStatus, DesignImageFrontID, DesignImageFrontVersion, DesignImageBackID, DesignImageBackVersion)
SELECT NEWID() AS StyleColorwaySeasonYearID, StyleSeasonYearID, StyleColorwayID, 
StyleColorDelivery1,StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus,
Units, ColorType, SampleStatus, DesignImageFrontID, DesignImageFrontVersion, DesignImageBackID, DesignImageBackVersion  -- NewStyleColorwayID, NewStyleSeasonYearID
FROM pStyleColorwaySeasonYear
WHERE StyleID = @StyleID


SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleSeasonYear)


WHILE @Row_Loop <= @Row_Count 
BEGIN 
	SELECT @StyleSeasonYearID = StyleSeasonYearID, @NewStyleSeasonYearID = NewStyleSeasonYearID
	FROM   #tempStyleSeasonYear WHERE RecID = @Row_Loop
	

	SET @Row_Color_Loop = 1
	SET @Row_Color_Count = (SELECT COUNT(*) FROM #tempCopyStyleColorway)	

	WHILE @Row_Color_Loop <= @Row_Color_Count 
	BEGIN

		SELECT @StyleColorID = CopyStyleColorID , @NewStyleColorID = StyleColorID 
		FROM #tempCopyStyleColorway WHERE RecID = @Row_Color_Loop 

		UPDATE #tempStyleColorwaySeasonYear
		SET NewStyleColorwayID = @NewStyleColorID,
		NewStyleSeasonYearID = @NewStyleSeasonYearID
		WHERE StyleSeasonYearID = @StyleSeasonYearID
		AND StyleColorwayID = @StyleColorID 


		SET @Row_Color_Loop = @Row_Color_Loop + 1

	END 

	SET @Row_Loop = @Row_Loop + 1 

END 
	

DELETE FROM pStyleSeasonYear WHERE StyleID = @NewStyleID

INSERT INTO  pStyleSeasonYear ( StyleSeasonYearID , StyleID , StyleSeason, StyleYear, CUser, CDate, MUser, MDate, 
SeasonYearID , StyleNo, CurrentSeason, MostLikelyVendor )
SELECT NewStyleSeasonYearID , @NewStyleID as StyleID , StyleSeason ,StyleYear, @CreatedBy ,@CreatedDate,  @CreatedBy ,@CreatedDate,
SeasonYearID, @StyleNo,  0 , 0 
FROM  #tempStyleSeasonYear 

-- insert seasonal workflows
INSERT INTO pStyleWorkflow (
	StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, 
	WorkComplete, WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, StyleSeasonYearID, 
	ActualStart, ActualEnd)
SELECT newid() AS StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, 
	WorkDue, WorkAssignedTo, WorkComplete, WorkStatus, NULL AS WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, 
	WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, NewStyleSeasonYearID,
	ActualStart, ActualEnd
FROM pStyleWorkflow sw
INNER JOIN #tempStyleSeasonYear tssy ON sw.StyleSeasonYearID = tssy.StyleSeasonYearID
LEFT JOIN Mapping m ON sw.WorkflowID = m.Map
WHERE sw.StyleID = @StyleID
	AND m.IsSeasonal = 1
	
INSERT INTO pStyleTechPackStatus(StyleTechPackStatusID, StyleID, StyleSeasonYearID, WorkStatus, WorkAssignedTo, WorkStart, WorkDue, ActualStart, ActualEnd,
	CUser, CDate, MUser, MDate)
SELECT newid() AS StyleTechPackStatusID, @NewStyleID AS StyleID, NewStyleSeasonYearID, WorkStatus, WorkAssignedTo, WorkStart, WorkDue, ActualStart, ActualEnd,
	@CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
FROM pStyleTechPackStatus stps
INNER JOIN #tempStyleSeasonYear tssy ON stps.StyleSeasonYearID = tssy.StyleSeasonYearID
WHERE stps.StyleID = @StyleID


INSERT INTO  pStyleColorwaySeasonYear  ( StyleColorwaySeasonYearID, StyleSeasonYearID, StyleColorwayID, StyleID, 
StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus,
Units, ColorType, SampleStatus, DesignImageFrontID, DesignImageFrontVersion, DesignImageBackID, DesignImageBackVersion)
SELECT StyleColorwaySeasonYearID, NewStyleSeasonYearID, NewStyleColorwayID , @NewStyleID , 
StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus,
Units, ColorType, SampleStatus, DesignImageFrontID, DesignImageFrontVersion, DesignImageBackID, DesignImageBackVersion
FROM #tempStyleColorwaySeasonYear 



/********************************************************************************************************************************************************/



-- Create Style, Material, MaterialColor SeasonYearID's
-- #4 MAP SEASON AND YEAR FROM pStyleHeader TABLE
-- DP 7/14/2009


--See Comment #4
--SELECT @StyleCopyType = StyleCopyType FROM pStyleDevelopmentItemTemp WITH (NOLOCK) WHERE NewStyleID = @NewStyleID
--
--
--IF @StyleCopyType = 'CARRYOVER'
--	BEGIN
--
--		DECLARE @MaterialID UNIQUEIDENTIFIER
--		DECLARE @MaterialColorID UNIQUEIDENTIFIER
--
--		DECLARE @CopySeasonYearID UNIQUEIDENTIFIER
--		DECLARE @CopyMaterialSeason nVARCHAR(200)
--		DECLARE @CopyMaterialYear nVARCHAR(100)
--
--		DECLARE @MaterialSeason nVARCHAR(200)
--		DECLARE @MaterialYear nVARCHAR(100)
--
--		DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER
--		DECLARE @TradePartnerID UNIQUEIDENTIFIER
--		DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER
--
--		SELECT @CopySeasonYearID = SeasonYearID,
--			@CopyMaterialSeason = StyleSeason,
--			@CopyMaterialYear = StyleYear
--		FROM pStyleSeasonYear WITH (NOLOCK) WHERE StyleID = @StyleID
--
--		SELECT @MaterialSeason = @Season, @MaterialYear = @Year
--
--		SELECT @SeasonYearID = SeasonYearID
--		FROM pSeasonYear WITH (NOLOCK) 
--		WHERE Season = @MaterialSeason AND Year = @MaterialYear 
--
--
--		--SELECT * FROM pStyleSeasonYear WITH (NOLOCK) WHERE StyleID = @NewStyleID
--
--
--		--- MATERIAL  SEASON/YEAR 
--		SET @Row_Loop = 1
--		SET @Row_Count = (SELECT COUNT(*) FROM #tempCopyStyleMaterials)
--		WHILE @Row_Loop <= @Row_Count 
--		
--		BEGIN
--			SELECT @TradePartnerID = TradePartnerID, @TradePartnerVendorID = TradePartnerVendorID, @MaterialID = MaterialID 
--			FROM #tempCopyStyleMaterials WHERE RecID = @Row_Loop
--			BEGIN				
--				IF (SELECT COUNT(*) FROM pMaterialSeasonYear WITH (NOLOCK) 
--				WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID) = 0
--				BEGIN
--					INSERT INTO pMaterialSeasonYear(SeasonYearID, MaterialID, CUser, CDate) VALUES (@SeasonYearID, @MaterialID, @CreatedBy, @CreatedDate)
--				END			
--			END
--			SET @Row_Loop = @Row_Loop + 1
--		END	
--		
--
--
--		BEGIN	
--		SET @Row_Color_Loop = 1
--		SET @Row_Color_Count = (SELECT COUNT(*) FROM #tempCopyStyleColorwayItem)
--
--			--IF @Colorway = 1
--			BEGIN
--				WHILE @Row_Color_Loop <= @Row_Color_Count				
--					BEGIN
--						SELECT @MaterialColorID = MaterialColorID, @MaterialID = MaterialID FROM  #tempCopyStyleColorwayItem WHERE RecID = @Row_Color_Loop
--							IF (SELECT COUNT(*) FROM pMaterialColorSeasonYear WITH (NOLOCK) WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID AND MaterialColorID = @MaterialColorID) = 0
--							BEGIN
--
--								INSERT INTO pMaterialColorSeasonYear(MaterialColorID, SeasonYearID, MaterialID, MaterialSeason, MaterialYear, CUser, CDate, MUser, MDate) 
--								VALUES (@MaterialColorID, @SeasonYearID, @MaterialID, @MaterialSeason, @MaterialYear, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
--
--							END								
--						SET @Row_Color_Loop = @Row_Color_Loop + 1						
--					END					
--			END
--		END	
--
--		SET @Row_Loop = 1
--		SET @Row_Count = (SELECT COUNT(*) FROM #tempCopyStyleMaterials)
--		WHILE @Row_Loop <= @Row_Count 
--		BEGIN
--			SELECT @TradePartnerID = TradePartnerID, @TradePartnerVendorID = TradePartnerVendorID, @MaterialID = MaterialID FROM #tempCopyStyleMaterials WHERE RecID = @Row_Loop

--				IF (SELECT COUNT(*) FROM pMaterialTradePartner WITH (NOLOCK) WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID AND TradePartnerVendorID = @TradePartnerVendorID) = 0
--					BEGIN
--						SET @MaterialTradePartnerID = newid()
--
--						INSERT INTO pMaterialTradePartner(
--							MaterialTradePartnerId,MaterialId,TradepartnerId,TradepartnerVendorId,MaterialTradePartnerCustom1,MaterialTradePartnerCustom2
--						   ,MaterialTradePartnerCustom3,MaterialTradePartnerCustom4,MaterialTradePartnerCustom5
--						   ,MaterialTradePartnerCustom6,MaterialTradePartnerCustom7,MaterialTradePartnerCustom8,MaterialTradePartnerCustom9
--						   ,MaterialTradePartnerCustom10,MaterialTradePartnerCustom11,MaterialTradePartnerCustom12,MaterialTradePartnerCustom13,MaterialTradePartnerCustom14
--						   ,MaterialTradePartnerCustom15,MaterialTradePartnerCustom16,MaterialTradePartnerCustom17,MaterialTradePartnerCustom18
--						   ,MaterialTradePartnerCustom19,MaterialTradePartnerCustom20,MaterialTradePartnerCustom21,MaterialTradePartnerCustom22,MaterialTradePartnerCustom23
--						   ,MaterialTradePartnerCustom24,MaterialTradePartnerCustom25,CDate,CUser,MDate,MUser,MChange,MaterialRequestWorkflowTempID
--						   ,MaterialRequestWorkflowStartDate,MaterialRequestWorkflowDueDate, SeasonYearID)
--						SELECT DISTINCT @MaterialTradePartnerId AS MaterialTradePartnerId, MaterialId,TradepartnerId,TradepartnerVendorId,MaterialTradePartnerCustom1,MaterialTradePartnerCustom2
--						   ,MaterialTradePartnerCustom3,MaterialTradePartnerCustom4,MaterialTradePartnerCustom5
--						   ,MaterialTradePartnerCustom6,MaterialTradePartnerCustom7,MaterialTradePartnerCustom8,MaterialTradePartnerCustom9
--						   ,MaterialTradePartnerCustom10,MaterialTradePartnerCustom11,MaterialTradePartnerCustom12,MaterialTradePartnerCustom13,MaterialTradePartnerCustom14
--						   ,MaterialTradePartnerCustom15,MaterialTradePartnerCustom16,MaterialTradePartnerCustom17,MaterialTradePartnerCustom18
--						   ,MaterialTradePartnerCustom19,MaterialTradePartnerCustom20,MaterialTradePartnerCustom21,MaterialTradePartnerCustom22,MaterialTradePartnerCustom23
--						   ,MaterialTradePartnerCustom24,MaterialTradePartnerCustom25,@CreatedDate,@CreatedBy,@CreatedDate,@CreatedBy,MChange,MaterialRequestWorkflowTempID
--						   ,MaterialRequestWorkflowStartDate,MaterialRequestWorkflowDueDate, @SeasonYearID 
--						FROM pMaterialTradePartner WHERE MaterialID = @MaterialID AND SeasonYearID = @CopySeasonYearID AND TradePartnerVendorID = @TradePartnerVendorID
--					END
--				ELSE
--					BEGIN
--						SELECT DISTINCT @MaterialTradePartnerID = MaterialTradePartnerID 
--						FROM pMaterialTradePartner WITH (NOLOCK) 
--						WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID AND TradePartnerVendorID = @TradePartnerVendorID
--					END

--
--				BEGIN		
--
--					CREATE TABLE #tempMaterialColorSeasonYear(	
--						RecID int IDENTITY(1,1)  NOT NULL,
--						MaterialColorID uniqueidentifier,
--						MaterialID uniqueidentifier,
--						SeasonYearID uniqueidentifier
--					)
--
--
--					BEGIN
--						INSERT INTO #tempMaterialColorSeasonYear(MaterialColorID, SeasonYearID, MaterialID) 
--						SELECT DISTINCT MaterialColorID, SeasonYearID, MaterialID 
--						FROM pMaterialColorSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID
--					END
--
--		
--					BEGIN	
--					SET @Row_Color_Loop = 1
--					SET @Row_Color_Count = (SELECT COUNT(*) FROM #tempMaterialColorSeasonYear)
--																	
--						--IF @Colorway = 1
--						BEGIN
--							WHILE @Row_Color_Loop <= @Row_Color_Count				
--								BEGIN
--									SELECT @MaterialColorID = MaterialColorID FROM #tempMaterialColorSeasonYear WHERE RecID = @Row_Color_Loop
--										IF (SELECT COUNT(*) FROM pMaterialTradePartnerColor WITH (NOLOCK) WHERE MaterialID = @MaterialID AND 
--											MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialColorID = @MaterialColorID) = 0
--										BEGIN
--
--											INSERT INTO pMaterialTradePartnerColor (MaterialTradePartnerColorID, MaterialTradePartnerID, 
--												  MaterialColorID, MaterialID, MaterialColorImageID, MaterialColorImageVersion, ColorFolderID, ColorPaletteID, 
--												  ColorID, ColorCode, ColorNo, ColorName, ColorSource, VendorColorCode, 
--												  VendorColorNo, VendorColorName, MaterialColorNote, ColorHex, Hex, R, G, 
--												  B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, ColorHexCode, CDate, CUser, 
--												  MDate, MUser, MaterialColorVersion, ColorVersion, Action, Sort, MaterialTradeColor1, MaterialTradeColor2, MaterialTradeColor3, 
--												  MaterialTradeColor4, MaterialTradeColor5, MaterialTradeColor6, MaterialTradeColor7, MaterialTradeColor8, MaterialTradeColor9, 
--												  MaterialTradeColor10, MaterialTradeColor11, MaterialTradeColor12, MaterialTradeColor13, MaterialTradeColor14, MaterialTradeColor15, 
--												  MaterialTradeColor16, MaterialTradeColor17, MaterialTradeColor18, MaterialTradeColor19, MaterialTradeColor20, MaterialTradeColor21, 
--												  MaterialTradeColor22, MaterialTradeColor23, MaterialTradeColor24, MaterialTradeColor25, MaterialSizeID, MaterialPrice, AgentView, Comments)
--											SELECT DISTINCT newid() AS MaterialTradePartnerColorID, @MaterialTradePartnerID AS MaterialTradePartnerId, 
--												  pMaterialTradePartnerColor.MaterialColorID, pMaterialTradePartnerColor.MaterialID, pMaterialTradePartnerColor.MaterialColorImageID, 
--												  pMaterialTradePartnerColor.MaterialColorImageVersion, pMaterialTradePartnerColor.ColorFolderID, pMaterialTradePartnerColor.ColorPaletteID, 
--												  pMaterialTradePartnerColor.ColorID, pMaterialTradePartnerColor.ColorCode, pMaterialTradePartnerColor.ColorNo, 
--												  pMaterialTradePartnerColor.ColorName, pMaterialTradePartnerColor.ColorSource, pMaterialTradePartnerColor.VendorColorCode, 
--												  pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, pMaterialTradePartnerColor.MaterialColorNote, 
--												  pMaterialTradePartnerColor.ColorHex, pMaterialTradePartnerColor.Hex, pMaterialTradePartnerColor.R, pMaterialTradePartnerColor.G, 
--												  pMaterialTradePartnerColor.B, pMaterialTradePartnerColor.C, pMaterialTradePartnerColor.M, pMaterialTradePartnerColor.Y, 
--												  pMaterialTradePartnerColor.K, pMaterialTradePartnerColor.H, pMaterialTradePartnerColor.S, pMaterialTradePartnerColor.L, 
--												  pMaterialTradePartnerColor.LAB_L, pMaterialTradePartnerColor.LAB_A, pMaterialTradePartnerColor.LAB_B, 
--												  pMaterialTradePartnerColor.ColorHexCode, getdate() AS CDate, pMaterialTradePartnerColor.CUser, 
--												  getdate() AS MDate, pMaterialTradePartnerColor.MUser, pMaterialTradePartnerColor.MaterialColorVersion, 
--												  pMaterialTradePartnerColor.ColorVersion, pMaterialTradePartnerColor.Action, pMaterialTradePartnerColor.Sort, 
--												  pMaterialTradePartnerColor.MaterialTradeColor1, pMaterialTradePartnerColor.MaterialTradeColor2, pMaterialTradePartnerColor.MaterialTradeColor3, 
--												  pMaterialTradePartnerColor.MaterialTradeColor4, pMaterialTradePartnerColor.MaterialTradeColor5, pMaterialTradePartnerColor.MaterialTradeColor6, 
--												  pMaterialTradePartnerColor.MaterialTradeColor7, pMaterialTradePartnerColor.MaterialTradeColor8, pMaterialTradePartnerColor.MaterialTradeColor9, 
--												  pMaterialTradePartnerColor.MaterialTradeColor10, pMaterialTradePartnerColor.MaterialTradeColor11, pMaterialTradePartnerColor.MaterialTradeColor12, 
--												  pMaterialTradePartnerColor.MaterialTradeColor13, pMaterialTradePartnerColor.MaterialTradeColor14, pMaterialTradePartnerColor.MaterialTradeColor15, 
--												  pMaterialTradePartnerColor.MaterialTradeColor16, pMaterialTradePartnerColor.MaterialTradeColor17, pMaterialTradePartnerColor.MaterialTradeColor18, 
--												  pMaterialTradePartnerColor.MaterialTradeColor19, pMaterialTradePartnerColor.MaterialTradeColor20, pMaterialTradePartnerColor.MaterialTradeColor21, 
--												  pMaterialTradePartnerColor.MaterialTradeColor22, pMaterialTradePartnerColor.MaterialTradeColor23, pMaterialTradePartnerColor.MaterialTradeColor24, 
--												  pMaterialTradePartnerColor.MaterialTradeColor25, pMaterialTradePartnerColor.MaterialSizeID, pMaterialTradePartnerColor.MaterialPrice, 
--												  pMaterialTradePartnerColor.AgentView, pMaterialTradePartnerColor.Comments
--											FROM  pMaterialTradePartnerColor INNER JOIN
--													pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId
--											WHERE (pMaterialTradePartner.MaterialID = @MaterialID AND pMaterialTradePartner.SeasonYearID = @CopySeasonYearID AND 
--													pMaterialTradePartnerColor.MaterialColorID = @MaterialColorID)
--
--										END	
--										ELSE
--										BEGIN		
--												INSERT INTO pMaterialTradePartnerColor (MaterialTradePartnerColorID, MaterialTradePartnerID, 
--													MaterialColorID, MaterialID, ColorFolderID, ColorPaletteID, 
--													ColorID, ColorCode, ColorNo, ColorName, ColorSource, ColorHex, Hex, R, G, 
--													B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, ColorHexCode, CDate, CUser, 
--													MDate, MUser)
--												SELECT DISTINCT newid() AS MaterialTradePartnerColorID, @MaterialTradePartnerID AS MaterialTradePartnerId, 
--													pMaterialColor.MaterialColorID, @MaterialID, pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, 
--													pMaterialColor.ColorID, pMaterialColor.ColorCode, pMaterialColor.ColorNo, 
--													pMaterialColor.ColorName, pMaterialColor.ColorSource,  
--													pMaterialColor.ColorHex, pMaterialColor.Hex, pMaterialColor.R, pMaterialColor.G, 
--													pMaterialColor.B, pMaterialColor.C, pMaterialColor.M, pMaterialColor.Y, 
--													pMaterialColor.K, pMaterialColor.H, pMaterialColor.S, pMaterialColor.L, 
--													pMaterialColor.LAB_L, pMaterialColor.LAB_A, pMaterialColor.LAB_B, 
--													pMaterialColor.ColorHexCode, getdate() AS CDate, @CreatedBy, 
--													getdate() AS MDate, @CreatedBy
--												FROM  pMaterialColor WHERE MaterialColorID = @MaterialColorID --AND MaterialID = @MaterialID
--										END				
--									SET @Row_Color_Loop = @Row_Color_Loop + 1	
--
--								END					
--						END
--
--						DROP TABLE #tempMaterialColorSeasonYear
--
--
--					END	


--					DELETE FROM pMaterialTradePartnerColor WHERE (MaterialTradePartnerID = @MaterialTradePartnerID) AND
--						 (pMaterialTradePartnerColor.MaterialColorID NOT IN (SELECT MaterialColorID FROM pMaterialColorSeasonYear 
--								WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID)) 

--
--					UPDATE pMaterialTradePartnerColor SET MaterialSizeID = '00000000-0000-0000-0000-000000000000'
--					WHERE MaterialSizeID IS NULL AND MaterialTradePartnerID = @MaterialTradePartnerID
--
--
--					WITH Cte AS 
--					( 
--					SELECT MaterialTradePartnerID, MaterialColorID, MaterialID, MaterialSizeID, ROW_NUMBER() Over (PARTITION BY MaterialTradePartnerID, MaterialColorID, MaterialID, MaterialSizeID ORDER BY MaterialTradePartnerID) as Seq 
--					FROM pMaterialTradePartnerColor WHERE MaterialTradePartnerID = @MaterialTradePartnerID
--					) 
--					DELETE FROM cte 
--					WHERE Seq > 1 
--										
--			END	
--
--		SET @Row_Loop = @Row_Loop + 1
--		END	
--
--	END
--ELSE
--	BEGIN
--
--		IF @ColorsSelected = 1
--			UPDATE pStyleMaterials SET 
--				  UOM = NULL
--				  ,Qty = NULL
--				  ,MaterialPrice = NULL
--				  ,Ext = NULL
--				  ,MaterialSize = NULL
--				  ,A = NULL
--				  ,B = NULL
--				  ,C = NULL
--				  ,D = NULL
--				  ,E = NULL
--				  ,F = NULL
--				  ,G = NULL
--				  ,H = NULL
--				  ,I = NULL
--				  ,J = NULL
--				  ,K = NULL
--				  ,L = NULL
--				  ,M = NULL
--				  ,N = NULL
--				  ,O = NULL
--				  ,P = NULL
--				  ,Q = NULL
--				  ,R = NULL
--				  ,S = NULL
--				  ,T = NULL
--				  ,U = NULL
--				  ,V = NULL
--				  ,W = NULL
--				  ,X = NULL
--				  ,Y = NULL
--				  ,Z = NULL
--				  ,Source = NULL
--				  ,Notes = NULL
--				  ,Placement = NULL
--				  ,VendorPrice = NULL
--				  ,VolumePrice = NULL
--				  ,VolumePriceMinimum = NULL
--				  ,VendorProductionMin = NULL
--				  ,VendorProductionLeadTime = NULL
--				  ,MaterialSizeID = NULL
--				  ,MaterialPackLabelGroupID = NULL
--				  ,TradePartnerID = NULL
--				  ,TradePartnerVendorID = NULL
--				  ,MaterialBOM = NULL
--				  ,MaterialCode = NULL
--				  --,Duty = NULL
--				  --,Freight = NULL
--				  --,TotalPrice = NULL
--			WHERE StyleID = @NewStyleID
--		ELSE
--			UPDATE pStyleMaterials SET MaterialBOM = NULL WHERE StyleID = @NewStyleID
--	END


BEGIN

	DROP TABLE #tempStyleMaterials
	DROP TABLE #tempCopyStyleMaterials
	DROP TABLE #tempStyleColorway
	DROP TABLE #tempCopyStyleColorway
	DROP TABLE #tempStyleColorwayItem
	DROP TABLE #tempCopyStyleColorwayItem
	DROP TABLE #tempStyleSeasonYear
	DROP TABLE #tempStyleColorwaySeasonYear

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09173', GetDate())
GO