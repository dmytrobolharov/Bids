IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT] (
@MaterialColorSeasonYearID UNIQUEIDENTIFIER,
@MaterialTradePartnerID UNIQUEIDENTIFIER,
@MaterialSizeID UNIQUEIDENTIFIER,
@MaterialRequestGroupID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME 
)
AS


IF @MaterialSizeID IS NULL 
	SET @MaterialSizeID  = '00000000-0000-0000-0000-000000000000'


DECLARE @SeasonYearID UNIQUEIDENTIFIER 
DECLARE @ColorSeasonYearID UNIQUEIDENTIFIER 
DECLARE @TradePartnerID UNIQUEIDENTIFIER
DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER 
DECLARE @MaterialColorID  UNIQUEIDENTIFIER 
DECLARE @MaterialTradePartnerIDNew UNIQUEIDENTIFIER
DECLARE @MaterialTradePartnerColorIDNew UNIQUEIDENTIFIER 
DECLARE @ColorPaletteID UNIQUEIDENTIFIER 
DECLARE @ColorName NVARCHAR(200)
DECLARE @ColorCode NVARCHAR(200)
DECLARE @MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
DECLARE @StartDate DATETIME
DECLARE @DueDate DATETIME

SELECT @ColorSeasonYearID = a.SeasonYearID, @MaterialColorID = a.MaterialColorID,
@ColorPaletteID = b.ColorPaletteID, @ColorName = ColorName, @ColorCode = ColorCode
FROM pMaterialColorSeasonYear a
INNER JOIN pMaterialColor b On a.MaterialColorID = b.MaterialColorID
WHERE a.MaterialColorSeasonYearID = @MaterialColorSeasonYearID

SELECT @TradePartnerID = TradePartnerID,
@MaterialID = MaterialID, @TradePartnerRelationshipLevelID = TradePartnerRelationshipLevelID
FROM pMaterialTradePartner WHERE MaterialTradePartnerID = @MaterialTradePartnerID


/***
** Check if the relation material / tradepartner / seasonyear  Exists
**/
SELECT @MaterialTradePartnerIDNew = MaterialTradePartnerID  FROM pMaterialTradePartner  
WHERE MaterialID = @MaterialID 
AND TradePartnerID = @TradePartnerID
AND SeasonYearID = @ColorSeasonYearID 
AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID

IF @MaterialTradePartnerIDNew IS NULL 
BEGIN 
	SET @MaterialTradePartnerIDNew =  NEWID()
	
	SELECT 
		@MaterialRequestWorkflowTempID = MaterialRequestWorkflowTempID, 
		@StartDate = MaterialRequestWorkflowStartDate,
		@DueDate = MaterialRequestWorkflowDueDate
	FROM pMaterialRequestTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID

	INSERT INTO  pMaterialTradePartner (MaterialTradepartnerID , MaterialID , TradePartnerID , 
	CUser, CDate, MUser, MDate, SeasonYearID, TradePartnerRelationshipLevelID, 
	MaterialRequestWorkflowTempID, MaterialRequestWorkflowStartDate, MaterialRequestWorkflowDueDate) 
	VALUES ( @MaterialTradePartnerIDNew , @MaterialID , @TradePartnerID , 
	@CUser, @CDate, @CUser, @CDate, @ColorSeasonYearID, @TradePartnerRelationshipLevelID, 
	@MaterialRequestWorkflowTempID, @StartDate, @DueDate) 

END 



IF @MaterialSizeID  = '00000000-0000-0000-0000-000000000000'
	SELECT @MaterialTradePartnerColorIDNew = MaterialTradePartnerColorID FROM pMaterialTradePartnerColor
	WHERE MaterialColorID = @MaterialColorID 
	AND MaterialTradepartnerID = @MaterialTradePartnerIDNew
	AND ( MaterialSizeID =  @MaterialSizeID OR MaterialSizeID  IS NULL ) 
