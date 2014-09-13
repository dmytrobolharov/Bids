/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestTradeAllocation_INSERT]    Script Date: 01/09/2013 18:13:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestTradeAllocation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestTradeAllocation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestTradeAllocation_INSERT]    Script Date: 01/09/2013 18:13:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_NPMSampleRequestTradeAllocation_INSERT]
(
	@SampleRequestGroupID nvarchar(50),	
	@TradePartnerID nvarchar(50),
	@StyleID nvarchar(50),
	@SampleRequestShare nvarchar(2) , 
	@StyleColorID nvarchar(50),
	@CreatedBy nvarchar(200),
	@CreatedDate datetime , 
	@StyleSourcingID UNIQUEIDENTIFIER  =  NULL 
)

AS


DECLARE @I as int, @ISet int,  @Row_Count int
DECLARE @ISet_Curr int, @ISet_Max  int,
		@SampleRequestWorkflowID nvarchar(50),
		@NewSampleRequestWorkflowID nvarchar(50),
		@StyleRequestWorkflowSetItemID uniqueidentifier,
		@SampleRequestTradeID uniqueidentifier,
		@TechPackID nvarchar(50)

DECLARE  @StyleSeasonYearID UNIQUEIDENTIFIER 

SET @I = 1
SET @ISet = 1
SET @ISet_Curr = 1 
SET NOCOUNT ON


BEGIN TRANSACTION
	BEGIN

		SET @SampleRequestTradeID = newid()
		-- PRINT '@SampleRequestTradeID= '  +  CAST ( @SampleRequestTradeID  as NVARCHAR (50) ) 
	

		SELECT @SampleRequestTradeID AS SampleRequestTradeID
		
		BEGIN	
		
			SELECT @TechPackID = TechPackID FROM pstyleHeader WHERE StyleId = @StyleId
			IF @TechPackID IS NULL 
			BEGIN
				SET @Techpackid = '00000000-0000-0000-0000-000000000000'
			END

			SELECT TOP 1 @StyleSeasonYearID = b.StyleSeasonYearID 
			FROM pSampleRequestGroupTemp a 
			LEFT OUTER JOIN pStyleSeasonYear b ON a.StyleID = b.StyleID AND a.SeasonYearID = b.SeasonYearID
			WHERE --@SampleRequestGroupID = SampleRequestGroupID
			a.StyleID = @StyleID		
			
			

			INSERT INTO pSampleRequestTrade
			(
				SampleRequestTradeID, 
				TradePartnerVendorID, 
				TradePartnerID, 
				StyleID, 
				StyleColorID, 
				TechPackID, 
				CUser, 
				CDate, 
				MUser, 
				MDate, 
				MessageSent, 
				SampleRequestShare, 
				StyleSourcingID , 
				StyleSeasonYearID   
			)
			VALUES 
			(
				@SampleRequestTradeID, 
				NULL, 
				@TradePartnerID, 
				@StyleID, 
				@StyleColorID, 
				@TechPackID, 
				@CreatedBy, 
				@CreatedDate, 
				@CreatedBy, 
				@CreatedDate, 
				0, 
				@SampleRequestShare  , 
				@StyleSourcingID , 
				@StyleSeasonYearID 
			)
				
			INSERT INTO pSampleRequestActivity(
				SampleRequestTradeId, TradePartnerId, TradePartnerVendorId, StyleId, StyleColorId, 
				TechPackId, CUser, CDate, SampleActivity, ActivityType)
			VALUES  (@SampleRequestTradeId, @TradePartnerId, NULL, @StyleId, @StyleColorId, 
				@TechPackId, @CreatedBy, @CreatedDate, N'New Sample Request', 'N')
		

			SELECT * FROM pSampleRequestTrade WHERE SampleRequestTradeID = @SampleRequestTradeID
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END
				
		END
		

		BEGIN	

			--SET @ISet_Count = (SELECT COUNT(*) FROM pSampleRequestSetItemTemp WHERE (SampleRequestGroupID = @SampleRequestGroupID))
	
			SELECT @ISet_Max  = Max(StyleSet)  FROM pSampleRequestSetItemTemp WHERE (SampleRequestGroupID = @SampleRequestGroupID)

			if  @ISet_Max IS NULL 
				SET @ISet_Max = 0 
			else
				SELECT @ISet = Min(StyleSet) FROM pSampleRequestSetItemTemp WHERE (SampleRequestGroupID = @SampleRequestGroupID)



			--WHILE @ISet <= @ISet_Count 
			WHILE @ISet <= @ISet_Max
				BEGIN

					-- PRINT  'SET = ' +  CAST  ( @ISet  AS VARCHAR (10) )
					SET  @ISet_Curr = @ISet 		
					SET @StyleRequestWorkflowSetItemID = newid()	
				
					BEGIN
				
						SELECT IDENTITY(int, 1, 1) AS ID_Num, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, 
							SampleRequestGroupID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, 
							@StyleColorID AS StyleColorID , StyleSet, Status, Submit, SubmitDays, ResubmitDays, 
							AssignedTo, TechPackID, StartDate, DueDate, EndDate, CUser, CDate, MUser, MDate 
						INTO ##SampleRequestWorkflowTemp FROM pSampleRequestWorkflowTemp
						WHERE (SampleRequestGroupID = @SampleRequestGroupID) AND (StyleSet = @ISet)

						SET @Row_Count = (SELECT COUNT(*) FROM ##SampleRequestWorkflowTemp WHERE SampleRequestGroupID = @SampleRequestGroupID)
						
						SET @I = 1

						WHILE @I <= @Row_Count 
						BEGIN
							
							SET @NewSampleRequestWorkflowID = newid()
							
							SELECT @SampleRequestWorkflowID = SampleRequestWorkflowID FROM ##SampleRequestWorkflowTemp WHERE ID_Num = @I
								BEGIN
			
									INSERT INTO pSampleRequestWorkflow(
										TradePartnerVendorID, TradePartnerID, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID,
										SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, 
										StyleID, StyleColorID, StyleSet,
										Status, Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, 
										StartDate, DueDate, FinalDate, EndDate, CUser, CDate, MUser, MDate , SampleWorkflowFinalDate)
									SELECT NULL, @TradePartnerID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, @StyleRequestWorkflowSetItemID, 
										@SampleRequestTradeID AS SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, 
										StyleID, @StyleColorID AS StyleColorID, StyleSet, 
										0 AS Status, 1 AS Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, 
										StartDate, DueDate, FinalDate, '1/1/1900', CUser, CDate, MUser, MDate , SampleWorkflowFinalDate 
									FROM dbo.pSampleRequestWorkflowTemp
									WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleSet = @ISet)

									/*==================================================
									=  New FinalDate 
									==================================================*/
									
