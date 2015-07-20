/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleNewLogic_UPDATE]    Script Date: 02/05/2013 11:42:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleNewLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanStyleNewLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleNewLogic_UPDATE]    Script Date: 02/05/2013 11:42:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* #01 - Clay Parker - Oct 1 2009
The field Division was not updating from the LinePlan onto the style header of the style. 

   #02 - Clay Parker - Nov 19 2009
Commented out the Delete Costing/Quote information from the style. This was procedure is also being used for Carry Over style
creation. If you carry a style over it deletes the previous costing information from pstyle header and the quotes. Big Big Issue.

	#03 - Clay Parker Nov 23 2009
Commented out StyleCostingCustomField1 from being updated when a style is created. This price should now come from the price grid.
	#04 - Clay Parker Feb 1 2010
Modified the statement to select the development status instead of concept. 0 to 1.

	#05 - Artemio Gomez / 2010-04-13
Update pStyleHeader with main material info.

	#06 - Artemio Gomez / 2010-04-13
Update pStyleSeasonyear with LinePlanItemID 

	#07 - Clayton Parker Sept 23 2010
Modified the Subset Grid selection so it pulls off of the pSizeRange.SizeRangeKey
	
	#08 - Clayton Parker Oct 13 2010
Updated the procedure to only update when the SubSet Grid value is NULL or ''
*/

CREATE PROCEDURE [dbo].[spx_LinePlanStyleNewLogic_UPDATE]
(
	@LinePlanRangeTypeID uniqueidentifier,
	@LinePlanRangeID uniqueidentifier,
	@LinePlanItemID uniqueidentifier,
	@LinePlanID uniqueidentifier,
	@StyleID uniqueidentifier,
	@MUser NVARCHAR(200), 
	@MDate DATETIME, 
	@StyleSeasonYearID UNIQUEIDENTIFIER,
	@WorkflowTemplateID UNIQUEIDENTIFIER = NULL
)
AS

--***
--** BEGIN Comment #6
--** Update pStyleSeasonyear 
--***
DECLARE @SeasonYearID UNIQUEIDENTIFIER 
DECLARE @Season NVARCHAR(200) 
DECLARE @Year NVARCHAR(200) 

SELECT @SeasonYearID = a.SeasonYearID, @Season = a.Season , @Year = b.Year 
FROM pSeasonYear a WITH (NOLOCK) 
	INNER JOIN pLinePlan b WITH (NOLOCK) ON a.Season =  b.Season AND a.Year =  b.Year 
WHERE b.LinePlanID = @LinePlanID 

IF EXISTS( SELECT * FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID  ) 
BEGIN
	UPDATE pStyleSeasonYear SET LinePlanID = @LinePlanID, LinePlanItemID = @LinePlanItemID,
	MDate = @MDate , MUser = @MUser 
	WHERE StyleSeasonYearID = @StyleSeasonYearID 
END 
ELSE 
BEGIN
	INSERT INTO pStyleSeasonYear(StyleSeasonYearID , StyleID , StyleSeason, StyleYear, CUser, CDate, MUser, Mdate, 
	SeasonYearID,LinePlanID , LinePlanITemID )
	VALUES (NEWID(), @StyleID , @Season, @Year, @MUser, @MDate, @MUser, @MDate, 
	@SeasonYearID, @LinePlanID , @LinePlanITemID )
END 
--***
--***


UPDATE pLinePlanItem SET 
	LinePlanRangeTypeID = @LinePlanRangeTypeID,
	StyleID = @StyleID,
	MDate = @MDate,
	MUser = @MUser
WHERE LinePlanItemID = @LinePlanItemID 


---- DELETE ALL COSTING /QUOTES 
--DELETE FROM pStylecosting WHERE StyleID = @StyleID   --Comment #02
--DELETE FROM pStylecostingHeader WHERE StyleID = @StyleID	--Comment #02
--DELETE FROM pStyleQuoteItem WHERE StyleID = @StyleID	--Comment #02