ELSE 
	SELECT @MaterialTradePartnerColorIDNew = MaterialTradePartnerColorID  FROM pMaterialTradePartnerColor
	WHERE MaterialColorID = @MaterialColorID 
	AND MaterialTradepartnerID = @MaterialTradePartnerIDNew
	AND MaterialSizeID = @MaterialSizeID 



IF @MaterialTradePartnerColorIDNew IS NULL 
BEGIN

	SET @MaterialTradePartnerColorIDNew = NEWID() 

	INSERT INTO  pMaterialTradePartnerColor ( MaterialTradePartnerColorID, MaterialTradePartnerID , MaterialColorID, MaterialID, 
	ColorFolderID , ColorPaletteID, ColorCode, ColorName, ColorSource, Hex, R, G, B, C, M , Y, K , H, S, L, LAB_L, LAB_A, LAB_B, 
	CDate, CUser, MDate, MUser, MaterialColorVersion, ColorVersion, MaterialSizeID )
	SELECT @MaterialTradePartnerColorIDNew, @MaterialTradePartnerIDNew, @MaterialColorID, @MaterialID, 
	ColorFolderID, ColorPaletteID , ColorCode, ColorName, ColorSource, Hex, R, G, B, C, M , Y, K, H, S, L, LAB_L, LAB_A, LAB_B,
	@CDate, @CUser, @CDate, @CUser, 1, 1, @MaterialSizeID
	FROM pColorPalette
	WHERE ColorPaletteID  = @ColorPaletteID 
	
	
