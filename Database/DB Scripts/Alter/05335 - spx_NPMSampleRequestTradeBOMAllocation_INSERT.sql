IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestTradeBOMAllocation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestTradeBOMAllocation_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestTradeBOMAllocation_INSERT]
(
	@SampleRequestGroupID nvarchar(50),
	@TradePartnerID nvarchar(50),
	@StyleID nvarchar(50),
	@SampleRequestShare nvarchar(2), 
	@ItemDim1Id uniqueidentifier,
	@ItemDim2Id uniqueidentifier,
	@ItemDim3Id uniqueidentifier,
	@CreatedBy nvarchar(200),
	@CreatedDate datetime , 
	@StyleSourcingID UNIQUEIDENTIFIER = NULL, 
	@StyleSet  nvarchar(50),
	@WorkFlowItemID  nvarchar(50) = NULL,
	@StyleBOMDimensionID   nvarchar(50) = NULL,
	@StyleBOMDimensionItemID   nvarchar(50) = NULL,
	@TradePartnerRelationshipLevelID nvarchar(50) = NULL
)

AS


DECLARE @I as int, @ISet int,  @Row_Count int
DECLARE @ISet_Curr int  , @ISet_Max  int ,
		@SampleRequestWorkflowID nvarchar(50),
		@NewSampleRequestWorkflowID nvarchar(50),
		@StyleRequestWorkflowSetItemID uniqueidentifier,
		@SampleRequestTradeID uniqueidentifier,
		@TechPackID nvarchar(50)

DECLARE  @StyleSeasonYearID UNIQUEIDENTIFIER 

IF @StyleBOMDimensionItemID IS NULL 
BEGIN
	SET @StyleBOMDimensionItemID = '00000000-0000-0000-0000-000000000000'
END

IF Len(@StyleBOMDimensionItemID) = 0
BEGIN
	SET @StyleBOMDimensionItemID = '00000000-0000-0000-0000-000000000000'
END

if @StyleBOMDimensionItemID = '00000000-0000-0000-0000-000000000000'
	begin
		SELECT top 1 @StyleBOMDimensionItemID = COALESCE(StyleBOMDimensionItemID,'00000000-0000-0000-0000-000000000000') 
		FROM pStyleBOMDimensionItems WHERE (ItemDim1Id=@ItemDim1Id or ItemDim1Id is null) AND (ItemDim2Id=@ItemDim2Id or ItemDim2Id is null) AND (ItemDim3Id=@ItemDim3Id or ItemDim3Id is null)  AND StyleBOMDimensionID=@StyleBOMDimensionID AND StyleID=@StyleID
	end 
	
SET @I = 1
SET @ISet = 1
SET @ISet_Curr = 1 

SET NOCOUNT ON


BEGIN TRANSACTION
	BEGIN

		SET @SampleRequestTradeID = newid()		
		
		BEGIN	
		
			SELECT @TechPackID = TechPackID FROM pstyleHeader WHERE StyleId = @StyleId
			IF @TechPackID IS NULL 
			BEGIN
				SET @TechPackID = '00000000-0000-0000-0000-000000000000'
			END

			SELECT TOP 1 @StyleSeasonYearID = b.StyleSeasonYearID 
			FROM pSampleRequestGroupTemp a 
			LEFT OUTER JOIN pStyleSeasonYear b ON a.StyleID = b.StyleID AND a.SeasonYearID =b.SeasonYearID
			WHERE @SampleRequestGroupID = SampleRequestGroupID
			
		
			INSERT INTO pSampleRequestBOMTrade
				(SampleRequestTradeID, TradePartnerVendorID, TradePartnerID, StyleID, 
				ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPackID, CUser, CDate, MUser, MDate, MessageSent, SampleRequestShare, StyleSourcingID , StyleSeasonYearID,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, 
				TradePartnerRelationshipLevelID)
			VALUES (@SampleRequestTradeID, NULL, @TradePartnerID, @StyleID, 
				@ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @TechPackID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 0, @SampleRequestShare  , @StyleSourcingID , @StyleSeasonYearID,@WorkFlowItemID,@StyleBOMDimensionID,@StyleBOMDimensionItemID, 
				@TradePartnerRelationshipLevelID)	
				
			-- share sample request for high level of trade partner hierarchy
			IF @SampleRequestShare = 1
			BEGIN
			INSERT INTO pSampleRequestShare (
				SampleRequestTradeID
				, TradePartnerID
				, MUser
				, MDate) 
			VALUES (
				@SampleRequestTradeID
				, (SELECT COALESCE(AgentID, VendorID, FactoryID)
					FROM vwx_TradePartnerRelationshipLevels_SEL tpm
						INNER JOIN pSampleRequestBOMTrade srt ON tpm.TradePartnerRelationshipLevelID = srt.TradePartnerRelationshipLevelID
					WHERE srt.SampleRequestTradeID = @SampleRequestTradeID)
				, @CreatedBy
				, @CreatedDate)
			END

			
			INSERT INTO pSampleRequestBOMActivity
				(SampleRequestTradeId, TradePartnerId, TradePartnerVendorId, StyleId, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPackId, CUser, CDate, SampleActivity, ActivityType)
			VALUES  (@SampleRequestTradeId, @TradePartnerId, NULL, @StyleId, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @TechPackId, @CreatedBy, @CreatedDate, N'New Sample Request', 'N')
		

			SELECT * FROM pSampleRequestBOMTrade WHERE SampleRequestTradeID = @SampleRequestTradeID
							
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END
				
		END

		BEGIN	

			SELECT @ISet_Max  = Max ( StyleSet )  FROM pSampleRequestSetItemTemp WHERE (SampleRequestGroupID = @SampleRequestGroupID)

			if  @ISet_Max is null 
				SET @ISet_Max = 0 
			else
				SELECT @ISet = Min (StyleSet ) FROM pSampleRequestSetItemTemp WHERE (SampleRequestGroupID = @SampleRequestGroupID)