DECLARE @StyleSeason VARCHAR(50)
DECLARE @StyleYear VARCHAR(50)
DECLARE @LinePlanAttributeItemId1 VARCHAR(50)
DECLARE @LinePlanAttributeItemId2 VARCHAR(50)
DECLARE @LinePlanAttributeItemId3 VARCHAR(50)
DECLARE @LinePlanAttributeItemId4 VARCHAR(50)
DECLARE @Division NVARCHAR(200) -- #01

-- Start #01  / -- comment #5
	Select @Division = b.LinePlanAttributeText1 
	from pLinePlanItem a WITH (NOLOCK) 
		INNER JOIN pLinePlanRange b WITH (NOLOCK) ON a.LinePlanRangeID = b.LinePlanRangeID
	Where LinePlanItemId= @LinePlanItemID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'


	DECLARE @MaterialID UNIQUEIDENTIFIER
	DECLARE @MaterialImageID  UNIQUEIDENTIFIER
	DECLARE @MaterialImageVersion  INT
	DECLARE @MaterialNo NVARCHAR(200)
	DECLARE @MaterialName NVARCHAR(200)
	DECLARE @StyleMaterialID UNIQUEIDENTIFIER
	
	SELECT TOP 1 @MaterialID = MaterialID, @MaterialImageID = MaterialImageID,
	@MaterialImageVersion  = MaterialImageVersion , @MaterialNo = MaterialNo,
	@MaterialName = MaterialName, @StyleMaterialID = StyleMaterialID
	FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleID = @StyleID 	
	AND MainMaterial = 1
	

	--***
	--** Define PACKAGING according Merch category / 
	--** CustomField25 - Packaging
	--** CustomField4 - Merch Category
	--***
	DECLARE @CustomField25 NVARCHAR(200)
	SELECT @CustomField25 = Packaging  
	FROM pStyleHeader a WITH (NOLOCK) 
		LEFT OUTER JOIN aCustom12 b WITH (NOLOCK)  ON a.CustomField4 = b.Custom 
	WHERE a.StyleID = @StyleID 
	--***

	
	UPDATE pStyleHeader SET 
	MaterialID = @MaterialID , 
	MaterialImageID = @MaterialImageID,
	MaterialImageVersion  = @MaterialImageVersion ,
	MaterialNo = @MaterialNo ,
	MaterialName = @MaterialName ,
	StyleMaterialID = @StyleMaterialID,
	--CustomField2 = @Division, -- comment #2
	CustomField2 = @Season,
	CustomField4 = @Year,
	IntroSeasonYearID = @SeasonYearID,
	CustomField25 = @CustomField25
	WHERE StyleID = @StyleID 

-- End #01

SELECT  
	@LinePlanAttributeItemId1 = LinePlanAttributeItemId1,
	@LinePlanAttributeItemId2 = LinePlanAttributeItemId2,
	@LinePlanAttributeItemId3 = LinePlanAttributeItemId3,
	@LinePlanAttributeItemId4 = LinePlanAttributeItemId4
FROM pLinePlanRange WITH (NOLOCK)  WHERE LinePlanRangeId = @LinePlanRangeId


SELECT 
	@StyleSeason = Season, 
	@StyleYear = [Year] 
FROM pLinePlan WITH (NOLOCK) WHERE LinePlanID = @LinePlanID

DECLARE @StyleTypeID INT --BRAND
SELECT @StyleTypeID = StyleTypeID FROM fnx_LinePlanStyleType(@LinePlanRangeID)

DECLARE @StyleCategoryID UNIQUEIDENTIFIER
SELECT @StyleCategoryID = StyleCategoryID FROM fnx_LinePlanStyleCategory(@LinePlanRangeID)

DECLARE @StyleDivision VARCHAR(200)
SELECT @StyleDivision = StyleDivision FROM fnx_LinePlanStyleDivision(@LinePlanRangeID)


