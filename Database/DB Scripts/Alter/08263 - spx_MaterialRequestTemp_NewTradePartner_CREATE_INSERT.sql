IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestTemp_NewTradePartner_CREATE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestTemp_NewTradePartner_CREATE_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestTemp_NewTradePartner_CREATE_INSERT] (
@MaterialRequestGroupID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200), 
@CDate DATETIME, 
@IsShared INT = 0
)
AS

DECLARE @Row_V INT 
DECLARE @Total_V INT 

DECLARE @Row_C INT 
DECLARE @Total_C INT 

DECLARE @TradePartnerID  UNIQUEIDENTIFIER 
DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER
DECLARE @MaterialSizeID UNIQUEIDENTIFIER

DECLARE @MaterialRequestWorkflowTempID UNIQUEIDENTIFIER  
DECLARE @MaterialRequestWorkflowStartDate DATETIME
DECLARE @MaterialRequestWorkflowDueDate DATETIME

DECLARE @MaterialColorSeasonYearID UNIQUEIDENTIFIER  
DECLARE @MaterialColorID UNIQUEIDENTIFIER  
DECLARE @SeasonYearID UNIQUEIDENTIFIER  

SELECT @MaterialID =  MaterialID,
@MaterialRequestWorkflowTempID = MaterialRequestWorkflowTempID, 
@MaterialRequestWorkflowStartDate = MaterialRequestWorkflowStartDate,
@MaterialRequestWorkflowDueDate = MaterialRequestWorkflowDueDate,
@SeasonYearID = SeasonYearID
FROM pMaterialRequestTemp
WHERE MaterialRequestGroupID =  @MaterialRequestGroupID


CREATE TABLE  #vendor(
ROW_ID INT IDENTITY  (1,1),
TradePartnerID UNIQUEIDENTIFIER,
TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
)

CREATE TABLE #color (
ROW_ID INT IDENTITY  (1,1),
MaterialColorSeasonYearID UNIQUEIDENTIFIER ,
MaterialSizeID UNIQUEIDENTIFIER 
)


INSERT INTO #vendor (TradePartnerID, TradePartnerRelationshipLevelID) 
SELECT  TradePartnerVendorID, TradePartnerRelationshipLevelID FROM pMaterialRequestAgentVendorTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID 

INSERT INTO #color (MaterialColorSeasonYearID , MaterialSizeID ) 
SELECT MaterialColorSeasonYearID , MaterialSizeID  FROM pMaterialRequestSeasonColorTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID 

SELECT @Total_V = COUNT(*) FROM #vendor  
SET @Row_V = 1

SELECT @Total_C = COUNT(*) FROM #color

