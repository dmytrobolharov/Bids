IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowFinalBOM_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowFinalBOM_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowFinalBOM_INSERT]

(
@SampleRequestGroupID nvarchar(50),
@TradePartnerVendorID nvarchar(50),
@StyleID nvarchar(50),
@ItemDim1Id  nvarchar(50) = null,
@ItemDim2Id  nvarchar(50) = null,
@ItemDim3Id  nvarchar(50) = null,
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(200)
)


AS

DECLARE @I as int, @Row_Count int, 
@SampleRequestWorkflowID nvarchar(50),
@NewSampleRequestWorkflowID nvarchar(50),
@StyleRequestWorkflowSetItemID nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@TradePartnerID nvarchar(50),
@TechPackID nvarchar(50)

SET @I = 1

SET NOCOUNT ON

BEGIN TRANSACTION

	BEGIN
	
	

			/**/			
		
		BEGIN
	
			SELECT IDENTITY(int, 1,1) AS ID_Num, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestGroupID, SampleWorkflowTempItemID, 
			SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, Status, Submit, SubmitDays, AssignedTo, TechPackID, StartDate, DueDate, EndDate, CUser, CDate, 
			MUser, MDate INTO ##SampleRequestWorkflowTemp FROM pSampleRequestWorkflowBOMTemp WITH (NOLOCK)
			WHERE (SampleRequestGroupID = @SampleRequestGroupID)

			SET @Row_Count = (SELECT COUNT(*) FROM ##SampleRequestWorkflowTemp)

			WHILE @I <= @Row_Count 
				BEGIN
				
				SET @NewSampleRequestWorkflowID = newid()
				
				SELECT @StyleRequestWorkflowSetItemID = StyleRequestWorkflowSetItemID, @SampleRequestWorkflowID = SampleRequestWorkflowID FROM ##SampleRequestWorkflowTemp WHERE ID_Num = @I
						
						
				SELECT @SampleRequestTradeID = SampleRequestTradeID, @TradePartnerID = TradePartnerID FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE StyleRequestWorkflowSetItemID = @StyleRequestWorkflowSetItemID
						
						BEGIN
	
							INSERT INTO dbo.pSampleRequestWorkflowBOM
							(TradePartnerVendorID, TradePartnerID, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, 
							ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, Status, Submit, SubmitDays, AssignedTo, TechPackID, StartDate, DueDate, EndDate, CUser, CDate, MUser, MDate)
							SELECT @TradePartnerVendorID, @TradePartnerID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, @SampleRequestTradeID, SampleWorkflowTempItemID, 
							SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, 0 AS Status, 1 AS Submit, SubmitDays, AssignedTo, TechPackID, ISNULL(StartDate, @CreatedDate), DueDate, '1/1/1900', CUser, CDate, 
							MUser, MDate
							FROM dbo.pSampleRequestWorkflowBOMTemp WITH (NOLOCK)
							WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)
							IF @@ERROR <> 0
							BEGIN
							ROLLBACK TRANSACTION
							RETURN
							END	
						END
						
						BEGIN
	
							INSERT INTO dbo.pSampleRequestSubmitBOM
							(TradePartnerVendorID, TradePartnerID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, Submit, Status, AssignedTo, 
							StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, DueDate, EndDate, EndBy, 
							CUser, CDate, MUser, MDate, Comment, InternalComment)
							SELECT @TradePartnerVendorID, @TradePartnerID, @SampleRequestTradeID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, 
							1 AS Submit, 0 AS Status, AssignedTo, ISNULL(StartDate, @CreatedDate), RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, 
							DueDate, EndDate, EndBy, CUser, CDate, MUser, MDate, Comment, InternalComment
							FROM  dbo.pSampleRequestSubmitBOMTemp WITH (NOLOCK)
							WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)
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


		BEGIN
			
			INSERT INTO dbo.pSampleRequestSpecSizeBOM
			(SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, 
			SizeRange, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, 
			Sel9, Sel10, Sel11, Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, MUser, MDate)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, pSampleRequestWorkflowBOM.SampleRequestWorkflowID, 
			pSampleRequestSpecSizeTemp.SampleWorkflowID, 
			pSampleRequestSpecSizeTemp.WorkflowID, pSampleRequestSpecSizeTemp.StyleID, pSampleRequestSpecSizeTemp.ItemDim1Id, pSampleRequestSpecSizeTemp.ItemDim2Id,pSampleRequestSpecSizeTemp.ItemDim3Id,
			pSampleRequestSpecSizeTemp.StyleSet, pSampleRequestSpecSizeTemp.SizeRange, pSampleRequestSpecSizeTemp.Size0, 
			pSampleRequestSpecSizeTemp.Size1, pSampleRequestSpecSizeTemp.Size2, pSampleRequestSpecSizeTemp.Size3, 
			pSampleRequestSpecSizeTemp.Size4, pSampleRequestSpecSizeTemp.Size5, pSampleRequestSpecSizeTemp.Size6, 
			pSampleRequestSpecSizeTemp.Size7, pSampleRequestSpecSizeTemp.Size8, pSampleRequestSpecSizeTemp.Size9, 
			pSampleRequestSpecSizeTemp.Size10, pSampleRequestSpecSizeTemp.Size11, pSampleRequestSpecSizeTemp.Sel0, 
			pSampleRequestSpecSizeTemp.Sel1, pSampleRequestSpecSizeTemp.Sel2, pSampleRequestSpecSizeTemp.Sel3, 
			pSampleRequestSpecSizeTemp.Sel4, pSampleRequestSpecSizeTemp.Sel5, pSampleRequestSpecSizeTemp.Sel6, 
			pSampleRequestSpecSizeTemp.Sel7, pSampleRequestSpecSizeTemp.Sel8, pSampleRequestSpecSizeTemp.Sel9, 
			pSampleRequestSpecSizeTemp.Sel10, pSampleRequestSpecSizeTemp.Sel11, pSampleRequestSpecSizeTemp.Col0, 
			pSampleRequestSpecSizeTemp.Col1, pSampleRequestSpecSizeTemp.Col2, pSampleRequestSpecSizeTemp.Col3, 
			pSampleRequestSpecSizeTemp.Col4, pSampleRequestSpecSizeTemp.Col5, pSampleRequestSpecSizeTemp.Col6, 
			pSampleRequestSpecSizeTemp.Col7, pSampleRequestSpecSizeTemp.Col8, pSampleRequestSpecSizeTemp.Col9, 
			pSampleRequestSpecSizeTemp.Col10, pSampleRequestSpecSizeTemp.Col11, pSampleRequestSpecSizeTemp.MUser, 
			pSampleRequestSpecSizeTemp.MDate
			FROM  dbo.pSampleRequestWorkflowBOM WITH (NOLOCK) INNER JOIN
			dbo.pSampleRequestSpecSizeBOMTemp pSampleRequestSpecSizeTemp WITH (NOLOCK) ON 
			dbo.pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleRequestSpecSizeTemp.SampleWorkflowID AND 
			dbo.pSampleRequestWorkflowBOM.StyleID = pSampleRequestSpecSizeTemp.StyleID AND 
			dbo.pSampleRequestWorkflowBOM.ItemDim1Id = pSampleRequestSpecSizeTemp.ItemDim1Id AND 
			dbo.pSampleRequestWorkflowBOM.ItemDim2Id = pSampleRequestSpecSizeTemp.ItemDim2Id AND 
			dbo.pSampleRequestWorkflowBOM.ItemDim3Id = pSampleRequestSpecSizeTemp.ItemDim3Id AND 
			dbo.pSampleRequestWorkflowBOM.StyleSet = pSampleRequestSpecSizeTemp.StyleSet
			WHERE (pSampleRequestSpecSizeTemp.SampleRequestGroupID = @SampleRequestGroupID)
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END		

		BEGIN
			
			INSERT INTO dbo.pSampleRequestMaterialBOM
				(SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, RecDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, 
				ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, 
				MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, 
				NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, 
				X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, 
				ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, 
				MaterialComment)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, pSampleRequestWorkflowBOM.SampleRequestWorkflowID, 
				pSampleRequestMaterialTemp.Submit, pSampleRequestMaterialTemp.StartDate, pSampleRequestMaterialTemp.RecDate, 
				pSampleRequestMaterialTemp.DueDate, pSampleRequestMaterialTemp.EndDate, pSampleRequestMaterialTemp.Status, 
				pSampleRequestMaterialTemp.SampleWorkflowID, pSampleRequestMaterialTemp.StyleID, pSampleRequestMaterialTemp.ItemDim1Id,pSampleRequestMaterialTemp.ItemDim2Id,pSampleRequestMaterialTemp.ItemDim3Id, 
				pSampleRequestMaterialTemp.StyleSet, pSampleRequestMaterialTemp.WorkflowID, 
				pSampleRequestMaterialTemp.TradePartnerVendorID, pSampleRequestMaterialTemp.StyleMaterialID, 
				pSampleRequestMaterialTemp.MainMaterial, pSampleRequestMaterialTemp.Development, pSampleRequestMaterialTemp.MiscColor, 
				pSampleRequestMaterialTemp.UOM, pSampleRequestMaterialTemp.Qty, pSampleRequestMaterialTemp.MaterialPrice, 
				pSampleRequestMaterialTemp.Ext, pSampleRequestMaterialTemp.MaterialSize, pSampleRequestMaterialTemp.MaterialID, 
				pSampleRequestMaterialTemp.MaterialPlacement, pSampleRequestMaterialTemp.MaterialPlacementCode, 
				pSampleRequestMaterialTemp.MaterialPlacementDetail, pSampleRequestMaterialTemp.MaterialImageID, 
				pSampleRequestMaterialTemp.MaterialImageVersion, pSampleRequestMaterialTemp.NoColorMatch, 
				pSampleRequestMaterialTemp.SupplierID, pSampleRequestMaterialTemp.ComponentTypeID, 
				pSampleRequestMaterialTemp.MaterialType, pSampleRequestMaterialTemp.MaterialNo, pSampleRequestMaterialTemp.MaterialName, 
				pSampleRequestMaterialTemp.A, pSampleRequestMaterialTemp.B, pSampleRequestMaterialTemp.C, 
				pSampleRequestMaterialTemp.D, pSampleRequestMaterialTemp.E, pSampleRequestMaterialTemp.F, 
				pSampleRequestMaterialTemp.G, pSampleRequestMaterialTemp.H, pSampleRequestMaterialTemp.I, 
				pSampleRequestMaterialTemp.J, pSampleRequestMaterialTemp.K, pSampleRequestMaterialTemp.L, 
				pSampleRequestMaterialTemp.M, pSampleRequestMaterialTemp.N, pSampleRequestMaterialTemp.O, 
				pSampleRequestMaterialTemp.P, pSampleRequestMaterialTemp.Q, pSampleRequestMaterialTemp.R, 
				pSampleRequestMaterialTemp.S, pSampleRequestMaterialTemp.T, pSampleRequestMaterialTemp.U, 
				pSampleRequestMaterialTemp.V, pSampleRequestMaterialTemp.W, pSampleRequestMaterialTemp.X, 
				pSampleRequestMaterialTemp.Y, pSampleRequestMaterialTemp.Z, pSampleRequestMaterialTemp.Source, 
				pSampleRequestMaterialTemp.Notes, pSampleRequestMaterialTemp.Placement, pSampleRequestMaterialTemp.VendorPrice, 
				pSampleRequestMaterialTemp.VolumePrice, pSampleRequestMaterialTemp.VolumePriceMinimum, 
				pSampleRequestMaterialTemp.VendorProductionMin, pSampleRequestMaterialTemp.VendorProductionLeadTime, 
				pSampleRequestMaterialTemp.DetailYesNo, pSampleRequestMaterialTemp.ImageType, pSampleRequestMaterialTemp.height, 
				pSampleRequestMaterialTemp.width, pSampleRequestMaterialTemp.CDate, pSampleRequestMaterialTemp.CUser, 
				pSampleRequestMaterialTemp.MDate, pSampleRequestMaterialTemp.MUser, pSampleRequestMaterialTemp.MChange, 
				pSampleRequestMaterialTemp.SChange, pSampleRequestMaterialTemp.DChange, pSampleRequestMaterialTemp.CChange, 
				pSampleRequestMaterialTemp.Action, pSampleRequestMaterialTemp.ColorPlacement, pSampleRequestMaterialTemp.Artwork, 
				pSampleRequestMaterialTemp.License, pSampleRequestMaterialTemp.Colorway, pSampleRequestMaterialTemp.MaterialComment
			FROM dbo.pSampleRequestMaterialBOMTemp  pSampleRequestMaterialTemp WITH (NOLOCK) INNER JOIN
				dbo.pSampleRequestWorkflowBOM WITH (NOLOCK) ON pSampleRequestMaterialTemp.StyleID = dbo.pSampleRequestWorkflowBOM.StyleID AND 
				pSampleRequestMaterialTemp.ItemDim1Id = pSampleRequestWorkflowBOM.ItemDim1Id AND 
				pSampleRequestMaterialTemp.ItemDim2Id = pSampleRequestWorkflowBOM.ItemDim2Id AND 
				pSampleRequestMaterialTemp.ItemDim3Id = pSampleRequestWorkflowBOM.ItemDim3Id AND 
				pSampleRequestMaterialTemp.StyleSet =  pSampleRequestWorkflowBOM.StyleSet AND 
				pSampleRequestMaterialTemp.SampleWorkflowID = dbo.pSampleRequestWorkflowBOM.SampleWorkflowID
			WHERE (pSampleRequestMaterialTemp.SampleRequestGroupID = @SampleRequestGroupID)
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
VALUES ('DB_Version', '0.5.0000', '08744', GetDate())
GO