-- insert to pMaterialRequestSubmit and pMaterialRequestSubmitWorkflow
	
	-- "Color" workflows  	
	INSERT INTO pMaterialRequestSubmitWorkflow (MaterialTradePartnerID, MaterialTradePartnerColorID,           
	MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID, MaterialColorID,           
	TradePartnerID, TradePartnerVendorID, [Status], Submit,           
	SubmitDays, ResubmitDays, AssignedTo,           
	StartDate, DueDate, EndDate, CDate, CUser, MDate, MUser,          
	MaterialRequestSubmitAllColors, MaterialRequestPartnerTypeID)

	SELECT @MaterialTradePartnerIDNew, @MaterialTradePartnerColorIDNew,           
	a.MaterialRequestWorkflowTemplateItemID, a.MaterialRequestWorkflowID, @MaterialID, @MaterialColorID,          
	@TradePartnerID, NULL as TradePartnerVendorId, ISNULL(a.[Status],0) AS [Status], 1 AS Submit,           
	a.[Days], a.RDays, a.AssignedTo,           
	b.MaterialRequestWorkflowStartDate as StartDate, 
	ISNULL(a.DueDate, DATEADD(DAY,ISNULL(a.Days, 0), b.MaterialRequestWorkflowStartDate)),
	NULL as EndDate, @CDate, @CUser, @CDate, @CUser, 
	c.MaterialRequestWorkflowColor, a.PartnerTypeID
	FROM pMaterialRequestTempWorkflow a 
	INNER JOIN pMaterialRequestTemp b WITH (NOLOCK) ON a.MaterialRequestGroupID = b.MaterialRequestGroupID
	INNER JOIN pMaterialRequestWorkflow c WITH (NOLOCK) ON a.MaterialRequestWorkflowID = c.MaterialRequestWorkflowID
	WHERE a.MaterialRequestGroupID = @MaterialRequestGroupID
	AND c.MaterialRequestWorkflowColor = 0  
	
	
	INSERT INTO pMaterialRequestSubmit (MaterialRequestSubmitWorkflowID, MaterialTradePartnerColorID, MaterialTradePartnerID,           
	Submit, [Status], AssignedTo, StartDate, SubmitDays, ResubmitDays, DueDate, EndDate, CDate, CUser, MDate, MUser)          
	SELECT a.MaterialRequestSubmitWorkflowID, @MaterialTradePartnerColorIDNew,           
	@MaterialTradePartnerIDNew, 1 AS Submit, ISNULL(a.[Status],0) AS [Status],           
	a.AssignedTo, a.StartDate, a.SubmitDays,           
	a.ResubmitDays, a.DueDate, a.EndDate,          
	@CDate AS CDate, @CUser AS CUser, @CDate AS MDate, @CUser AS MUser          
	FROM pMaterialRequestSubmitWorkflow a  WITH (NOLOCK)           
	INNER JOIN pMaterialRequestWorkflow d WITH (NOLOCK)           
	INNER JOIN pMaterialRequestTempWorkflow e WITH (NOLOCK)  ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID ON  a.MaterialRequestWorkflowTempItemID = e.MaterialRequestWorkflowTemplateItemID          
		AND e.MaterialRequestGroupID = @MaterialRequestGroupID
	LEFT OUTER JOIN pMaterialRequestSubmit f WITH (NOLOCK)  ON f.MaterialRequestSubmitWorkflowID = a.MaterialRequestSubmitWorkflowID AND f.MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew 
	WHERE a.MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew
	AND f.MaterialRequestSubmitWorkflowID IS NULL 
	AND d.MaterialRequestWorkflowColor = 0  
	
	--** For "All colors" workflows --    
	CREATE TABLE #tempNoColorMaterialRequestWorkflowIDs(          
		TableRow INT IDENTITY(1,1),          
		MaterialRequestWorkflowID nVARCHAR(5) COLLATE SQL_Latin1_General_CP1_CI_AS,      
		MaterialRequestWorkflowTempItemID UNIQUEIDENTIFIER  
	)

	DECLARE           
	 @TotalCount INT, 
	 @RowCounter INT, 
	 @MaterialRequestWorkflowTempItemID UNIQUEIDENTIFIER, 
	 @MaterialRequestSubmitID UNIQUEIDENTIFIER, 
	 @MaterialRequestWorkflowID NVARCHAR(5), 
	 @NewMaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER, 
	 @MaterialRequestSubmitWorkflowID_Other UNIQUEIDENTIFIER, 
	 @TotalCount_2 INT,          
	 @RowCounter_2 INT,          
	 @NewMaterialRequestSubmitID UNIQUEIDENTIFIER,          
	 @MaterialRequestSubmitID_Other UNIQUEIDENTIFIER,      
	 @MaterialRequestWorkflowID_Other NVARCHAR(5)  
	
	--** For "All colors" workflows --    
	INSERT INTO #tempNoColorMaterialRequestWorkflowIDs(MaterialRequestWorkflowID, MaterialRequestWorkflowTempItemID)          
	SELECT b.MaterialRequestWorkflowID,  a.MaterialRequestWorkflowTempItemID       
	FROM pMaterialRequestWorkflowTemplateItem a WITH (NOLOCK)
	INNER JOIN pMaterialRequestWorkflow b WITH (NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID
	INNER JOIN pMaterialRequestTempWorkflow c WITH (NOLOCK) ON a.MaterialRequestWorkflowTempItemID = c.MaterialRequestWorkflowTemplateItemID
		AND c.MaterialRequestGroupID = @MaterialRequestGroupID
	WHERE b.MaterialRequestWorkflowColor = 1  
	       
	       
	--***Get counts.          
	SELECT @TotalCount = COUNT(*) FROM #tempNoColorMaterialRequestWorkflowIDs          
	SET @RowCounter = 1          
	      
	--***Loop to get already existing 'no color' bubble info and add it for the new 'no color' bubble.          
	WHILE(@RowCounter <= @TotalCount)          
	BEGIN 
	        
		--***Make new ID.          
		SET @NewMaterialRequestSubmitWorkflowID = NEWID()          

		--***Clear variables.          
		SET @MaterialRequestWorkflowID = NULL          

		--***Get a workflow ID to work with.          
		SELECT   
		@MaterialRequestWorkflowID = MaterialRequestWorkflowID  ,   
		@MaterialRequestWorkflowTempItemID = MaterialRequestWorkflowTempItemID       
		FROM #tempNoColorMaterialRequestWorkflowIDs          
		WHERE TableRow = @RowCounter          


		--***Check to see that a record already doesn't exist.          
		IF NOT EXISTS (SELECT * FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK)           
			WHERE MaterialTradePartnerID = @MaterialTradePartnerIDNew
			AND MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew
			AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID )           
		BEGIN          

			--***Get 'MaterialRequestSubmitWorkflowID' of an already existing 'no color'           
			--***record that will be used as the source to copy info from.          
			SELECT TOP 1 @MaterialRequestSubmitWorkflowID_Other = MaterialRequestSubmitWorkflowID          
			FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK)           
			WHERE MaterialTradePartnerID = @MaterialTradePartnerIDNew
			AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID          

			IF @MaterialRequestSubmitWorkflowID_Other IS NOT NULL   
			BEGIN  
				--***Add new 'no color' record to the 'pMaterialRequestSubmitWorkflow' table using mostly source info.          
				INSERT INTO pMaterialRequestSubmitWorkflow( MaterialRequestSubmitWorkflowID,MaterialTradePartnerID,          
				MaterialTradePartnerColorID, MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID,          
				MaterialColorID,TradePartnerID,TradePartnerVendorID,[Status],Submit,SubmitDays,ResubmitDays,          
				AssignedTo,StartDate,DueDate,EndDate,CDate,CUser,MDate,MUser,TUser,TDate,FinalDate,AgentView          
				,MaterialRequestSubmitAllColors, MaterialRequestPartnerTypeID)   
				SELECT @NewMaterialRequestSubmitWorkflowID,@MaterialTradePartnerIDNew,          
				@MaterialTradePartnerColorIDNew, @MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID,          
				@MaterialColorID, TradepartnerId,TradepartnerVendorId, [Status],Submit,SubmitDays,ResubmitDays,          
				AssignedTo,StartDate,DueDate,EndDate,CDate,CUser,MDate,MUser,TUser,TDate,FinalDate,AgentView          
				,MaterialRequestSubmitAllColors, MaterialRequestPartnerTypeID    
				FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK)           
				WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID_Other        
			END   
			ELSE  
			BEGIN  

				--** from template  
				INSERT INTO pMaterialRequestSubmitWorkflow (MaterialTradePartnerID, MaterialTradePartnerColorID,           
				MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID, MaterialColorID,           
				TradePartnerID, TradePartnerVendorID, [Status], Submit,           
				SubmitDays, ResubmitDays, AssignedTo,           
				StartDate, DueDate, EndDate, CDate, CUser, MDate, MUser,          
				MaterialRequestSubmitAllColors,
				MaterialRequestPartnerTypeID)   
				SELECT a.MaterialTradePartnerId, b.MaterialTradePartnerColorID, 
				d.MaterialRequestWorkflowTemplateItemID, d.MaterialRequestWorkflowID, b.MaterialID, b.MaterialColorID, 
				a.TradepartnerId, a.TradepartnerVendorId, ISNULL(d.[Status],0) AS Status, 1 AS Submit,           
				d.[Days], d.RDays, d.AssignedTo, 
				a.MaterialRequestWorkflowStartDate as StartDate, d.DueDate as DueDate, NULL as EndDate, @CDate, @CUser, @CDate, @CUser,          
				e.MaterialRequestWorkflowColor,
				d.PartnerTypeID  
				FROM pMaterialTradePartner a WITH (NOLOCK)           
				INNER JOIN pMaterialTradePartnerColor b WITH (NOLOCK) ON a.MaterialTradePartnerId = b.MaterialTradePartnerID           
				INNER JOIN pMaterialRequestTempWorkflow d  WITH (NOLOCK) ON a.MaterialRequestWorkflowTempID = d.MaterialRequestWorkflowTempID AND d.MaterialRequestGroupID = @MaterialRequestGroupID
				INNER JOIN pMaterialRequestWorkflow e WITH (NOLOCK)  ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID    
				WHERE b.MaterialColorID = @MaterialColorID   
				AND b.MaterialSizeID = @MaterialSizeID           
				AND a.MaterialTradePartnerID = @MaterialTradePartnerIDNew        
				AND d.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
			  
			END   

			  
			IF NOT EXISTS (SELECT * 
				FROM pMaterialRequestSubmit a   
				INNER JOIN pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
				WHERE b.MaterialTradePartnerID = @MaterialTradePartnerIDNew  
				AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
			)  
			BEGIN   
				DECLARE @MaterialRequestSubmitGroupID UNIQUEIDENTIFIER
							
						SET @MaterialRequestSubmitGroupID = NEWID()
						SET @MaterialRequestSubmitID  = NEWID()

				INSERT INTO pMaterialRequestSubmit (  
				MaterialRequestSubmitID,MaterialRequestSubmitWorkflowID, MaterialTradePartnerColorID, MaterialTradePartnerID,           
				Submit, [Status], AssignedTo, StartDate, SubmitDays, ResubmitDays, DueDate, EndDate, CDate, CUser, MDate, MUser,  
				MaterialRequestSubmitGroupID)          
				SELECT  @MaterialRequestSubmitID,a.MaterialRequestSubmitWorkflowID, a.MaterialTradePartnerColorID,           
				b.MaterialTradePartnerId, 1 AS Submit, 0 AS [Status],           
				a.AssignedTo, a.StartDate, a.SubmitDays,           
				a.ResubmitDays, a.DueDate, a.EndDate,          
				@CDate AS CDate, @CUser AS CUser, @CDate AS MDate, @CUser AS MUser,  
				@MaterialRequestSubmitGroupID          
				FROM pMaterialRequestSubmitWorkflow a WITH (NOLOCK)           
				INNER JOIN pMaterialTradePartner b WITH (NOLOCK) ON a.MaterialTradePartnerID = b.MaterialTradePartnerId  
				INNER JOIN pMaterialRequestWorkflow d WITH (NOLOCK) ON d.MaterialRequestWorkflowID = a.MaterialRequestWorkflowID          
				INNER JOIN pMaterialRequestWorkflowTemplateItem e WITH (NOLOCK) ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID           
				 AND a.MaterialRequestWorkflowTempItemID = e.MaterialRequestWorkflowTempItemID          
				WHERE a.MaterialTradePartnerID = @MaterialTradePartnerIDNew
				AND a.MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew  
				AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID   
				  
				INSERT INTO dbo.pMaterialRequestSubmitGroup(  
				MaterialRequestSubmitGroupID ,MaterialTradePartnerID ,  
				MaterialRequestWorkflowID ,MaterialTradePartnerColorID)  
				VALUES(  
				@MaterialRequestSubmitGroupID, @MaterialTradePartnerIDNew ,  
				@MaterialRequestWorkflowID ,@MaterialTradePartnerColorIDNew)  
				END   
		       
		END --End the 'IF' statement.          
		ELSE    
		BEGIN    
			UPDATE pMaterialRequestSubmitWorkflow SET MaterialRequestWorkflowTempItemID = @MaterialRequestWorkflowTempItemID    
			WHERE MaterialTradePartnerID = @MaterialTradePartnerIDNew         
			AND MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew         
			AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID    

			-- Update PartnerOwner field for all related records of table pMaterialRequestSubmitWorkflow 
			-- because MaterialRequestWorkflow for All Colors
			UPDATE pMaterialRequestSubmitWorkflow SET MaterialRequestPartnerTypeID = 
			(
			SELECT MaterialRequestPartnerTypeID FROM pMaterialRequestSubmitWorkflow 
			WHERE MaterialTradePartnerID = @MaterialTradePartnerIDNew 
			AND MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew
			AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID AND MaterialRequestSubmitAllColors = 1
			)
			WHERE MaterialTradePartnerID = @MaterialTradePartnerIDNew 
			AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID AND MaterialRequestSubmitAllColors = 1

		END   
		 
		--***Up counter.          
		SET @RowCounter = @RowCounter + 1
		
	END --End the loop of going through the 'no color' workflow bubbles.	
	
	DROP TABLE #tempNoColorMaterialRequestWorkflowIDs