DECLARE @PL1_NoOfStyle INTEGER
DECLARE @PL1_NoOfFabric INTEGER
DECLARE @PL1_NoOfBody INTEGER 
DECLARE @PL1_NoOfColor INTEGER
DECLARE @PL1_NoOfOptions INTEGER
DECLARE @PL1_MarkupFactor DECIMAL(18, 3)
DECLARE @PL1_TargetAvgRetailPriceLow DECIMAL(18, 3)
DECLARE @PL1_TargetAvgRetailPriceMed DECIMAL(18, 3)
DECLARE @PL1_TargetAvgRetalPriceHigh DECIMAL(18, 3)
DECLARE @PL1_NoOfStyleLow DECIMAL(18, 3)
DECLARE @PL1_NoOfStyleMed DECIMAL(18, 3)
DECLARE @PL1_NoOfStyleHigh DECIMAL(18, 3)
DECLARE @PL1_TargetAvgWhsPrice DECIMAL(18, 3)
DECLARE @PL1_AvgTargetFOB DECIMAL(18, 3)
DECLARE @PL1_SalesUnit DECIMAL(18, 3)
DECLARE @PL1_ProjectedWhs DECIMAL(18, 3)
--DECLARE @PL1_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL1_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL1_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL1_WeightGrossMarginRtl DECIMAL(18, 3)

/*
SELECT TOP 1 
	@PL1_InitialGrossMarginRtl = LinePlanBusPnCh1
FROM pLinePlanBusiness
WHERE (LinePlanAttributeItemID1 = @LinePlanAttributeItemID1) 
	AND (LinePlanAttributeItemID2 = @LinePlanAttributeItemID2) 
	AND (LinePlanAttributeItemID3 = @LinePlanAttributeItemID3)
	AND (LinePlanID = @LinePlanID)
	AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000010'
*/

SELECT TOP 1 
	@PL1_TargetAvgRetailPriceMed = LinePlanBusPnCh1
FROM pLinePlanBusiness WITH (NOLOCK) 
WHERE (LinePlanAttributeItemID1 = @LinePlanAttributeItemID1) 
	AND (LinePlanAttributeItemID2 = @LinePlanAttributeItemID2) 
	AND (LinePlanAttributeItemID3 = @LinePlanAttributeItemID3)
	AND (LinePlanID = @LinePlanID)
	AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000022'

SELECT TOP 1  
	@PL1_MarkupFactor = LinePlanBusPnCh1 
FROM pLinePlanBusiness WITH (NOLOCK) 
WHERE (LinePlanAttributeItemID1 = @LinePlanAttributeItemID1) 
	AND (LinePlanAttributeItemID2 = @LinePlanAttributeItemID2) 
	AND (LinePlanAttributeItemID3 = @LinePlanAttributeItemID3)
	AND (LinePlanID = @LinePlanID)
	AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000005'


--GET Average Target FOB 
SELECT TOP 1  
	@PL1_AvgTargetFOB = LinePlanBusPnCh1 
FROM pLinePlanBusiness WITH (NOLOCK) 
WHERE (LinePlanAttributeItemID1 = @LinePlanAttributeItemID1) 
	AND (LinePlanAttributeItemID2 = @LinePlanAttributeItemID2) 
	AND (LinePlanAttributeItemID3 = @LinePlanAttributeItemID3)
	AND (LinePlanID = @LinePlanID)
	AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000006'


--Calculate Average Target FOB 
--SET @PL1_AvgTargetFOB = (@PL1_TargetAvgRetailPriceMed - (@PL1_TargetAvgRetailPriceMed * @PL1_InitialGrossMarginRtl)) 

--StyleCostingCustomField1 = Target Retail GBP = Manual Input
--StyleCostingCustomField2 = Target First Cost = Average Target FOB
--StyleCostingCustomField3 = Margin Markup = (StyleCostingCustomField1-StyleCostingCustomField2)/StyleCostingCustomField1
--StyleCostingCustomField4 = Units =Manual Input
--StyleCostingCustomField5 = Wholesale Margin = StyleCostingCustomField6-StyleCostingCustomField2/StyleCostingCustomField6
--StyleCostingCustomField6 = Target Wholesale Price = StyleCostingCustomField1/MarkupFactor

DECLARE @StyleCostingCustomField1 DECIMAL(18,3)
DECLARE @StyleCostingCustomField2 DECIMAL(18,3)
DECLARE @StyleCostingCustomField3 DECIMAL(18,3)
DECLARE @StyleCostingCustomField4 DECIMAL(18,3)
DECLARE @StyleCostingCustomField5 DECIMAL(18,3)
DECLARE @StyleCostingCustomField6 DECIMAL(18,3)