/*
									SELECT  @SampleWorkflowFinalDate = SampleWorkflowFinalDate FROM  pSampleRequestWorkflowTemp 
									WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND StyleSet = @ISet
						
									UPDATE 	pSampleRequestWorkflow SET 
									SampleWorkflowFinalDate	= DATEADD ( 'day' , @SampleWorkflowFinalDate , SampleWorkflowFinalDate)
									WHERE SampleRequestWorkflowID = @NewSampleRequestWorkflowID
	
									*/
								
									IF @@ERROR <> 0
									BEGIN
										print 'Error 1 ' 
										ROLLBACK TRANSACTION
										RETURN
									END	
								END
								
								BEGIN
			
									INSERT INTO dbo.pSampleRequestSubmit(
										TradePartnerVendorID, TradePartnerID, SampleRequestTradeID, 
										SampleRequestWorkflowID, SampleWorkflowID, StyleID, 
										StyleColorID, StyleSet, WorkflowID, Submit, 
										Status, AssignedTo, StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, 
										VendorWeight, VendorDate, VendorName, SubmitDays, ResubmitDays, DueDate, EndDate, EndBy, 
										CUser, CDate, MUser, MDate, Comment, InternalComment)
									SELECT NULL, @TradePartnerID, @SampleRequestTradeID AS SampleRequestTradeID, 
										@NewSampleRequestWorkflowID AS SampleRequestWorkflowID, SampleWorkflowID, StyleID, 
										@StyleColorID AS StyleColorID, StyleSet, WorkflowID, 1 AS Submit, 
										0 AS Status, AssignedTo, StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, 
										VendorWeight, VendorDate, VendorName, SubmitDays, ResubmitDays,  
										DueDate, EndDate, EndBy, CUser, CDate, MUser, MDate, Comment, InternalComment 									 
									FROM  dbo.pSampleRequestSubmitTemp
									WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleSet = @ISet)
									
									IF @@ERROR <> 0
									BEGIN
									ROLLBACK TRANSACTION
									RETURN
									END	
								END
								--PRINT @I
						
							SET @I = @I + 1

						END

						DROP TABLE ##SampleRequestWorkflowTemp	

						IF @@ERROR <> 0
						BEGIN
						ROLLBACK TRANSACTION
						RETURN
						END
				
					END					
					
					

					SET @ISet = NULL

					SET @ISet = (SELECT TOP 1 StyleSet FROM pSampleRequestSetItemTemp  
								 WHERE SampleRequestGroupID = @SampleRequestGroupID AND StyleSet > @ISet_Curr ORDER BY StyleSet)
	
					IF  @ISet IS NULL 
						SET  @ISet = @ISet_Max + 1

					--  SET @ISet = @ISet + 1

				END
					
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
			
		END

		print ' No ERROR 1 ' 


		BEGIN
			
			INSERT INTO dbo.pSampleRequestSpecSize(
				SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, StyleID, StyleColorID, StyleSet, SizeRange, 
				Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, 
				Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
				Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19, Sel0, Sel1, 
				Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
				Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, 
				Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, MUser, MDate)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, 
				dbo.pSampleRequestSpecSizeTemp.SampleWorkflowID, dbo.pSampleRequestSpecSizeTemp.WorkflowID, 
				dbo.pSampleRequestSpecSizeTemp.StyleID, @StyleColorID AS StyleColorID, dbo.pSampleRequestSpecSizeTemp.StyleSet, 
				dbo.pSampleRequestSpecSizeTemp.SizeRange, dbo.pSampleRequestSpecSizeTemp.Size0, dbo.pSampleRequestSpecSizeTemp.Size1, 
				dbo.pSampleRequestSpecSizeTemp.Size2, dbo.pSampleRequestSpecSizeTemp.Size3, dbo.pSampleRequestSpecSizeTemp.Size4, 
				dbo.pSampleRequestSpecSizeTemp.Size5, dbo.pSampleRequestSpecSizeTemp.Size6, dbo.pSampleRequestSpecSizeTemp.Size7, 
				dbo.pSampleRequestSpecSizeTemp.Size8, dbo.pSampleRequestSpecSizeTemp.Size9, dbo.pSampleRequestSpecSizeTemp.Size10, 
				dbo.pSampleRequestSpecSizeTemp.Size11, dbo.pSampleRequestSpecSizeTemp.Size12, dbo.pSampleRequestSpecSizeTemp.Size13, 
				dbo.pSampleRequestSpecSizeTemp.Size14, dbo.pSampleRequestSpecSizeTemp.Size15, dbo.pSampleRequestSpecSizeTemp.Size16, 
				dbo.pSampleRequestSpecSizeTemp.Size17, dbo.pSampleRequestSpecSizeTemp.Size18, dbo.pSampleRequestSpecSizeTemp.Size19, 
				dbo.pSampleRequestSpecSizeTemp.Sel12, dbo.pSampleRequestSpecSizeTemp.Sel13, dbo.pSampleRequestSpecSizeTemp.Sel14, 
				dbo.pSampleRequestSpecSizeTemp.Sel15, dbo.pSampleRequestSpecSizeTemp.Sel16, dbo.pSampleRequestSpecSizeTemp.Sel17, 
				dbo.pSampleRequestSpecSizeTemp.Sel18, dbo.pSampleRequestSpecSizeTemp.Sel19, dbo.pSampleRequestSpecSizeTemp.Sel0, 
				dbo.pSampleRequestSpecSizeTemp.Sel1, dbo.pSampleRequestSpecSizeTemp.Sel2, dbo.pSampleRequestSpecSizeTemp.Sel3, 
				dbo.pSampleRequestSpecSizeTemp.Sel4, dbo.pSampleRequestSpecSizeTemp.Sel5, dbo.pSampleRequestSpecSizeTemp.Sel6, 
				dbo.pSampleRequestSpecSizeTemp.Sel7, dbo.pSampleRequestSpecSizeTemp.Sel8, dbo.pSampleRequestSpecSizeTemp.Sel9, 
				dbo.pSampleRequestSpecSizeTemp.Sel10, dbo.pSampleRequestSpecSizeTemp.Sel11, dbo.pSampleRequestSpecSizeTemp.Col0, 
				dbo.pSampleRequestSpecSizeTemp.Col1, dbo.pSampleRequestSpecSizeTemp.Col2, dbo.pSampleRequestSpecSizeTemp.Col3, 
				dbo.pSampleRequestSpecSizeTemp.Col4, dbo.pSampleRequestSpecSizeTemp.Col5, dbo.pSampleRequestSpecSizeTemp.Col6, 
				dbo.pSampleRequestSpecSizeTemp.Col7, dbo.pSampleRequestSpecSizeTemp.Col8, dbo.pSampleRequestSpecSizeTemp.Col9, 
				dbo.pSampleRequestSpecSizeTemp.Col10, dbo.pSampleRequestSpecSizeTemp.Col11, dbo.pSampleRequestSpecSizeTemp.Col12, 
				dbo.pSampleRequestSpecSizeTemp.Col13, dbo.pSampleRequestSpecSizeTemp.Col14, dbo.pSampleRequestSpecSizeTemp.Col15, 
				dbo.pSampleRequestSpecSizeTemp.Col16, dbo.pSampleRequestSpecSizeTemp.Col17, dbo.pSampleRequestSpecSizeTemp.Col18, 
				dbo.pSampleRequestSpecSizeTemp.Col19, dbo.pSampleRequestSpecSizeTemp.MUser, dbo.pSampleRequestSpecSizeTemp.MDate
			FROM dbo.pSampleRequestWorkflow 
				INNER JOIN dbo.pSampleRequestSpecSizeTemp 
					ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleRequestSpecSizeTemp.SampleWorkflowID 
					AND dbo.pSampleRequestWorkflow.StyleID = dbo.pSampleRequestSpecSizeTemp.StyleID 
					AND dbo.pSampleRequestWorkflow.StyleColorID = dbo.pSampleRequestSpecSizeTemp.StyleColorID 
					AND dbo.pSampleRequestWorkflow.StyleSet = dbo.pSampleRequestSpecSizeTemp.StyleSet
			WHERE (dbo.pSampleRequestSpecSizeTemp.SampleRequestGroupID = @SampleRequestGroupID)
			
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END
		
		BEGIN
		
			--DELETE dbo.pSampleRequestStyle
			--WHERE SampleRequestGroupID = @SampleRequestGroupID
		
			INSERT INTO dbo.pSampleRequestStyle(
				SampleRequestTradeID, TradePartnerVendorID, StyleColorID, StyleColorName, StyleID, StyleSet, Submit, StyleType, WorkflowType, RefNo, 
				StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, RecDate, Customer, Buyer, Designer, 
				SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, MaterialID, MaterialImageID, 
				MaterialImageVersion, MaterialNo, MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, TargetPrice, SellingPrice, 
				CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, 
				CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, 
				Size10, Size11, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, 
				Change, Action, NoColorCombo,
				CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
				CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 , StyleSourcingID)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, NULL AS TradePartnerVendorID, @StyleColorID, StyleColorName, StyleID, StyleSet, 
				Submit, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, 
				RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, 
				MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, 
				TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, 
				CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, Size0, Size1, Size2, Size3, Size4, 
				Size5, Size6, Size7, Size8, Size9, Size10, Size11, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Pc1, Pc2, Pc3, Pc4, CUser, 
				CDate, MUser, MDate, Active, Change, Action, NoColorCombo,
				CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
				CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 , @StyleSourcingID
			FROM   dbo.pSampleRequestStyleTemp
			WHERE (SampleRequestGroupID = @SampleRequestGroupID)
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END			

		BEGIN
			
			INSERT INTO dbo.pSampleRequestMaterial(
				SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, RecDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, 
				StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, 
				MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
				ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,  Source, Notes, Placement, VendorPrice, 
				VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
				MUser, MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialComment)
			SELECT  @SampleRequestTradeID AS SampleRequestTradeID, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, 
				dbo.pSampleRequestMaterialTemp.Submit, dbo.pSampleRequestMaterialTemp.StartDate, dbo.pSampleRequestMaterialTemp.RecDate, 
				dbo.pSampleRequestMaterialTemp.DueDate, dbo.pSampleRequestMaterialTemp.EndDate, dbo.pSampleRequestMaterialTemp.Status, 
				dbo.pSampleRequestMaterialTemp.SampleWorkflowID, dbo.pSampleRequestMaterialTemp.StyleID, dbo.pSampleRequestMaterialTemp.StyleColorID, 
				dbo.pSampleRequestMaterialTemp.StyleSet, dbo.pSampleRequestMaterialTemp.WorkflowID, dbo.pSampleRequestMaterialTemp.TradePartnerVendorID, 
				dbo.pSampleRequestMaterialTemp.StyleMaterialID, dbo.pSampleRequestMaterialTemp.MainMaterial, 
				dbo.pSampleRequestMaterialTemp.Development, dbo.pSampleRequestMaterialTemp.MiscColor, dbo.pSampleRequestMaterialTemp.UOM, 
				dbo.pSampleRequestMaterialTemp.Qty, dbo.pSampleRequestMaterialTemp.MaterialPrice, dbo.pSampleRequestMaterialTemp.Ext, 
				dbo.pSampleRequestMaterialTemp.MaterialSize, dbo.pSampleRequestMaterialTemp.MaterialID, 
				dbo.pSampleRequestMaterialTemp.MaterialPlacement, dbo.pSampleRequestMaterialTemp.MaterialPlacementCode, 
				dbo.pSampleRequestMaterialTemp.MaterialPlacementDetail, dbo.pSampleRequestMaterialTemp.MaterialImageID, 
				dbo.pSampleRequestMaterialTemp.MaterialImageVersion, dbo.pSampleRequestMaterialTemp.NoColorMatch, 
				dbo.pSampleRequestMaterialTemp.SupplierID, dbo.pSampleRequestMaterialTemp.ComponentTypeID, 
				dbo.pSampleRequestMaterialTemp.MaterialType, dbo.pSampleRequestMaterialTemp.MaterialNo, dbo.pSampleRequestMaterialTemp.MaterialName, 
				dbo.pSampleRequestMaterialTemp.A, dbo.pSampleRequestMaterialTemp.B, dbo.pSampleRequestMaterialTemp.C, 
				dbo.pSampleRequestMaterialTemp.D, dbo.pSampleRequestMaterialTemp.E, dbo.pSampleRequestMaterialTemp.F, 
				dbo.pSampleRequestMaterialTemp.G, dbo.pSampleRequestMaterialTemp.H, dbo.pSampleRequestMaterialTemp.I, 
				dbo.pSampleRequestMaterialTemp.J, dbo.pSampleRequestMaterialTemp.K, dbo.pSampleRequestMaterialTemp.L, 
				dbo.pSampleRequestMaterialTemp.M, dbo.pSampleRequestMaterialTemp.N, dbo.pSampleRequestMaterialTemp.O, 
				dbo.pSampleRequestMaterialTemp.P, dbo.pSampleRequestMaterialTemp.Q, dbo.pSampleRequestMaterialTemp.R, 
				dbo.pSampleRequestMaterialTemp.S,  dbo.pSampleRequestMaterialTemp.T, dbo.pSampleRequestMaterialTemp.U, 
				dbo.pSampleRequestMaterialTemp.V, dbo.pSampleRequestMaterialTemp.W, dbo.pSampleRequestMaterialTemp.X, 
				dbo.pSampleRequestMaterialTemp.Y, dbo.pSampleRequestMaterialTemp.Z ,
				dbo.pSampleRequestMaterialTemp.Source, dbo.pSampleRequestMaterialTemp.Notes, 
				dbo.pSampleRequestMaterialTemp.Placement, dbo.pSampleRequestMaterialTemp.VendorPrice, dbo.pSampleRequestMaterialTemp.VolumePrice, 
				dbo.pSampleRequestMaterialTemp.VolumePriceMinimum, dbo.pSampleRequestMaterialTemp.VendorProductionMin, 
				dbo.pSampleRequestMaterialTemp.VendorProductionLeadTime, dbo.pSampleRequestMaterialTemp.DetailYesNo, 
				dbo.pSampleRequestMaterialTemp.ImageType, dbo.pSampleRequestMaterialTemp.height, dbo.pSampleRequestMaterialTemp.width, 
				dbo.pSampleRequestMaterialTemp.CDate, dbo.pSampleRequestMaterialTemp.CUser, dbo.pSampleRequestMaterialTemp.MDate, 
				dbo.pSampleRequestMaterialTemp.MUser, dbo.pSampleRequestMaterialTemp.MChange, dbo.pSampleRequestMaterialTemp.SChange, 
				dbo.pSampleRequestMaterialTemp.DChange, dbo.pSampleRequestMaterialTemp.CChange, dbo.pSampleRequestMaterialTemp.Action, 
				dbo.pSampleRequestMaterialTemp.ColorPlacement, dbo.pSampleRequestMaterialTemp.Artwork, dbo.pSampleRequestMaterialTemp.License, 
				dbo.pSampleRequestMaterialTemp.Colorway, dbo.pSampleRequestMaterialTemp.MaterialComment
			FROM  dbo.pSampleRequestMaterialTemp 
				INNER JOIN dbo.pSampleRequestWorkflow 
					ON dbo.pSampleRequestMaterialTemp.StyleID = dbo.pSampleRequestWorkflow.StyleID 
					AND dbo.pSampleRequestMaterialTemp.StyleColorID = dbo.pSampleRequestWorkflow.StyleColorID 
					AND dbo.pSampleRequestMaterialTemp.StyleSet = dbo.pSampleRequestWorkflow.StyleSet 
					AND dbo.pSampleRequestMaterialTemp.SampleWorkflowID = dbo.pSampleRequestWorkflow.SampleWorkflowID
			WHERE dbo.pSampleRequestMaterialTemp.SampleRequestGroupID = @SampleRequestGroupID
			
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END		
		
	END

	SET NOCOUNT OFF		
	
COMMIT TRANSACTION


/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04771', GetDate())
GO
