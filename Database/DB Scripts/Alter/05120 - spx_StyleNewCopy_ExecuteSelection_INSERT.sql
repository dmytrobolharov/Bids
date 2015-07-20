/****** Object:  StoredProcedure [dbo].[spx_StyleNewCopy_ExecuteSelection_INSERT]    Script Date: 02/25/2013 17:27:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewCopy_ExecuteSelection_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewCopy_ExecuteSelection_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNewCopy_ExecuteSelection_INSERT]    Script Date: 02/25/2013 17:27:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNewCopy_ExecuteSelection_INSERT](
	@TransactionID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@SqlStyleHeaderUpdate NVARCHAR(MAX),
	@LinkImage INT,
	@AddComments INT,
	@TeamID UNIQUEIDENTIFIER,
	@SrcStyleID UNIQUEIDENTIFIER,
	@DevNo NVARCHAR(200),
	@DevTempID NVARCHAR(200),
	@DevTempNo NVARCHAR(200),
	@CDate DATETIME
)
AS 

DECLARE 
	@CUser NVARCHAR(200),
	@StyleSet INT, 
	@SizeClass NVARCHAR(50),
	@SizeRange NVARCHAR(50),
	@tmpSqlStyleHeaderUpdate NVARCHAR(MAX),
	@SeasonYearID_Param UNIQUEIDENTIFIER

SET @SeasonYearID_Param = @SeasonYearID

SELECT @StyleSet = StyleSet, @SizeClass = SizeClass, @SizeRange = SizeRange
FROM dbo.pStyleHeader WITH(NOLOCK)
WHERE StyleID =  @SrcStyleID 

	
IF @StyleSet IS NULL OR @StyleSet = 0 
	SET @StyleSet = 1 
	
SELECT @CUser = ISNULL(FirstName,'') + ' ' +  ISNULL(LastName,'')  FROM dbo.Users WITH (NOLOCK) WHERE TeamID = @TeamID 


CREATE TABLE #st(
	RowID INT IDENTITY(1,1),
	StyleID UNIQUEIDENTIFIER,
	NewStyleID UNIQUEIDENTIFIER DEFAULT NEWID(),
	Variation INT,
	StyleDevelopmentName NVARCHAR(100) NULL 
)

--** Insert first the Source StyleID
--INSERT INTO #st(StyleID, Variation )
--SELECT DISTINCT a.StyleID, Variation 
--FROM pStyleCopyTmp a
--	INNER JOIN dbo.pStyleDevelopmentItem b ON a.StyleID = b.StyleID
--WHERE a.TransactionID = @TransactionID	
--AND b.StyleID = @SrcStyleID


INSERT INTO #st(StyleID, Variation, StyleDevelopmentName)
SELECT DISTINCT a.StyleID, Variation, StyleDevelopmentName
FROM pStyleCopyTmp a
	INNER JOIN dbo.pStyleDevelopmentItem b ON a.StyleID = b.StyleID
WHERE a.TransactionID = @TransactionID	
AND b.StyleID = @SrcStyleID
UNION
SELECT DISTINCT c.StyleID, c.Variation, c.StyleDevelopmentName 
FROM pStyleCopyColorTmp a
	INNER JOIN dbo.pStyleColorway b ON a.StyleColorID =  b.StyleColorID
	INNER JOIN dbo.pStyleDevelopmentItem c ON c.StyleID = b.StyleID
WHERE a.TransactionID = @TransactionID	
AND b.StyleID = @SrcStyleID


INSERT INTO #st(StyleID, Variation, StyleDevelopmentName)
SELECT DISTINCT a.StyleID, Variation, StyleDevelopmentName
FROM pStyleCopyTmp a
	INNER JOIN dbo.pStyleDevelopmentItem b ON a.StyleID = b.StyleID
WHERE a.TransactionID = @TransactionID	
AND b.StyleID <> @SrcStyleID
UNION
SELECT DISTINCT c.StyleID, c.Variation, c.StyleDevelopmentName
FROM pStyleCopyColorTmp a
	INNER JOIN dbo.pStyleColorway b ON a.StyleColorID =  b.StyleColorID
	INNER JOIN dbo.pStyleDevelopmentItem c ON c.StyleID = b.StyleID
WHERE a.TransactionID = @TransactionID	
AND b.StyleID <> @SrcStyleID

DECLARE 
	@TOTAL INT,
	@ROWID INT,
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@wfTOTAL INT,
	@wfROWID INT,
	@Map UNIQUEIDENTIFIER, 
	@WorkflowItemID UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER,
	@StyleDevelopmentName NVARCHAR(100) 

DECLARE 
	@Colorway INT,	
	@Material INT,
	@Costing INT

SET @ROWID = 1 
SELECT @TOTAL  =  COUNT(*) FROM #st

--** StyleDevelopment 
DECLARE @StyleDevelopmentID UNIQUEIDENTIFIER
SET @StyleDevelopmentID  = NEWID()

INSERT INTO pStyleDevelopment ( StyleDevelopmentID , StyleDevelopmentNo, TempID, TempNo, CUser, CDate, MUser, MDate ) 
	VALUES ( @StyleDevelopmentID , @DevNo, @DevTempID, @DevTempNo, @CUser, @CDate, @CUser, @CDate)


WHILE @TOTAL >= @ROWID
BEGIN 

	SELECT @NewStyleID = NewStyleID, @StyleID = StyleID, @StyleDevelopmentName = StyleDevelopmentName FROM #st WHERE RowID = @ROWID

	--** Copy styleHeader 
	EXECUTE spx_StyleCopyPage_Header_INSERT @TransactionID = @TransactionID, @StyleID = @StyleID, 
		@NewStyleID = @NewStyleID,@CDate = @CDate, @CUser = @CUser 
	
	--** Update StyleHeader
	SET @tmpSqlStyleHeaderUpdate = REPLACE( @SqlStyleHeaderUpdate, '12345678-0000-000-0000-ABCDEFGHIJKL' , @NewStyleID )
	EXEC(@tmpSqlStyleHeaderUpdate)
	
	--** Get intro SeasonYear
	SELECT @SeasonYearID = IntroSeasonYearID FROM pStyleHeader WHERE StyleID = @NewStyleID
	IF @SeasonYearID IS NULL
		SET @SeasonYearID = @SeasonYearID_Param
	
	--** restore sizeclase/sizerange from source (style) and set StyleDevelopment
	UPDATE pStyleHeader SET 
		SizeClass = @SizeClass, SizeRange = @SizeRange, 
		DevelopmentID = @StyleDevelopmentID, DevelopmentNo = @DevNo,
		MUser = @CUser, MDate = @CDate
	WHERE StyleID = @NewStyleId	
	
	
	--** StyleDevelopmentItems
	INSERT INTO pStyleDevelopmentItem( StyleDevelopmentItemID, StyleDevelopmentID, StyleDevelopmentName, StyleID, SizeRange, Variation, CUser, CDate, MUser, MDate )
	VALUES ( NEWID(), @StyleDevelopmentID, @StyleDevelopmentName, @NewStyleId, @SizeRange, @ROWID, @CUser, @CDate, @CUser, @CDate)

	--** Insert workflowItems 
	INSERT INTO pStyleWorkflow(
		StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, 
		WorkDue, WorkAssignedTo, WorkComplete, WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, 
		WorkComments, WorkSort, CUser, CDate, MUser, MDate, WorkDay )
	SELECT NEWID() AS StyleWorkflowID, @NewStyleID AS StyleID, b.StyleSet, b.WorkflowID, b.WorkflowType, b.WorkflowOrder, b.WorkDate, b.WorkStart, 
		b.WorkDue, b.WorkAssignedTo, 0 AS WorkComplete, 6 AS WorkStatus, NULL AS WorkStatusDate, NULL  AS WorkStatusBy, 0 AS WorkVersion, 
		b.WorkComments, b.WorkSort, @CUser, @CDate, @CUser, @CDate , b.WorkDay 
	FROM dbo.pStyleWorkflow b 
	WHERE b.StyleID = @StyleID
		
	
	---**  Seasonyear Information
	DELETE FROM pStyleSeasonYear WHERE StyleID = @NewStyleID
	SET @StyleSeasonYearID = NEWID()
	
	INSERT INTO dbo.pStyleSeasonYear (
		StyleSeasonYearID, SeasonYearID,StyleID, StyleSeason, StyleYear, CUser, CDate, MUser, MDate )
	SELECT @StyleSeasonYearID, SeasonYearID, @NewStyleID, Season, Year, @CUser, @CDate, @CUser, @CDate
	FROM dbo.pSeasonYear 
	WHERE SeasonYearID = @SeasonYearID
	
	
	--** Update styleworkflows 
	EXECUTE  spx_StyleWorkflowScheaduleCopy_UPDATE @StyleId = @StyleId, @NewStyleId = @NewStyleId, @CreatedBy = @CUser, @CreatedDate = @CDate
	
	--** Copy Quote
	EXEC spx_StyleQuoteCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate
	
	
	--** StyleImages (linked)
	IF @LinkImage =  1 
	BEGIN 
		INSERT INTO pStyleImageItem ( 
			StyleImageItemID, StyleImageItemMasterID, WorkflowID , StyleID , StyleSet, ImageID, 
			ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked, Sort)   		
		SELECT 
			NEWID() as StyleImageItemID , NEWID() as StyleImageItemMasterID, WorkflowID , @NewStyleID AS StyleID , StyleSet, ImageID, 
			ImageVersion, @CUser AS CUser, @CDate AS CDate, @CUser AS MUser, @CDate AS MDate, StyleImageLinked, Sort 
		FROM pStyleImageItem 
		WHERE StyleID = @StyleID 
			AND StyleSet <= @StyleSet
	END 	
	
	
	SET @ROWID = @ROWID + 1
END 


SET @ROWID = 1

WHILE @ROWID <= @TOTAL
BEGIN 

	SELECT @NewStyleID = NewStyleID, @StyleID = StyleID FROM #st WHERE RowID = @ROWID
	SELECT @Colorway = NULL, @Material = NULL

	--** Get intro SeasonYear
	SELECT @SeasonYearID = IntroSeasonYearID FROM pStyleHeader WHERE StyleID = @NewStyleID
	IF @SeasonYearID IS NULL
		SET @SeasonYearID = @SeasonYearID_Param
	
	--** Get workflows
	CREATE TABLE #wf (
		ROWID INT IDENTITY (1,1),
		Map UNIQUEIDENTIFIER,
		WorkflowItemID UNIQUEIDENTIFIER
	)
	
	-- ** Include materials ?
	SELECT @Material = COUNT(*) FROM pStyleCopyTmp 	WHERE TransactionID = @TransactionID 
		AND StyleID = @StyleID AND Map = '30000000-0000-0000-0000-000000000003'
	
	-- ** Include colorways ?
	SELECT @Colorway = COUNT(*)
	FROM pStyleCopyColorTmp	a WITH(NOLOCK)
		INNER JOIN pStyleColorway b WITH(NOLOCK) ON a.StyleColorID =  b.StyleColorID
	WHERE a.TransactionID = @TransactionID 
		AND b.StyleID = @StyleID
		
	-- ** Include costing ?
	SELECT @Costing = COUNT(*) FROM pStyleCopyTmp 	WHERE TransactionID = @TransactionID 
		AND StyleID = @StyleID AND Map = '10000000-0000-0000-0000-000000000010'


	IF @Material > 0 AND @Colorway > 0 
	BEGIN 
		EXECUTE spx_StyleCopyPage_Material_INSERT 
			@TransactionID = @TransactionID,
			@StyleID = @StyleID, @NewStyleID = @NewStyleID,	
			@SrcStyleID = @SrcStyleID,
			@CUser = @CUser, @CDate = @CDate	
	END 
	ELSE IF @Material > 0 
	BEGIN 
		--** Insert Material
		INSERT INTO dbo.pStyleMaterials( 
			StyleMaterialID ,StyleMaterialMasterID ,CopyStyleMaterialID ,MainMaterial ,Development ,MiscColor ,
			StyleSet ,StyleID ,UOM ,Qty ,MaterialPrice ,Ext ,MaterialSize ,MaterialID ,MaterialPlacement ,MaterialPlacementCode ,
			MaterialPlacementDetail ,MaterialImageID ,MaterialImageVersion ,NoColorMatch ,SupplierID ,ComponentTypeID ,
			MaterialType ,MaterialNo ,MaterialName ,A ,B ,C ,D ,E ,F ,G ,H ,I ,J ,K ,L ,M ,N ,O ,
			P ,Q ,R ,S ,T ,U ,V ,W ,X ,Y ,Z ,
			Source ,Notes ,Placement ,VendorPrice ,VolumePrice ,VolumePriceMinimum ,VendorProductionMin ,VendorProductionLeadTime ,
			DetailYesNo ,ImageType ,height ,width ,CDate ,CUser ,MDate ,MUser ,MChange ,SChange ,DChange ,
			CChange ,Action ,ColorPlacement ,Artwork ,License ,Colorway ,MaterialSort ,MaterialTrack ,MaterialLinked ,MaterialDimension ,
			MaterialSizeA0 ,MaterialSizeA1 ,MaterialSizeA2 ,MaterialSizeA3 ,MaterialSizeA4 ,MaterialSizeA5 ,MaterialSizeA6 ,
			MaterialSizeA7 ,MaterialSizeA8 ,MaterialSizeA9 ,MaterialSizeA10 ,MaterialSizeA11 ,MaterialSizeA12 ,MaterialSizeA13 ,
			MaterialSizeA14 ,MaterialSizeA15 ,MaterialSizeA16 ,MaterialSizeA17 ,MaterialSizeA18 ,MaterialSizeA19 ,MaterialSizeB0 ,
			MaterialSizeB1 ,MaterialSizeB2 ,MaterialSizeB3 ,MaterialSizeB4 ,MaterialSizeB5 ,MaterialSizeB6 ,MaterialSizeB7 ,
			MaterialSizeB8 ,MaterialSizeB9 ,MaterialSizeB10 ,MaterialSizeB11 ,MaterialSizeB12 ,MaterialSizeB13 ,MaterialSizeB14 ,
			MaterialSizeB15 ,MaterialSizeB16 ,MaterialSizeB17 ,MaterialSizeB18 ,MaterialSizeB19 ,MaterialLining ,
			MaterialSizeID ,MaterialPackLabelGroupID ,TradePartnerID ,TradePartnerVendorID ,MaterialBOM ,MaterialCode ,
			StyleMaterialLinkID ,MultiCloth ,MaterialCoreItemID ,MaterialSwing)
		SELECT  
			NEWID() AS StyleMaterialID , NULL AS StyleMaterialMasterID ,StyleMaterialID AS CopyStyleMaterialID ,
			--CASE 
			--	WHEN StyleID = @NewStyleID THEN ISNULL(MainMaterial,0) 
			--	ELSE 
			--		0
			ISNULL(MainMaterial,0) AS MainMaterial,
			Development ,MiscColor ,
			StyleSet ,@NewStyleID AS StyleID ,UOM ,Qty ,MaterialPrice ,Ext ,MaterialSize ,MaterialID ,MaterialPlacement ,MaterialPlacementCode ,
			MaterialPlacementDetail ,MaterialImageID ,MaterialImageVersion ,NoColorMatch ,SupplierID ,ComponentTypeID ,
			MaterialType ,MaterialNo ,MaterialName ,A ,B ,C ,D ,E ,F ,G ,H ,I ,J ,K ,L ,M ,N ,O ,
			P ,Q ,R ,S ,T ,U ,V ,W ,X ,Y ,Z ,
			Source ,Notes ,Placement ,VendorPrice ,VolumePrice ,VolumePriceMinimum ,VendorProductionMin ,VendorProductionLeadTime ,
			DetailYesNo ,ImageType ,height ,width ,@CDate ,@CUser ,@CDate ,@CUser , 1 AS MChange , 1 AS SChange ,1 AS DChange ,
			CChange ,Action ,ColorPlacement ,Artwork ,License ,Colorway ,MaterialSort ,MaterialTrack ,MaterialLinked ,MaterialDimension ,
			MaterialSizeA0 ,MaterialSizeA1 ,MaterialSizeA2 ,MaterialSizeA3 ,MaterialSizeA4 ,MaterialSizeA5 ,MaterialSizeA6 ,
			MaterialSizeA7 ,MaterialSizeA8 ,MaterialSizeA9 ,MaterialSizeA10 ,MaterialSizeA11 ,MaterialSizeA12 ,MaterialSizeA13 ,
			MaterialSizeA14 ,MaterialSizeA15 ,MaterialSizeA16 ,MaterialSizeA17 ,MaterialSizeA18 ,MaterialSizeA19 ,MaterialSizeB0 ,
			MaterialSizeB1 ,MaterialSizeB2 ,MaterialSizeB3 ,MaterialSizeB4 ,MaterialSizeB5 ,MaterialSizeB6 ,MaterialSizeB7 ,
			MaterialSizeB8 ,MaterialSizeB9 ,MaterialSizeB10 ,MaterialSizeB11 ,MaterialSizeB12 ,MaterialSizeB13 ,MaterialSizeB14 ,
			MaterialSizeB15 ,MaterialSizeB16 ,MaterialSizeB17 ,MaterialSizeB18 ,MaterialSizeB19 ,MaterialLining ,
			MaterialSizeID ,MaterialPackLabelGroupID ,TradePartnerID ,TradePartnerVendorID ,MaterialBOM ,MaterialCode ,
			StyleMaterialLinkID ,MultiCloth ,MaterialCoreItemID ,MaterialSwing		 
		FROM dbo.pStyleMaterials 
		WHERE StyleID = @StyleID
			--AND MaterialID NOT IN (
			--	SELECT MaterialID FROM dbo.pStyleMaterials WHERE StyleID = @NewStyleID 
			--) 
			
	END 
	ELSE IF @Colorway > 0 
	BEGIN 
	
		--** Insert Colorway
		INSERT INTO dbo.pStyleColorway( 
			StyleColorID,StyleID ,StyleSet ,StyleColorStandardID ,StyleColorNo ,StyleColorName ,MainColor ,Sort ,Version ,
			CDate ,CUser ,MDate ,MUser ,CopyStyleColorID ,ColorPaletteID ,
			StyleColorDelivery1 ,StyleColorDelivery2 ,StyleColorDelivery3 ,StyleColorDelivery4 ,
			StyleColorStatus ,CustomField1 ,Units ,MaterialCoreColorID )
		SELECT
			NEWID() AS StyleColorID, @NewStyleID ,StyleSet ,StyleColorStandardID ,StyleColorNo ,StyleColorName ,MainColor ,Sort ,Version ,
			@CDate ,@CUser ,@CDate ,@CUser ,CopyStyleColorID ,ColorPaletteID ,
			StyleColorDelivery1 ,StyleColorDelivery2 ,StyleColorDelivery3 ,StyleColorDelivery4 ,
			StyleColorStatus ,CustomField1 ,Units ,MaterialCoreColorID 		
		FROM dbo.pStyleColorway
		WHERE StyleID = @StyleID
			AND ColorPaletteID NOT IN (
				SELECT ColorPaletteID FROM dbo.pStyleColorway WHERE StyleID = @NewStyleID 
			) 
			AND StyleColorID IN (
				SELECT StyleColorID FROM dbo.pStyleCopyColorTmp WHERE StyleID = @StyleID 
			)
	END 
	
	INSERT INTO #wf( Map, WorkflowItemID) 
	SELECT Map, WorkflowItemID 
	FROM pStyleCopyTmp 
	WHERE TransactionID = @TransactionID 
		AND StyleID = @StyleID
		AND Map NOT IN (
			'30000000-0000-0000-0000-000000000003',	-- materials
			'40000000-0000-0000-0000-000000000004',	-- colorways
			'10000000-0000-0000-0000-000000000010' -- costing
		)
		
	SELECT @wfTOTAL = COUNT(*) FROM #wf 
	SET @wfROWID = 1 
	
	WHILE @wfROWID <= @wfTOTAL 
	BEGIN 
		SELECT @Map = Map, @WorkflowItemID = WorkflowItemID
		FROM #wf WHERE ROWID = @wfROWID
		
		--** Copy workflow item data
		EXECUTE spx_StyleCopyPage_Workflow_INSERT 
			@StyleID = @StyleID, @NewStyleID = @NewStyleID, @Map = @Map, 
			@WorkflowItemID = @WorkflowItemID, @LinkImage = @LinkImage,
			@StyleSet = @StyleSet,
			@SeasonYearID = @SeasonYearID,
			@CUser = @CUser, @CDate = @CDate
			
		SET @wfROWID = @wfROWID + 1
	END 
	
		
	IF @Costing > 0
	BEGIN
		--** Copy Costing
		EXEC spx_StyleCostingCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate
	END
	
	DROP TABLE #wf


	SET @ROWID = @ROWID + 1 
END			
	

SET @ROWID = 1

WHILE @ROWID <= @TOTAL
BEGIN
	
	SELECT @NewStyleID = NewStyleID, @StyleID = StyleID FROM #st WHERE RowID = @ROWID
	SELECT @Colorway = NULL, @Material = NULL

	--** Get intro SeasonYear
	SELECT @SeasonYearID = IntroSeasonYearID FROM pStyleHeader WHERE StyleID = @NewStyleID
	IF @SeasonYearID IS NULL
		SET @SeasonYearID = @SeasonYearID_Param
	
	--** Update SeasonYear from Into SeasonYear 
	--DECLARE @Season NVARCHAR(20)
	--DECLARE @Year NVARCHAR(20)
	--DECLARE @NewSeasonYearID UNIQUEIDENTIFIER

	--SELECT @Season = b.Custom, @Year = a.CustomField2  
	--FROM dbo.pStyleHeader a WITH(NOLOCK)
	--	INNER JOIN dbo.pSeason b WITH(NOLOCK) ON a.CustomField20 = b.CustomKey 	
	--WHERE StyleID = @NewStyleID


	--IF @Season IS NOT NULL AND @Year IS NOT NULL 
	--BEGIN 
	--	SELECT TOP 1 @NewSeasonYearID = SeasonYearID
	--	FROM dbo.pSeasonYear WITH(NOLOCK) 
	--	WHERE  Season = @Season AND Year =  @Year 

	--	IF @NewSeasonYearID IS NULL 
	--	BEGIN 
	--		SET @NewSeasonYearID = NEWID()	
	--		INSERT INTO pSeasonYear (SeasonYearID, Season, Year, Active, CustomID )
	--		VALUES (@NewSeasonYearID, @Season, @Year, 1,@NewSeasonYearID)
	--	END 
	--END 

	--IF @NewSeasonYearID IS NOT NULL  
	--	UPDATE pStyleSeasonYear 
	--	SET SeasonYearID = @NewSeasonYearID, StyleSeason = @Season, StyleYear = @Year
	--	WHERE StyleID = @NewStyleID 
	--ELSE 
	--	SET @NewSeasonYearID = @SeasonYearID
	--*** 	

	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID
	--**Check Colorways 
	DELETE FROM dbo.pStyleColorwaySeasonYear WHERE StyleID = @NewStyleID

	IF @StyleSeasonYearID IS NOT NULL 
		INSERT INTO dbo.pStyleColorwaySeasonYear (
			StyleColorwaySeasonYearID, StyleSeasonYearID ,StyleColorwayID ,StyleID )
		SELECT NEWID(), @StyleSeasonYearID, a.StyleColorID, @NewStyleID 
		FROM dbo.pStyleColorway a WITH(NOLOCK)
		WHERE a.StyleID = @NewStyleID


	SET @ROWID = @ROWID + 1 
END	


--** Delete temp data	
DELETE FROM pStyleCopyTmp WHERE TransactionID = @TransactionID
DELETE FROM pStyleCopyColorTmp WHERE TransactionID = @TransactionID


SELECT DISTINCT NewStyleID FROM #st

DROP TABLE #st



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05120', GetDate())
GO