--SET @StyleCostingCustomField1 = @PL1_TargetAvgRetailPriceMed -- #03
SET @StyleCostingCustomField2 = @PL1_AvgTargetFOB  
SET @StyleCostingCustomField3 = CASE WHEN @StyleCostingCustomField1 = 0 THEN 0 ELSE (@StyleCostingCustomField1-@StyleCostingCustomField2)/@StyleCostingCustomField1 END
SET @StyleCostingCustomField4 = 0
SET @StyleCostingCustomField6 = CASE WHEN @PL1_MarkupFactor = 0 THEN 0 ELSE @StyleCostingCustomField1/@PL1_MarkupFactor END
SET @StyleCostingCustomField5 = CASE WHEN @StyleCostingCustomField6 = 0 THEN 0 ELSE (@StyleCostingCustomField6-@StyleCostingCustomField2)/@StyleCostingCustomField6 END

IF NOT EXISTS(SELECT * FROM pStyleCostingHeader WITH (NOLOCK) WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID) 
BEGIN
	INSERT INTO dbo.pStyleCostingHeader (StyleID, StyleCostingCustomField1, 
		StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, 
		StyleCostingCustomField5, StyleCostingCustomField6, CUser, MUser, CDate, MDate , StyleSeasonYearID) 
     VALUES  (@StyleID, @StyleCostingCustomField1, @StyleCostingCustomField2, @StyleCostingCustomField3, 
		@StyleCostingCustomField4, @StyleCostingCustomField5, @StyleCostingCustomField6, 
		@MUser, @MUser, @MDate, @MDate , @StyleSeasonYearID)

	INSERT INTO pStyleCosting(StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, 
	StyleCostingStatus, CUser, CDate, MUser, MDate, Active, StyleSeasonYearID)
	SELECT @StyleID, StyleCostingTypeID, 1, '00000000-0000-0000-0000-000000000000', @MDate, 
	0, @MUser, @MDate, @MUser, @MDate, 1, @StyleSeasonYearID AS StyleSeasonYearID
	FROM pStyleCostingType WITH (NOLOCK) WHERE Active = 1

END

/***
** Copy MostLikely vendor sourcing data 
***/
DECLARE @StyleSYID UNIQUEIDENTIFIER 
DECLARE @TPVID UNIQUEIDENTIFIER 
DECLARE @SYID UNIQUEIDENTIFIER 

SELECT TOP 1 @StyleSYID  = a.StyleSeasonYearID,  @TPVID  = a.TradePartnerVendorID , @SYID = a.SeasonYearID
FROM pStyleSeasonYear a WITH(NOLOCK) 
	INNER JOIN uTradePartnerVendor b WITH(NOLOCK) ON a.TradepartnerVendorID =  b.TradepartnerVendorID 
WHERE a.StyleID = @StyleID 
	AND a.MostLikelyVendor = 1 
ORDER BY a.CDate DESC 

IF  @StyleSYID  IS NOT NULL AND @TPVID  IS NOT NULL AND @SYID IS NOT NULL 
BEGIN 

	DECLARE @StyleSourcingID UNIQUEIDENTIFIER 
	DECLARE @NewSSID UNIQUEIDENTIFIER 
	
	SET @NewSSID = NEWID()
	
	SELECT TOP 1 @StyleSourcingID  = StyleSourcingID  
	FROM pStyleSourcing WITH(NOLOCK) 
	WHERE StyleID = @StyleID 
		AND TradePartnerVendorID  = @TPVID  
		AND StyleSeasonYearID = @StyleSYID


	/*** 
	** Copy Sourcing and sourcing items 
	***/
	INSERT INTO pStyleSourcing ( StyleSourcingID , StyleID , SourcingName, CDate, CUser, MDate, MUser, 
	Custom1, Custom2, Active, TradePartnerID , TradePartnerVendorID ,StyleSeasonYearID  ) 
	SELECT TOP 1 @NewSSID AS StyleSourcingID , StyleID , SourcingName, @MDate, @MUser, @MDate, @MUser, 
	Custom1, Custom2, Active, TradePartnerID , TradePartnerVendorID , @StyleSeasonYearID 
	FROM pStyleSourcing  WITH(NOLOCK) 
	WHERE StyleSourcingID =  @StyleSourcingID 

	
	INSERT INTO pStyleSourcingItem (StyleSourcingItemID, StyleSourcingID , CDate, CUser, MDate, MUser, StyleMaterialID, 
		StyleColorID,  StyleSet, BOM, CustomField1 ) 
	SELECT NEWID() AS StyleSourcingItemID, @NewSSID AS StyleSourcingID , @MDate, @MUser, @MDate, @MUser, StyleMaterialID, 
		StyleColorID,  StyleSet, BOM, CustomField1 
	FROM pStyleSourcingItem  WITH(NOLOCK) 
	WHERE StyleSourcingID = @StyleSourcingID 
		AND  StyleColorID IN ( 
			SELECT StyleColorwayID  FROM pStyleColorwaySeasonYear WITH(NOLOCK) 
			WHERE StyleID = @StyleID  
			AND StyleSeasonyearID = @StyleSeasonYearID
		)

	/***
	** Update Mostlikely vendor in StyleSeasonyear table 
	**/	
	UPDATE pStyleSeasonYear	SET TradePartnerVendorID  = @TPVID,
	MostLikelyVendor = 1 
	WHERE StyleSeasonyearID = @StyleSeasonyearID 
	