END 


DECLARE @MaterialTradePartnerColorID UNIQUEIDENTIFIER 
DECLARE @LastSeasonMaterialtradePartnerID UNIQUEIDENTIFIER 

SELECT TOP 1 @MaterialTradePartnerColorID = MaterialTradePartnerColorID,
@LastSeasonMaterialtradePartnerID = MaterialtradePartnerID
FROM pMaterialTradePartnerColor a
INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
WHERE MaterialTradepartnerID = @MaterialTradepartnerID
AND b.ColorCode = @ColorCode AND b.ColorName = @ColorName and a.MaterialSizeID = @MaterialSizeID  --Comment #01

IF @MaterialTradePartnerColorID  IS NOT NULL AND @LastSeasonMaterialtradePartnerID IS NOT NULL
BEGIN 

	DECLARE @MaterialTradePartnerCustom1 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom2 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom3 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom4 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom5 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom6 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom7 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom8 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom9 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom10 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom11 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom12 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom13 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom14 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom15 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom16 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom17 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom18 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom19 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom20 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom21 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom22 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom23 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom24 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom25 NVARCHAR(50)

	SELECT 	@MaterialTradePartnerCustom1 = MaterialTradePartnerCustom1, @MaterialTradePartnerCustom2 = MaterialTradePartnerCustom2, 
	@MaterialTradePartnerCustom3 = MaterialTradePartnerCustom3, @MaterialTradePartnerCustom4 = MaterialTradePartnerCustom4, 
	@MaterialTradePartnerCustom5 = MaterialTradePartnerCustom5, @MaterialTradePartnerCustom6 = MaterialTradePartnerCustom6, 
	@MaterialTradePartnerCustom7 = MaterialTradePartnerCustom7, @MaterialTradePartnerCustom8 = MaterialTradePartnerCustom8, 
	@MaterialTradePartnerCustom9 = MaterialTradePartnerCustom9, @MaterialTradePartnerCustom10 = MaterialTradePartnerCustom10, 
	@MaterialTradePartnerCustom11 = MaterialTradePartnerCustom11, @MaterialTradePartnerCustom12 = MaterialTradePartnerCustom12, 
	@MaterialTradePartnerCustom13 = MaterialTradePartnerCustom13, @MaterialTradePartnerCustom14 = MaterialTradePartnerCustom14, 
	@MaterialTradePartnerCustom15 = MaterialTradePartnerCustom15, @MaterialTradePartnerCustom16 = MaterialTradePartnerCustom16, 
	@MaterialTradePartnerCustom17 = MaterialTradePartnerCustom17, @MaterialTradePartnerCustom18 = MaterialTradePartnerCustom18, 
	@MaterialTradePartnerCustom19 = MaterialTradePartnerCustom19, @MaterialTradePartnerCustom20 = MaterialTradePartnerCustom20, 	
	@MaterialTradePartnerCustom21 = MaterialTradePartnerCustom21, @MaterialTradePartnerCustom22 = MaterialTradePartnerCustom22, 
	@MaterialTradePartnerCustom23 = MaterialTradePartnerCustom23, @MaterialTradePartnerCustom24 = MaterialTradePartnerCustom24, 
	@MaterialTradePartnerCustom25 = MaterialTradePartnerCustom25	
	FROM pMaterialtradePartner WHERE MaterialtradePartnerID = @LastSeasonMaterialtradePartnerID

	DECLARE @MaterialPrice MONEY
	DECLARE @MaterialTradeColor1 NVARCHAR(200)
	DECLARE @MaterialTradeColor2 NVARCHAR(200)
	DECLARE @MaterialTradeColor3 NVARCHAR(200)
	DECLARE @MaterialTradeColor4 NVARCHAR(200)
	DECLARE @MaterialTradeColor5 NVARCHAR(200)
	DECLARE @MaterialTradeColor6 NVARCHAR(200)
	DECLARE @MaterialTradeColor7 NVARCHAR(200)
	DECLARE @MaterialTradeColor8 NVARCHAR(200)
	DECLARE @MaterialTradeColor9 NVARCHAR(200)
	DECLARE @MaterialTradeColor10 DECIMAL(18,2)
	DECLARE @MaterialTradeColor11 DECIMAL(18,2)
	DECLARE @MaterialTradeColor12 DECIMAL(18,2)
	DECLARE @MaterialTradeColor13 DECIMAL(18,2)
	DECLARE @MaterialTradeColor14 NVARCHAR(200)
	DECLARE @MaterialTradeColor15 NVARCHAR(200)
	DECLARE @MaterialTradeColor16 NVARCHAR(200)
	DECLARE @MaterialTradeColor17 NVARCHAR(200)
	DECLARE @MaterialTradeColor18 NVARCHAR(200)
	DECLARE @MaterialTradeColor19 NVARCHAR(200)
	DECLARE @MaterialTradeColor20 NVARCHAR(200)
	DECLARE @MaterialTradeColor21 NVARCHAR(200)
	DECLARE @MaterialTradeColor22 NVARCHAR(200)
	DECLARE @MaterialTradeColor23 NVARCHAR(200)
	DECLARE @MaterialTradeColor24 NVARCHAR(200)
	DECLARE @MaterialTradeColor25 NVARCHAR(200)

	SELECT @MaterialPrice = MaterialPrice, 
	@MaterialTradeColor1 = MaterialTradeColor1, @MaterialTradeColor2 = MaterialTradeColor2,
	@MaterialTradeColor3 = MaterialTradeColor3, @MaterialTradeColor4 = MaterialTradeColor4,
	@MaterialTradeColor5 = MaterialTradeColor5, @MaterialTradeColor6 = MaterialTradeColor6,
	@MaterialTradeColor7 = MaterialTradeColor7, @MaterialTradeColor8 = MaterialTradeColor8,
	@MaterialTradeColor9 = MaterialTradeColor9, @MaterialTradeColor10 = MaterialTradeColor10,
	@MaterialTradeColor11 = MaterialTradeColor11, @MaterialTradeColor12 = MaterialTradeColor12,
	@MaterialTradeColor13 = MaterialTradeColor13, @MaterialTradeColor14 = MaterialTradeColor14,
	@MaterialTradeColor15 = MaterialTradeColor15, @MaterialTradeColor16 = MaterialTradeColor16,
	@MaterialTradeColor17 = MaterialTradeColor17, @MaterialTradeColor18 = MaterialTradeColor18,
	@MaterialTradeColor19 = MaterialTradeColor19, @MaterialTradeColor20 = MaterialTradeColor20,	
	@MaterialTradeColor21 = MaterialTradeColor21, @MaterialTradeColor22 = MaterialTradeColor22,
	@MaterialTradeColor23 = MaterialTradeColor23, @MaterialTradeColor24 = MaterialTradeColor24,
	@MaterialTradeColor25 = MaterialTradeColor25
	FROM pMaterialtradePartnerColor WHERE MaterialtradePartnerColorID = @MaterialTradePartnerColorID


	UPDATE pMaterialtradePartner SET 
	MaterialTradePartnerCustom1 = @MaterialTradePartnerCustom1, MaterialTradePartnerCustom2 = @MaterialTradePartnerCustom2, 
	MaterialTradePartnerCustom3 = @MaterialTradePartnerCustom3, MaterialTradePartnerCustom4 = @MaterialTradePartnerCustom4, 
	MaterialTradePartnerCustom5 = @MaterialTradePartnerCustom5, MaterialTradePartnerCustom6 = @MaterialTradePartnerCustom6, 
	MaterialTradePartnerCustom7 = @MaterialTradePartnerCustom7, MaterialTradePartnerCustom8 = @MaterialTradePartnerCustom8, 
	MaterialTradePartnerCustom9 = @MaterialTradePartnerCustom9, MaterialTradePartnerCustom10 = @MaterialTradePartnerCustom10, 
	MaterialTradePartnerCustom11 = @MaterialTradePartnerCustom11, MaterialTradePartnerCustom12 = @MaterialTradePartnerCustom12, 
	MaterialTradePartnerCustom13 = @MaterialTradePartnerCustom13, MaterialTradePartnerCustom14 = @MaterialTradePartnerCustom14, 
	MaterialTradePartnerCustom15 = @MaterialTradePartnerCustom15, MaterialTradePartnerCustom16 = @MaterialTradePartnerCustom16, 
	MaterialTradePartnerCustom17 = @MaterialTradePartnerCustom17, MaterialTradePartnerCustom18 = @MaterialTradePartnerCustom18, 
	MaterialTradePartnerCustom19 = @MaterialTradePartnerCustom19, MaterialTradePartnerCustom20 = @MaterialTradePartnerCustom20, 	
	MaterialTradePartnerCustom21 = @MaterialTradePartnerCustom21, MaterialTradePartnerCustom22 = @MaterialTradePartnerCustom22, 
	MaterialTradePartnerCustom23 = @MaterialTradePartnerCustom23, MaterialTradePartnerCustom24 = @MaterialTradePartnerCustom24, 
	MaterialTradePartnerCustom25 = @MaterialTradePartnerCustom25	
	WHERE MaterialtradePartnerID = @MaterialTradePartnerIDNew

	UPDATE pMaterialtradePartnerColor SET 
	MaterialPrice = @MaterialPrice,
	MaterialTradeColor1 = @MaterialTradeColor1, MaterialTradeColor2 = @MaterialTradeColor2,
	MaterialTradeColor3 = @MaterialTradeColor3, MaterialTradeColor4 = @MaterialTradeColor4,
	MaterialTradeColor5 = @MaterialTradeColor5, MaterialTradeColor6 = @MaterialTradeColor6,
	MaterialTradeColor7 = @MaterialTradeColor7, MaterialTradeColor8 = @MaterialTradeColor8,
	MaterialTradeColor9 = @MaterialTradeColor9, MaterialTradeColor10 = @MaterialTradeColor10,
	MaterialTradeColor11 = @MaterialTradeColor11, MaterialTradeColor12 = @MaterialTradeColor12,
	MaterialTradeColor13 = @MaterialTradeColor13, MaterialTradeColor14 = @MaterialTradeColor14,
	MaterialTradeColor15 = @MaterialTradeColor15, MaterialTradeColor16 = @MaterialTradeColor16,
	MaterialTradeColor17 = @MaterialTradeColor17, MaterialTradeColor18 = @MaterialTradeColor18,
	MaterialTradeColor19 = @MaterialTradeColor19, MaterialTradeColor20 = @MaterialTradeColor20,	
	MaterialTradeColor21 = @MaterialTradeColor21, MaterialTradeColor22 = @MaterialTradeColor22,
	MaterialTradeColor23 = @MaterialTradeColor23, MaterialTradeColor24 = @MaterialTradeColor24,
	MaterialTradeColor25 = @MaterialTradeColor25
	WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew


END 

SELECT @MaterialTradePartnerIDNew AS MaterialTradePartnerColorID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09170', GetDate())
GO