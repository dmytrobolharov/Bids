IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowFinal_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowFinal_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowFinal_INSERT]

(
@SampleRequestGroupID nvarchar(50),
@TradePartnerVendorID nvarchar(50),
@StyleID nvarchar(50),
@StyleColorID nvarchar(50),
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
			SampleWorkflowID, StyleID, StyleColorID, StyleSet, Status, Submit, SubmitDays, AssignedTo, TechPackID, StartDate, DueDate, EndDate, CUser, CDate, 
			MUser, MDate INTO ##SampleRequestWorkflowTemp FROM pSampleRequestWorkflowTemp WITH (NOLOCK)
			WHERE (SampleRequestGroupID = @SampleRequestGroupID)

			SET @Row_Count = (SELECT COUNT(*) FROM ##SampleRequestWorkflowTemp)

			WHILE @I <= @Row_Count 
				BEGIN
				
				SET @NewSampleRequestWorkflowID = newid()
				
				SELECT @StyleRequestWorkflowSetItemID = StyleRequestWorkflowSetItemID, @SampleRequestWorkflowID = SampleRequestWorkflowID FROM ##SampleRequestWorkflowTemp WHERE ID_Num = @I
						
						
				SELECT @SampleRequestTradeID = SampleRequestTradeID, @TradePartnerID = TradePartnerID FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE StyleRequestWorkflowSetItemID = @StyleRequestWorkflowSetItemID
						
						BEGIN
	
							INSERT INTO dbo.pSampleRequestWorkflow
							(TradePartnerVendorID, TradePartnerID, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, 
							StyleColorID, StyleSet, Status, Submit, SubmitDays, AssignedTo, TechPackID, StartDate, DueDate, EndDate, CUser, CDate, MUser, MDate)
							SELECT @TradePartnerVendorID, @TradePartnerID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, @SampleRequestTradeID, SampleWorkflowTempItemID, 
							SampleWorkflowID, StyleID, StyleColorID, StyleSet, 0 AS Status, 1 AS Submit, SubmitDays, AssignedTo, TechPackID, ISNULL(StartDate, @CreatedDate), DueDate, '1/1/1900', CUser, CDate, 
							MUser, MDate
							FROM dbo.pSampleRequestWorkflowTemp WITH (NOLOCK)
							WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)
							IF @@ERROR <> 0
							BEGIN
							ROLLBACK TRANSACTION
							RETURN
							END	
						END
						
						BEGIN
	
							INSERT INTO dbo.pSampleRequestSubmit
							(TradePartnerVendorID, TradePartnerID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, StyleID, StyleColorID, StyleSet, WorkflowID, Submit, Status, AssignedTo, 
							StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, DueDate, EndDate, EndBy, 
							CUser, CDate, MUser, MDate, Comment, InternalComment)
							SELECT @TradePartnerVendorID, @TradePartnerID, @SampleRequestTradeID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, SampleWorkflowID, StyleID, StyleColorID, StyleSet, WorkflowID, 
							1 AS Submit, 0 AS Status, AssignedTo, ISNULL(StartDate, @CreatedDate), RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, 
							DueDate, EndDate, EndBy, CUser, CDate, MUser, MDate, Comment, InternalComment
							FROM  dbo.pSampleRequestSubmitTemp WITH (NOLOCK)
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
			
			INSERT INTO dbo.pSampleRequestSpecSize
			(SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, StyleID, StyleColorID, StyleSet, 
			SizeRange, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, 
			Sel9, Sel10, Sel11, Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, MUser, MDate)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, 
			dbo.pSampleRequestSpecSizeTemp.SampleWorkflowID, 
			dbo.pSampleRequestSpecSizeTemp.WorkflowID, dbo.pSampleRequestSpecSizeTemp.StyleID, dbo.pSampleRequestSpecSizeTemp.StyleColorID, 
			dbo.pSampleRequestSpecSizeTemp.StyleSet, dbo.pSampleRequestSpecSizeTemp.SizeRange, dbo.pSampleRequestSpecSizeTemp.Size0, 
			dbo.pSampleRequestSpecSizeTemp.Size1, dbo.pSampleRequestSpecSizeTemp.Size2, dbo.pSampleRequestSpecSizeTemp.Size3, 
			dbo.pSampleRequestSpecSizeTemp.Size4, dbo.pSampleRequestSpecSizeTemp.Size5, dbo.pSampleRequestSpecSizeTemp.Size6, 
			dbo.pSampleRequestSpecSizeTemp.Size7, dbo.pSampleRequestSpecSizeTemp.Size8, dbo.pSampleRequestSpecSizeTemp.Size9, 
			dbo.pSampleRequestSpecSizeTemp.Size10, dbo.pSampleRequestSpecSizeTemp.Size11, dbo.pSampleRequestSpecSizeTemp.Sel0, 
			dbo.pSampleRequestSpecSizeTemp.Sel1, dbo.pSampleRequestSpecSizeTemp.Sel2, dbo.pSampleRequestSpecSizeTemp.Sel3, 
			dbo.pSampleRequestSpecSizeTemp.Sel4, dbo.pSampleRequestSpecSizeTemp.Sel5, dbo.pSampleRequestSpecSizeTemp.Sel6, 
			dbo.pSampleRequestSpecSizeTemp.Sel7, dbo.pSampleRequestSpecSizeTemp.Sel8, dbo.pSampleRequestSpecSizeTemp.Sel9, 
			dbo.pSampleRequestSpecSizeTemp.Sel10, dbo.pSampleRequestSpecSizeTemp.Sel11, dbo.pSampleRequestSpecSizeTemp.Col0, 
			dbo.pSampleRequestSpecSizeTemp.Col1, dbo.pSampleRequestSpecSizeTemp.Col2, dbo.pSampleRequestSpecSizeTemp.Col3, 
			dbo.pSampleRequestSpecSizeTemp.Col4, dbo.pSampleRequestSpecSizeTemp.Col5, dbo.pSampleRequestSpecSizeTemp.Col6, 
			dbo.pSampleRequestSpecSizeTemp.Col7, dbo.pSampleRequestSpecSizeTemp.Col8, dbo.pSampleRequestSpecSizeTemp.Col9, 
			dbo.pSampleRequestSpecSizeTemp.Col10, dbo.pSampleRequestSpecSizeTemp.Col11, dbo.pSampleRequestSpecSizeTemp.MUser, 
			dbo.pSampleRequestSpecSizeTemp.MDate
			FROM  dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleRequestSpecSizeTemp WITH (NOLOCK) ON 
			dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleRequestSpecSizeTemp.SampleWorkflowID AND 
			dbo.pSampleRequestWorkflow.StyleID = dbo.pSampleRequestSpecSizeTemp.StyleID AND 
			dbo.pSampleRequestWorkflow.StyleColorID = dbo.pSampleRequestSpecSizeTemp.StyleColorID AND 
			dbo.pSampleRequestWorkflow.StyleSet = dbo.pSampleRequestSpecSizeTemp.StyleSet
			WHERE (dbo.pSampleRequestSpecSizeTemp.SampleRequestGroupID = @SampleRequestGroupID)
			IF @@ERROR <> 0
			BEGIN
			ROLLBACK TRANSACTION
			RETURN
			END	
		END		

		BEGIN
			
			INSERT INTO dbo.pSampleRequestMaterial
				(SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, RecDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, 
				StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, 
				MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, 
				NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, 
				X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, 
				ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, 
				MaterialComment)
			SELECT @SampleRequestTradeID AS SampleRequestTradeID, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, 
				dbo.pSampleRequestMaterialTemp.Submit, dbo.pSampleRequestMaterialTemp.StartDate, dbo.pSampleRequestMaterialTemp.RecDate, 
				dbo.pSampleRequestMaterialTemp.DueDate, dbo.pSampleRequestMaterialTemp.EndDate, dbo.pSampleRequestMaterialTemp.Status, 
				dbo.pSampleRequestMaterialTemp.SampleWorkflowID, dbo.pSampleRequestMaterialTemp.StyleID, dbo.pSampleRequestMaterialTemp.StyleColorID, 
				dbo.pSampleRequestMaterialTemp.StyleSet, dbo.pSampleRequestMaterialTemp.WorkflowID, 
				dbo.pSampleRequestMaterialTemp.TradePartnerVendorID, dbo.pSampleRequestMaterialTemp.StyleMaterialID, 
				dbo.pSampleRequestMaterialTemp.MainMaterial, dbo.pSampleRequestMaterialTemp.Development, dbo.pSampleRequestMaterialTemp.MiscColor, 
				dbo.pSampleRequestMaterialTemp.UOM, dbo.pSampleRequestMaterialTemp.Qty, dbo.pSampleRequestMaterialTemp.MaterialPrice, 
				dbo.pSampleRequestMaterialTemp.Ext, dbo.pSampleRequestMaterialTemp.MaterialSize, dbo.pSampleRequestMaterialTemp.MaterialID, 
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
				dbo.pSampleRequestMaterialTemp.S, dbo.pSampleRequestMaterialTemp.T, dbo.pSampleRequestMaterialTemp.U, 
				dbo.pSampleRequestMaterialTemp.V, dbo.pSampleRequestMaterialTemp.W, dbo.pSampleRequestMaterialTemp.X, 
				dbo.pSampleRequestMaterialTemp.Y, dbo.pSampleRequestMaterialTemp.Z, dbo.pSampleRequestMaterialTemp.Source, 
				dbo.pSampleRequestMaterialTemp.Notes, dbo.pSampleRequestMaterialTemp.Placement, dbo.pSampleRequestMaterialTemp.VendorPrice, 
				dbo.pSampleRequestMaterialTemp.VolumePrice, dbo.pSampleRequestMaterialTemp.VolumePriceMinimum, 
				dbo.pSampleRequestMaterialTemp.VendorProductionMin, dbo.pSampleRequestMaterialTemp.VendorProductionLeadTime, 
				dbo.pSampleRequestMaterialTemp.DetailYesNo, dbo.pSampleRequestMaterialTemp.ImageType, dbo.pSampleRequestMaterialTemp.height, 
				dbo.pSampleRequestMaterialTemp.width, dbo.pSampleRequestMaterialTemp.CDate, dbo.pSampleRequestMaterialTemp.CUser, 
				dbo.pSampleRequestMaterialTemp.MDate, dbo.pSampleRequestMaterialTemp.MUser, dbo.pSampleRequestMaterialTemp.MChange, 
				dbo.pSampleRequestMaterialTemp.SChange, dbo.pSampleRequestMaterialTemp.DChange, dbo.pSampleRequestMaterialTemp.CChange, 
				dbo.pSampleRequestMaterialTemp.Action, dbo.pSampleRequestMaterialTemp.ColorPlacement, dbo.pSampleRequestMaterialTemp.Artwork, 
				dbo.pSampleRequestMaterialTemp.License, dbo.pSampleRequestMaterialTemp.Colorway, dbo.pSampleRequestMaterialTemp.MaterialComment
			FROM dbo.pSampleRequestMaterialTemp WITH (NOLOCK) INNER JOIN
				dbo.pSampleRequestWorkflow WITH (NOLOCK) ON dbo.pSampleRequestMaterialTemp.StyleID = dbo.pSampleRequestWorkflow.StyleID AND 
				dbo.pSampleRequestMaterialTemp.StyleColorID = dbo.pSampleRequestWorkflow.StyleColorID AND 
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
VALUES ('DB_Version', '0.5.0000', '08743', GetDate())
GO