END 


--***
--** Burberry Logic 
--***

IF @LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' 
BEGIN
	--***
	--** Define Style workflowtemplate items
	--***
	
	IF @WorkflowTemplateID IS NULL
	BEGIN
		IF @StyleTypeID = 34 OR @StyleTypeID = 36 OR @StyleTypeID = 38 OR @StyleTypeID = 40 OR @StyleTypeID = 42 OR @StyleTypeID = 44
		BEGIN 
			--***
			--** Mens / Womens
			--***	
			SET @WorkflowTemplateID = '7CBDDD58-B08E-4723-9477-C9E791CDF36E'
		END 
		ELSE IF @StyleTypeID = 18 OR @StyleTypeID = 20 OR @StyleTypeID = 22 OR @StyleTypeID = 23 OR @StyleTypeID = 26 OR @StyleTypeID = 30
		BEGIN 
			--***
			--** Non-Apparel
			--***		
			SET @WorkflowTemplateID = 'FA6CFCB1-08E0-46C2-827F-9F481B950613'
		END 
		ELSE
		BEGIN
			--***
			--** LinePlan Template
			--***			
			SET @WorkflowTemplateID = '10000000-1000-1000-1000-100000000000'
		END 
	END
	

		
	--IF  ( SELECT COUNT(*) FROM pStyleHeader WHERE StyleID = @StyleID AND StyleType IN ( 34,36,38,40,42,44)  ) > 0 
	BEGIN 
		
		
		--***
		--** Update Style workflows, copy items from Template 
		--***
		DELETE FROM pStyleWorkflow  WHERE  StyleID = @StyleID 

		CREATE TABLE #pWorkflowTemplateItem  (
			RowID INT IDENTITY (1,1) , 
			WorkflowID UNIQUEIDENTIFIER ,
			WorkflowSort NVARCHAR(2) ,
			WorkflowDays INT, 
			WorkflowAssignedTo INT 
		)

		INSERT INTO #pWorkflowTemplateItem  (WorkflowID, WorkflowSort, WorkflowDays,WorkflowAssignedTo) 
		SELECT WorkflowID, WorkflowSort, WorkflowDays,WorkflowAssignedTo
		FROM pWorkflowTemplateItem  WITH(NOLOCK) 
		WHERE WorkflowTemplateID = @WorkflowTemplateID

		DECLARE @WorkflowID UNIQUEIDENTIFIER  
		DECLARE @WorkflowSort NVARCHAR(2)
		DECLARE @WorkflowDays INT 
		DECLARE @WorkflowAssignedTo INT 

		DECLARE @TOTAL INT
		DECLARE @ROW_ID INT 
		SELECT @TOTAL = COUNT(*) FROM #pWorkflowTemplateItem 
		SET @ROW_ID = 1 

		DECLARE @intWorkflowDays INT 
		DECLARE @WorkDue DATETIME 

		WHILE @ROW_ID <= @TOTAL 
		BEGIN 
			SET @intWorkflowDays = 0 
			
			SELECT @WorkflowID = WorkflowID, @WorkflowSort = WorkflowSort, 
			@WorkflowDays = ISNULL(WorkflowDays,0) , @WorkflowAssignedTo = WorkflowAssignedTo
			FROM #pWorkflowTemplateItem WHERE RowID = @ROW_ID
				
			IF @WorkflowDays > 0
				SET @intWorkflowDays = @WorkflowDays * (-1)
			
			SET @WorkDue = DATEADD(DAY, @intWorkflowDays, @MDate) 
			
			EXEC  spx_StyleWorkflow_INSERT 
			@StyleID = @StyleID,
			@StyleSet = 1 ,
			@WorkflowID = @WorkflowID,
			@WorkflowType = '',
			@WorkDate = @MDate,
			@WorkStart = @MDate,
			@WorkDue = @WorkDue,
			@WorkAssignedTo = @WorkflowAssignedTo,
			@WorkStatus = 6 ,
			@WorkSort = @WorkflowSort,
			@WorkVersion = '',
			@WorkComments = '',
			@UserName = @MUser ,
			@UserDate =@MDate ,
			@WorkDay = @WorkflowDays
					
			SET  @ROW_ID = @ROW_ID + 1 
			
		END		

		EXEC spx_StyleWorkflowSchedule_UPDATE
		@StyleId = @StyleID , 
		@WorkflowTemplateId = @WorkflowTemplateID,
		@DueDate = @MDate,
		@StyleStatusId = 1,		--Comment #04
		@ModifiedBy = @MUser,
		@ModifiedDate = @MDate
	
	END 