WHILE @Row_V <= @Total_V
BEGIN 


	SELECT  @TradePartnerID = TradePartnerID, @TradePartnerRelationshipLevelID = TradePartnerRelationshipLevelID
	FROM #vendor WHERE ROW_ID = @Row_V

	-- MaterialTradePartner record 
	SET @MaterialTradePartnerID  =  NULL
	
	SELECT @MaterialTradePartnerID = MaterialTradePartnerID 
	FROM pMaterialTradePartner 
	WHERE MaterialID = @MaterialID AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID --TradePartnerID = @TradePartnerID 
	AND SeasonYearID = @SeasonYearID


	IF  @MaterialTradePartnerID IS NULL 
	BEGIN

		SET @MaterialTradePartnerID = NEWID()

		 -- INSERT Material - Vendor 
		INSERT INTO pMaterialTradePartner  (MaterialTradePartnerID , MaterialID, TradePartnerID , TradePartnerRelationshipLevelId,
		CUser, CDate, MUser, Mdate,  MaterialRequestWorkflowTempID , MaterialRequestWorkflowStartDate, MaterialRequestWorkflowDueDate, SeasonYearID ) 
		SELECT @MaterialTradePartnerID, @MaterialID ,  @TradePartnerID, @TradePartnerRelationshipLevelId,
		@CUser, @CDate, @CUser, @CDate, @MaterialRequestWorkflowTempID , @MaterialRequestWorkflowStartDate, @MaterialRequestWorkflowDueDate, @SeasonYearID
		FROM uTradePartner
		WHERE TradePartnerID = @TradePartnerID

		--LOGIC: It will copy all the values from a prev. season 
		DECLARE @tmpMaterialTradePartnerId uniqueidentifier, 
			@tmpMaterialId uniqueidentifier, 
			@tmpTradepartnerId uniqueidentifier, 
			@tmpMaterialTradePartnerCustom1 nvarchar(200), 
			@tmpMaterialTradePartnerCustom2 nvarchar(200), 
			@tmpMaterialTradePartnerCustom3 nvarchar(200), 
			@tmpMaterialTradePartnerCustom4 nvarchar(200), 
			@tmpMaterialTradePartnerCustom5 nvarchar(200), 
			@tmpMaterialTradePartnerCustom6 nvarchar(200), 
			@tmpMaterialTradePartnerCustom7 nvarchar(200), 
			@tmpMaterialTradePartnerCustom8 nvarchar(200), 
			@tmpMaterialTradePartnerCustom9 nvarchar(200), 
			@tmpMaterialTradePartnerCustom10 nvarchar(200), 
			@tmpMaterialTradePartnerCustom11 nvarchar(200), 
			@tmpMaterialTradePartnerCustom12 nvarchar(200), 
			@tmpMaterialTradePartnerCustom13 nvarchar(200), 
			@tmpMaterialTradePartnerCustom14 nvarchar(200), 
			@tmpMaterialTradePartnerCustom15 nvarchar(200), 
			@tmpMaterialTradePartnerCustom16 nvarchar(200), 
			@tmpMaterialTradePartnerCustom17 nvarchar(200), 
			@tmpMaterialTradePartnerCustom18 nvarchar(200), 
			@tmpMaterialTradePartnerCustom19 nvarchar(200), 
			@tmpMaterialTradePartnerCustom20 nvarchar(200), 
			@tmpMaterialTradePartnerCustom21 nvarchar(200), 
			@tmpMaterialTradePartnerCustom22 nvarchar(200), 
			@tmpMaterialTradePartnerCustom23 nvarchar(200), 
			@tmpMaterialTradePartnerCustom24 nvarchar(200), 
			@tmpMaterialTradePartnerCustom25 nvarchar(200), 
			@tmpMaterialRequestWorkflowTempID uniqueidentifier 


		SELECT TOP 1 
			@tmpMaterialTradePartnerId = pMaterialTradePartner.MaterialTradePartnerId, 
			@tmpMaterialId = pMaterialTradePartner.MaterialId, 
			@tmpTradepartnerId = pMaterialTradePartner.TradepartnerId,
			@tmpMaterialTradePartnerCustom1 = pMaterialTradePartner.MaterialTradePartnerCustom1, 
			@tmpMaterialTradePartnerCustom2 = pMaterialTradePartner.MaterialTradePartnerCustom2, 
			@tmpMaterialTradePartnerCustom3 = pMaterialTradePartner.MaterialTradePartnerCustom3, 
			@tmpMaterialTradePartnerCustom4 = pMaterialTradePartner.MaterialTradePartnerCustom4, 
			@tmpMaterialTradePartnerCustom5 = pMaterialTradePartner.MaterialTradePartnerCustom5, 
			@tmpMaterialTradePartnerCustom6 = pMaterialTradePartner.MaterialTradePartnerCustom6, 
			@tmpMaterialTradePartnerCustom7 = pMaterialTradePartner.MaterialTradePartnerCustom7, 
			@tmpMaterialTradePartnerCustom8 = pMaterialTradePartner.MaterialTradePartnerCustom8, 
			@tmpMaterialTradePartnerCustom9 = pMaterialTradePartner.MaterialTradePartnerCustom9, 
			@tmpMaterialTradePartnerCustom10 = pMaterialTradePartner.MaterialTradePartnerCustom10, 
			@tmpMaterialTradePartnerCustom11 = pMaterialTradePartner.MaterialTradePartnerCustom11, 
			@tmpMaterialTradePartnerCustom12 = pMaterialTradePartner.MaterialTradePartnerCustom12, 
			@tmpMaterialTradePartnerCustom13 = pMaterialTradePartner.MaterialTradePartnerCustom13, 
			@tmpMaterialTradePartnerCustom14 = pMaterialTradePartner.MaterialTradePartnerCustom14, 
			@tmpMaterialTradePartnerCustom15 = pMaterialTradePartner.MaterialTradePartnerCustom15, 
			@tmpMaterialTradePartnerCustom16 = pMaterialTradePartner.MaterialTradePartnerCustom16, 
			@tmpMaterialTradePartnerCustom17 = pMaterialTradePartner.MaterialTradePartnerCustom17, 
			@tmpMaterialTradePartnerCustom18 = pMaterialTradePartner.MaterialTradePartnerCustom18, 
			@tmpMaterialTradePartnerCustom19 = pMaterialTradePartner.MaterialTradePartnerCustom19, 
			@tmpMaterialTradePartnerCustom20 = pMaterialTradePartner.MaterialTradePartnerCustom20, 
			@tmpMaterialTradePartnerCustom21 = pMaterialTradePartner.MaterialTradePartnerCustom21, 
			@tmpMaterialTradePartnerCustom22 = pMaterialTradePartner.MaterialTradePartnerCustom22, 
			@tmpMaterialTradePartnerCustom23 = pMaterialTradePartner.MaterialTradePartnerCustom23, 
			@tmpMaterialTradePartnerCustom24 = pMaterialTradePartner.MaterialTradePartnerCustom24, 
			@tmpMaterialTradePartnerCustom25 = pMaterialTradePartner.MaterialTradePartnerCustom25, 
			@tmpMaterialRequestWorkflowTempID = pMaterialTradePartner.MaterialRequestWorkflowTempID
		FROM pMaterialTradePartner INNER JOIN
			  pSeasonYear ON pMaterialTradePartner.SeasonYearID = pSeasonYear.SeasonYearID
		WHERE pMaterialTradePartner.TradePartnerID = @TradePartnerID AND pMaterialTradePartner.MaterialID = @MaterialID
				AND pMaterialTradePartner.TradePartnerRelationshipLevelId = @TradePartnerRelationshipLevelId
		ORDER BY pSeasonYear.Sort DESC

		UPDATE pMaterialTradePartner SET 			
			MaterialTradePartnerCustom1 = @tmpMaterialTradePartnerCustom1, 
			MaterialTradePartnerCustom2 = @tmpMaterialTradePartnerCustom2, 
			MaterialTradePartnerCustom3 = @tmpMaterialTradePartnerCustom3, 
			MaterialTradePartnerCustom4 = @tmpMaterialTradePartnerCustom4, 
			MaterialTradePartnerCustom5 = @tmpMaterialTradePartnerCustom5, 
			MaterialTradePartnerCustom6 = @tmpMaterialTradePartnerCustom6, 
			MaterialTradePartnerCustom7 = @tmpMaterialTradePartnerCustom7, 
			MaterialTradePartnerCustom8 = @tmpMaterialTradePartnerCustom8, 
			MaterialTradePartnerCustom9 = @tmpMaterialTradePartnerCustom9, 
			MaterialTradePartnerCustom10 = @tmpMaterialTradePartnerCustom10, 
			MaterialTradePartnerCustom11 = @tmpMaterialTradePartnerCustom11, 
			MaterialTradePartnerCustom12 = @tmpMaterialTradePartnerCustom12, 
			MaterialTradePartnerCustom13 = @tmpMaterialTradePartnerCustom13, 
			MaterialTradePartnerCustom14 = @tmpMaterialTradePartnerCustom14, 
			MaterialTradePartnerCustom15 = @tmpMaterialTradePartnerCustom15, 
			MaterialTradePartnerCustom16 = @tmpMaterialTradePartnerCustom16, 
			MaterialTradePartnerCustom17 = @tmpMaterialTradePartnerCustom17, 
			MaterialTradePartnerCustom18 = @tmpMaterialTradePartnerCustom18, 
			MaterialTradePartnerCustom19 = @tmpMaterialTradePartnerCustom19, 
			MaterialTradePartnerCustom20 = @tmpMaterialTradePartnerCustom20, 
			MaterialTradePartnerCustom21 = @tmpMaterialTradePartnerCustom21, 
			MaterialTradePartnerCustom22 = @tmpMaterialTradePartnerCustom22, 
			MaterialTradePartnerCustom23 = @tmpMaterialTradePartnerCustom23, 
			MaterialTradePartnerCustom24 = @tmpMaterialTradePartnerCustom24, 
			MaterialTradePartnerCustom25 = @tmpMaterialTradePartnerCustom25, 
			MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID --@tmpMaterialRequestWorkflowTempID
		WHERE MaterialTradePartnerId = @MaterialTradePartnerId
		
		IF @IsShared = 1
		BEGIN
			DECLARE @TradePartnerIDHighLevel UNIQUEIDENTIFIER = (SELECT COALESCE(AgentID, VendorID, FactoryID) FROM vwx_TradePartnerRelationshipLevels_SEL WHERE TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID)
			EXEC spx_MaterialTradePartner_ShareStatus_UPDATE
				@MaterialTradePartnerID = @MaterialTradePartnerID,
				@TradePartnerID = @TradePartnerIDHighLevel,
				@IsADD = 1,
				@MUser = @CUser,
				@MDate = @CDate
		END
		
	END

	

	--********************************************************
	-- insert colors
	SET @Row_C = 1 	

	WHILE @Row_C <= @Total_C
	BEGIN
		SELECT @MaterialColorSeasonYearID = a.MaterialColorSeasonYearID, @MaterialSizeID = a.MaterialSizeID,
		@MaterialColorID  = b.MaterialColorID 
		FROM  #color a
		INNER JOIN pMaterialColorSeasonYear b ON a.MaterialColorSeasonYearID = b.MaterialColorSeasonYearID
		WHERE ROW_ID = @Row_C 


		IF (  SELECT COUNT(*) FROM pMaterialTradePartnerColor
			WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialSizeID = @MaterialSizeID
			AND MaterialColorID  = @MaterialColorID  ) = 0 
		BEGIN 
			
			DECLARE @MaterialTradePartnerColorID UNIQUEIDENTIFIER 
			SET @MaterialTradePartnerColorID = NEWID() 

			--SELECT * FROM dbo.pMaterialTradePartnerColor
			INSERT INTO pMaterialTradePartnerColor ( MaterialTradePartnerColorID , MaterialTradePartnerID , MaterialColorID , 
			MaterialID , ColorFolderID , ColorPaletteID , ColorName, ColorSource, VendorColorName, 
			Hex, R, G, B, H, S, L,
			CDate, CUser, MDate, MUser,  MaterialColorVersion ,  ColorVersion, MaterialSizeID, MaterialRequestShare ) 
			SELECT  @MaterialTradePartnerColorID AS MaterialTradePartnerColorID,	@MaterialTradePartnerID , a.MaterialColorID ,	 
			a.MaterialID , b.ColorFolderID , b.ColorPaletteID ,  b.ColorName, b.ColorSource, b.VendorColorName,  
			b.Hex, b.R, b.G, b.B, b.H, b.S, b.L, 
			@CDate, @CUser, @CDate, @CUser, 1, 0 , @MaterialSizeID, 1
			FROM pMaterialColorSeasonYear a
			INNER JOIN  pMaterialColor b ON a.MaterialColorID  = b.MaterialColorID
			WHERE MaterialColorSeasonYearID  = @MaterialColorSeasonYearID 
			
			EXEC dbo.spx_MaterialRequestSubmitWorkflowLogic_UPDATE 
					@MaterialTradePartnerID = @MaterialTradePartnerID,
					@MaterialTradePartnerColorID = @MaterialTradePartnerColorID,
					@MaterialRequestGroupID = @MaterialRequestGroupID,
					@IsShared = @IsShared
					
		END 

		SET @Row_C  = @Row_C  + 1 
	END 
	--********************************************************

	SET @Row_V = @Row_V + 1 
END 


DROP TABLE  #vendor
DROP TABLE #color 

DELETE FROM pMaterialRequestTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID 
DELETE FROM pMaterialRequestSeasonColorTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID 
DELETE FROM pMaterialRequestAgentVendorTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08263', GetDate())
GO