--For multi Dimension BOM
set @ISet_Max = 1

			WHILE @ISet <= @ISet_Max
				BEGIN

					PRINT  'SET = ' +  CAST  ( @ISet  AS VARCHAR (10) )
					SET  @ISet_Curr = @ISet 		
					SET @StyleRequestWorkflowSetItemID = newid()
	
				
					BEGIN
				
						SELECT IDENTITY(int, 1,1) AS ID_Num, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestGroupID, SampleWorkflowTempItemID, 
							SampleWorkflowID, StyleID, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', StyleSet, Status, Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, StartDate, DueDate, EndDate, CUser, CDate, 
							MUser, MDate INTO ##SampleRequestWorkflowBOMTemp 
						FROM pSampleRequestWorkflowBOMTemp
						WHERE (SampleRequestGroupID = @SampleRequestGroupID) AND (StyleSet = @StyleSet)
						
						SET @Row_Count = (SELECT COUNT(*) FROM ##SampleRequestWorkflowBOMTemp WHERE (SampleRequestGroupID = @SampleRequestGroupID))


						SET @I = 1

						WHILE @I <= @Row_Count 
						BEGIN
							
							SET @NewSampleRequestWorkflowID = newid()
							
							SELECT @SampleRequestWorkflowID = SampleRequestWorkflowID FROM ##SampleRequestWorkflowBOMTemp WHERE ID_Num = @I
								BEGIN

									INSERT INTO pSampleRequestWorkflowBOM
										(TradePartnerVendorID, TradePartnerID, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, 
										ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, Status, Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, StartDate, DueDate, FinalDate, EndDate, CUser, CDate, MUser, MDate , SampleWorkflowFinalDate, SampleWorkflowPartnerTypeID)
									SELECT NULL, @TradePartnerID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, @StyleRequestWorkflowSetItemID, @SampleRequestTradeID AS SampleRequestTradeID, SampleWorkflowTempItemID, 
										SampleWorkflowID, StyleID, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', StyleSet, 0 AS Status, 1 AS Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, StartDate, DueDate, FinalDate, '1/1/1900', CUser, CDate, 
										MUser, MDate , SampleWorkflowFinalDate, SampleWorkflowPartnerTypeID 
									FROM dbo.pSampleRequestWorkflowBOMTemp
									WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleSet = @StyleSet )

									IF @@ERROR <> 0
									BEGIN
										print 'Error 1 ' 
										ROLLBACK TRANSACTION
										RETURN
									END	
								END
								
								BEGIN
			
									INSERT INTO dbo.pSampleRequestSubmitBOM
										(TradePartnerVendorID, TradePartnerID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, Submit, Status, AssignedTo, 
										StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, ResubmitDays, DueDate, EndDate, EndBy, 
										CUser, CDate, MUser, MDate, Comment, InternalComment )
									SELECT NULL, @TradePartnerID, @SampleRequestTradeID AS SampleRequestTradeID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, SampleWorkflowID, StyleID,@ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', StyleSet, WorkflowID, 
										1 AS Submit, 0 AS Status, AssignedTo, StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, ResubmitDays,  
										DueDate, EndDate, EndBy, CUser, CDate, MUser, MDate, Comment, InternalComment 									 
									FROM  dbo.pSampleRequestSubmitBOMTemp
									WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleSet = @StyleSet)
									IF @@ERROR <> 0
									BEGIN
									ROLLBACK TRANSACTION
									RETURN
									END	
								END
						
							SET @I = @I + 1

						END

						DROP TABLE ##SampleRequestWorkflowBOMTemp	

						IF @@ERROR <> 0
						BEGIN
						ROLLBACK TRANSACTION
						RETURN
						END
				
					END					

					SET @ISet = NULL

					SET @ISet = (SELECT TOP 1 StyleSet  FROM pSampleRequestSetItemTemp  WHERE ( SampleRequestGroupID = @SampleRequestGroupID  )  AND (StyleSet  > @ISet_Curr )  order by StyleSet   )
	
					IF  @ISet  IS NULL 
						SET  @ISet  = @ISet_Max + 1 

				END
					
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
			
		END

		print ' No ERROR 1 ' 


		BEGIN
			
			INSERT INTO dbo.pSampleRequestSpecSizeBOM
				(SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, SizeRange, Size0, Size1, Size2, 
				Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Sel12, Sel13, Sel14, 
				Sel15, Sel16, Sel17, Sel18, Sel19, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, 
				Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, MUser, MDate)
			SELECT     @SampleRequestTradeID AS SampleRequestTradeID, dbo.pSampleRequestWorkflowBOM.SampleRequestWorkflowID, 
				dbo.pSampleRequestSpecSizeTemp.SampleWorkflowID, dbo.pSampleRequestSpecSizeTemp.WorkflowID, 
				dbo.pSampleRequestSpecSizeTemp.StyleID, @ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id', dbo.pSampleRequestSpecSizeTemp.StyleSet, 
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
			FROM         dbo.pSampleRequestWorkflowBOM INNER JOIN
				dbo.pSampleRequestSpecSizeTemp ON 
				dbo.pSampleRequestWorkflowBOM.SampleWorkflowID = dbo.pSampleRequestSpecSizeTemp.SampleWorkflowID AND 
				dbo.pSampleRequestWorkflowBOM.StyleID = dbo.pSampleRequestSpecSizeTemp.StyleID AND 
				--dbo.pSampleRequestWorkflowBOM.StyleColorID = dbo.pSampleRequestSpecSizeTemp.StyleColorID AND 
				dbo.pSampleRequestWorkflowBOM.StyleSet = dbo.pSampleRequestSpecSizeTemp.StyleSet
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
		
			INSERT INTO dbo.pSampleRequestStyleBOM
				(SampleRequestTradeID, TradePartnerVendorID, ItemDim1Id,ItemDim2Id,ItemDim3Id,ItemDim1Name,ItemDim2Name,ItemDim3Name, StyleID, StyleSet, Submit, StyleType, WorkflowType, RefNo, 
				StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, RecDate, Customer, Buyer, Designer, 
				SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, MaterialID, MaterialImageID, 
				MaterialImageVersion, MaterialNo, MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, TargetPrice, SellingPrice, 
				CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, 
				CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, 
				Size10, Size11, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, 
				Change, Action, NoColorCombo,
				CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
				CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 , StyleSourcingID 
				)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, NULL AS TradePartnerVendorID, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, ItemDim1Name,ItemDim2Name,ItemDim3Name, StyleID, StyleSet, 
				Submit, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, 
				RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, 
				MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, 
				TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, 
				CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, Size0, Size1, Size2, Size3, Size4, 
				Size5, Size6, Size7, Size8, Size9, Size10, Size11, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Pc1, Pc2, Pc3, Pc4, CUser, 
				CDate, MUser, MDate, Active, Change, Action, NoColorCombo,
				CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
				CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 , @StyleSourcingID
			FROM   dbo.pSampleRequestStyleBOMTemp
			WHERE (SampleRequestGroupID = @SampleRequestGroupID)
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END			

		BEGIN
			
			INSERT INTO dbo.pSampleRequestMaterialBOM
				(SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, RecDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, 
				--ItemDim1Id,ItemDim2Id,ItemDim3Id,
				 StyleSet, WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, 
				MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
				ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,  Source, Notes, Placement, VendorPrice, 
				VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
				MUser, MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialComment)
			SELECT  @SampleRequestTradeID AS SampleRequestTradeID, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, 
				dbo.pSampleRequestMaterialTemp.Submit, dbo.pSampleRequestMaterialTemp.StartDate, dbo.pSampleRequestMaterialTemp.RecDate, 
				dbo.pSampleRequestMaterialTemp.DueDate, dbo.pSampleRequestMaterialTemp.EndDate, dbo.pSampleRequestMaterialTemp.Status, 
				dbo.pSampleRequestMaterialTemp.SampleWorkflowID, dbo.pSampleRequestMaterialTemp.StyleID,
				-- dbo.pSampleRequestMaterialTemp.StyleColorID, 
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
			FROM  dbo.pSampleRequestMaterialTemp INNER JOIN
				dbo.pSampleRequestWorkflow ON dbo.pSampleRequestMaterialTemp.StyleID = dbo.pSampleRequestWorkflow.StyleID AND 
				--dbo.pSampleRequestMaterialTemp.StyleColorID = dbo.pSampleRequestWorkflow.StyleColorID AND 
				dbo.pSampleRequestMaterialTemp.StyleSet = dbo.pSampleRequestWorkflow.StyleSet AND 
				dbo.pSampleRequestMaterialTemp.SampleWorkflowID = dbo.pSampleRequestWorkflow.SampleWorkflowID
			WHERE (dbo.pSampleRequestMaterialTemp.SampleRequestGroupID = @SampleRequestGroupID)
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END				
	END

	SET NOCOUNT OFF		
	
COMMIT TRANSACTION

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05335', GetDate())
GO
