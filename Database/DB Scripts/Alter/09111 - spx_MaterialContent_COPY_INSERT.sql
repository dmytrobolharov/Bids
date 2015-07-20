IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContent_COPY_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialContent_COPY_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialContent_COPY_INSERT]
	@MasterMaterialID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO dbo.pMaterialContent( MaterialContentId, MaterialID ,  MaterialContentCode, MaterialContentPerc, MaterialContentName, MUser, MDate  ) 
	SELECT NEWID(), @MaterialID, MaterialContentCode, MaterialContentPerc, MaterialContentName, MUser, MDate
	FROM pMaterialContent
	WHERE MaterialId = @MasterMaterialID
	
	-- no more multiple season years, use an intro one
	SELECT IDENTITY(INT, 1, 1) as ROW, IntroSeasonYearID AS SeasonYearID
	INTO #tmpMaterialSeasonYear FROM pMaterial
	WHERE MaterialID = @MaterialID
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM #tmpMaterialSeasonYear);
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @SeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM #tmpMaterialSeasonYear WHERE ROW = @ROW),
				@MaterialSeasonYearID UNIQUEIDENTIFIER = NEWID();
				
		exec spx_MaterialSeasonYear_INSERT 
			@MaterialSeasonYearID = @MaterialSeasonYearID,
			@MaterialID = @MaterialID,
			@SeasonYearID = @SeasonYearID,
			@CUser = @CUser, 
			@CDate = @CDate
			
		exec spx_MaterialSeasonYear_Logic_INSERT 
			@MaterialSeasonYearID = @MaterialSeasonYearID,
			@CUser = @CUser, 
			@CDate = @CDate
			
		SET @ROW = @ROW + 1
	END
	DROP TABLE #tmpMaterialSeasonYear
	
	-- add colors
	INSERT INTO pMaterialColor (MaterialColorID, MaterialID,  ColorFolderID, ColorPaletteID, ColorCode, ColorName, ColorSource, 
		Hex, R, G, B, C, M,Y,K, H, S, L, LAB_L, LAB_A, LAB_B, CDate, CUser, MDate, MUser, MaterialColorVersion, ColorVersion)  
	SELECT  NEWID(), @MaterialID, cp.ColorFolderID, cp.ColorPaletteID, cp.ColorCode, cp.ColorName, cp.ColorSource, 
		Hex, R, G, B, C, M, Y, K, H, S, L ,LAB_L, LAB_A, LAB_B, @CDate, @CUser, @CDate, @CUser, 1, 0
	FROM tmpMaterialColor tmc
	INNER JOIN pColorPalette cp ON tmc.ColorPaletteID = cp.ColorPaletteID
	WHERE tmc.MaterialID = @MasterMaterialID
	
	-- add colors to season years
	DECLARE @MaterialSeasonYear TABLE(
		ROW INT IDENTITY(1, 1), 
		SeasonYearID UNIQUEIDENTIFIER)
		
	INSERT INTO @MaterialSeasonYear(SeasonYearID)
	SELECT SeasonYearID FROM pMaterialSeasonYear WHERE MaterialID = @MaterialID		
	
	DECLARE @MaterialColors TABLE(
		ROW INT IDENTITY(1, 1),
		MaterialColorID UNIQUEIDENTIFIER,
		SeasonYearID UNIQUEIDENTIFIER);			
		
	INSERT INTO @MaterialColors(MaterialColorID, SeasonYearID)
	SELECT mc.MaterialColorID, msy.SeasonYearID FROM pMaterialColor mc
	CROSS JOIN pMaterialSeasonYear msy
	WHERE mc.MaterialID = @MaterialID AND msy.MaterialID = @MaterialID
	
	/***********************
	** add size/treatment **
	************************/
	INSERT INTO pMaterialSize(MaterialID, MaterialSize, MaterialPrice, Sort, CUser, CDate, MUser, MDate)
	SELECT @MaterialID, MaterialSize, MaterialPrice, Sort, CUser, CDate, MUser, MDate
	FROM pMaterialSize WHERE MaterialID = @MasterMaterialID

		
	DECLARE @MCROW INT = 1,
			@MCTOTAL INT = (SELECT COUNT(*) FROM @MaterialColors)
			
	WHILE @MCROW <= @MCTOTAL
	BEGIN
		DECLARE @MaterialColorID UNIQUEIDENTIFIER,
				@MCSeasonYearID UNIQUEIDENTIFIER
				
		SELECT @MaterialColorID = MaterialColorID, @MCSeasonYearID = SeasonYearID 
		FROM @MaterialColors WHERE ROW = @MCROW
	
		exec spx_MaterialColorSeasonYear_INSERT
			@MaterialID = @MaterialID,
			@MaterialColorID = @MaterialColorID,
			@SeasonYearID = @MCSeasonYearID,
			@TeamID = @TeamID,
			@CUser = @CUser,
			@CDate = @CDate
			
		SET @MCROW = @MCROW + 1
	END
	
	/**************************
	** add material requests **
	***************************/
	DECLARE @MaterialTradePartner TABLE(
		ROW INT IDENTITY(1, 1),
		TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
		MaterialRequestWorkflowTempID UNIQUEIDENTIFIER)
		
	INSERT INTO @MaterialTradePartner(TradePartnerRelationshipLevelID, MaterialRequestWorkflowTempID)
	SELECT TradePartnerRelationshipLevelID, MaterialRequestWorkflowTempID
	FROM tmpMaterialTradePartner WHERE MaterialID = @MasterMaterialID
	
	IF (SELECT COUNT(*) FROM @MaterialTradePartner) > 0
	BEGIN		
		-- create material requests for all colors in all season years for selected partners
		DECLARE @SYROW INT = 1,
				@SYTOTAL INT = (SELECT COUNT(*) FROM @MaterialSeasonYear)
		-- cycle through material season years
		WHILE @SYROW <= @SYTOTAL
		BEGIN
			DECLARE @MRSeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM @MaterialSeasonYear WHERE ROW = @SYROW),
					@TPROW INT = 1,
					@TPTOTAL INT = (SELECT COUNT(*) FROM @MaterialTradePartner)
			-- cycle through trade partners
			WHILE @TPROW <= @TPTOTAL
			BEGIN
				DECLARE @MaterialRequestGroupID UNIQUEIDENTIFIER = NEWID(),
						@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
						@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER,
						@TradePartnerID UNIQUEIDENTIFIER
						
				SELECT 
					@TradePartnerRelationshipLevelID = mtp.TradePartnerRelationshipLevelID,
					@MaterialRequestWorkflowTempID = MaterialRequestWorkflowTempID,
					@TradePartnerID = COALESCE(tprl.AgentID, tprl.VendorID, tprl.FactoryID) 
				FROM @MaterialTradePartner mtp 
				INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
				WHERE mtp.ROW = @TPROW
				
				exec spx_NPMMaterialRequestTemp_TradePartnerVendor_INSERT
					@MaterialRequestGroupID = @MaterialRequestGroupID,
					@TradePartnerID = @TradePartnerID,
					@TradePartnerIDChain = NULL,
					@TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID,
					@CUser = @CUser,
					@CDate = @CDate
					
				UPDATE pMaterialTradePartner
				SET MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
				WHERE MaterialID = @MaterialID
					AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID --
					AND SeasonYearID = @SeasonYearID
					
				exec spx_MaterialRequestTempSchedule_UPDATE
					@MaterialRequestGroupID = @MaterialRequestGroupID,
					@MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID,
					@MaterialID = @MaterialID,
					@CUser = @CUser,
					@CDate = @CDate 
					
				exec spx_MaterialRequestTempWorkflowSchedule_UPDATE
					@MaterialRequestGroupID = @MaterialRequestGroupID,
					@MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID,
					@MaterialID = @MaterialID,
					@ScheduleBy = 'S',
					@CUser = @CUser,
					@CDate = @CDate
				
				DECLARE @MRColorSeasonYear TABLE(
					ROW INT IDENTITY(1, 1),
					MaterialColorSeasonYearID UNIQUEIDENTIFIER,
					MaterialSizeID UNIQUEIDENTIFIER)
				INSERT INTO @MRColorSeasonYear(MaterialColorSeasonYearID, MaterialSizeID)
				SELECT MaterialColorSeasonYearID, MaterialSizeID FROM vwx_MaterialWizardRequest_ColorSeasonYear_Available_SEL 
				WHERE MaterialID = @MaterialID AND SeasonYearID = @MRSeasonYearID
				
				SET @MCROW = 1
				SET @MCTOTAL = (SELECT COUNT(*) FROM @MRColorSeasonYear)
				-- cycle through all season year colors
				WHILE @MCROW <= @MCTOTAL
				BEGIN
					DECLARE @MaterialColorSeasonYearID UNIQUEIDENTIFIER,
							@MaterialSizeID UNIQUEIDENTIFIER;
							
					SELECT @MaterialColorSeasonYearID = MaterialColorSeasonYearID, @MaterialSizeID = MaterialSizeID
					FROM @MRColorSeasonYear WHERE ROW = @MCROW
				
					exec spx_MaterialRequestTemp_ColorSelect_INSERT
						@MaterialRequestGroupID = @MaterialRequestGroupID,
						@MaterialColorSeasonYearID = @MaterialColorSeasonYearID,
						@MaterialID  = @MaterialID,
						@SeasonYearID = @MCSeasonYearID,
						@CUser = @CUser,
						@CDate = @CDate, 
						@MaterialSizeID = @MaterialSizeID
				
					SET @MCROW = @MCROW + 1
				END
				
				DECLARE @MaterialRequestWorkflowStartDate DATETIME,
						@MaterialRequestWorkflowEndDate DATETIME
				SELECT @MaterialRequestWorkflowTempID = MaterialRequestWorkflowTempID,
					@MaterialRequestWorkflowStartDate = StartDate,
					@MaterialRequestWorkflowEndDate = EndDate
				FROM tmpMaterialTradePartner WHERE MaterialID = @MasterMaterialID AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
						
				UPDATE pMaterialRequestTemp SET 
					MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID,
					MaterialRequestWorkflowStartDate = @MaterialRequestWorkflowStartDate,
					SeasonYearID = @MRSeasonYearID
				WHERE MaterialRequestGroupID = @MaterialRequestGroupID		
				
				-- finally generate material requests
				exec spx_MaterialRequestTemp_NewTradePartner_CREATE_INSERT
					@MaterialRequestGroupID = @MaterialRequestGroupID,
					@CUser = @CUser,
					@CDate = @CDate				
				
				SET @TPROW = @TPROW + 1
			END			
				
			SET @SYROW = @SYROW + 1
		END
	END
	
END







GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09111', GetDate())
GO