END 



--***
--** Burberry Logic: Update PLMCode
--***
UPDATE pStyleColorway 
SET PLMCode = ISNULL(pStyleHeader.StyleNo,'')  + ISNULL(pColorPalette.ColorCode,'') 
FROM pStyleColorway 
INNER JOIN pStyleHeader ON pStyleColorway.StyleID = pStyleHeader.StyleID 
INNER JOIN pColorPalette ON pColorPalette.ColorPaletteID =  pStyleColorway.ColorPaletteID  
WHERE pStyleHeader.StyleID = @StyleId




--***
--** Burberry Logic: Update Subset grid 
--***

DECLARE @SIZECLASS NVARCHAR(200)
DECLARE @SIZERANGE NVARCHAR(200)
DECLARE @MERCH NVARCHAR(200)
DECLARE @SubsetGrid NVARCHAR(200)
/* Updated #07 */



SELECT @MERCH = c.CustomKey, @SIZECLASS = b.CustomKey, @SIZERANGE = d.SizeRangekey --, CustomField26  
FRom pStyleHeader a WITH(NOLOCK) 
	INNER JOIN pSizeClass b WITH(NOLOCK) ON a.SizeClass = b.Custom
	INNER JOIN aCustom12 c WITH(NOLOCK) ON a.CustomField4 = c.Custom
	INNER JOIN pSizeRange d WITH(NOLOCK) ON a.SizeRange = d.SizeRangeCode
WHERE StyleID = @StyleID

--SELECT TOP 1 @SubsetGrid = SubsetGridDescription from xCustom88 WITH(NOLOCK) 
--WHERE CustomKey  = @MERCH 
--AND Dimension = @SIZECLASS
--AND Size = @SIZERANGE

/* Old
--SELECT @MERCH = c.CustomKey, @SIZECLASS = b.CustomKey, @SIZERANGE = a.SizeRange --, CustomField26  
--FRom pStyleHeader a
--INNER JOIN pSizeClass b ON a.SizeClass = b.Custom
--INNER JOIN aCustom12 c ON a.CustomField4 = c.Custom
--WHERE StyleID = @StyleID
--
--SELECT TOP 1 @SubsetGrid = SubsetGridDescription from xCustom88
--WHERE CustomKey  = @MERCH 
--AND Dimension = @SIZECLASS
--AND Size = @SIZERANGE
*/

UPDATE pStyleHeader SET  CustomField26 = @SubsetGrid 
WHERE StyleID = @StyleID 

--and CustomField26 IS NULL or CustomField26 = ''   -- #08

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04967', GetDate())
GO