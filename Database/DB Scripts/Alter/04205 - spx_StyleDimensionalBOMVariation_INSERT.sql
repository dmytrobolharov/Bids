/****** Object:  StoredProcedure [dbo].[spx_StyleDimensionalBOMVariation_INSERT]    Script Date: 09/06/2012 10:03:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimensionalBOMVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimensionalBOMVariation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDimensionalBOMVariation_INSERT]    Script Date: 09/06/2012 10:03:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDimensionalBOMVariation_INSERT]
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Dimensional BOM Workflow ID
	DECLARE @WorkflowID UNIQUEIDENTIFIER
	SET @WorkflowID = '40000000-0000-0000-0000-000000000080'
	
	DECLARE @WorkflowItemID UNIQUEIDENTIFIER
	DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @WorkflowItemCursor CURSOR
	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @NewStyleBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @StyleBOMCursor CURSOR
	DECLARE @StyleMaterialID UNIQUEIDENTIFIER
	DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER
	DECLARE @StyleBOMDimensionItemsCursor CURSOR
	DECLARE @StyleBOMDimensionItemID UNIQUEIDENTIFIER
	DECLARE @NewStyleBOMDimensionItemID UNIQUEIDENTIFIER
	
	SET @WorkflowItemCursor = CURSOR SCROLL
	FOR SELECT WorkFlowItemID FROM pWorkFlowItem WHERE StyleID = @StyleID AND WorkflowID = @WorkflowID
	OPEN @WorkflowItemCursor
	FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SELECT @NewWorkflowItemID = NEWID()
		-- Inserting the data from current workflow item into new workflow item
		INSERT INTO pWorkFlowItem (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName,
									Sort, CUser, CDate, MUser, MDate, StyleSet, RepRowGuidColID, StatusID, 
									WorkStart, WorkDue, WorkAssignedTo, WorkStatus, WorkEscalateTo)
		SELECT @NewWorkflowItemID, WorkflowID, WorkflowItemTypeId, @NewStyleID, WorkFlowItemName,
									Sort, CUser, CDate, MUser, MDate, StyleSet, RepRowGuidColID, StatusID, 
									WorkStart, WorkDue, WorkAssignedTo, WorkStatus, WorkEscalateTo
		FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemID
		-- Inserting the data from current BOM dimension into new workflow item
		SELECT @NewStyleBOMDimensionID = NEWID()
		SELECT @StyleBOMDimensionID = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @WorkflowItemID
		INSERT INTO pStyleBOMDimension (StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, StyleSet, ItemDim1TypeId,
										ItemDim2TypeId, ItemDim3TypeId, ItemDim1TypeName, ItemDim2TypeName, ItemDim3TypeName,
										Comments, ImageId, CUser, CDate, MUser, MDate, IsAvgQuantity, AverageCost)
		SELECT @NewStyleBOMDimensionID, @WorkflowID, @NewWorkflowItemID, @NewStyleID, StyleSet, ItemDim1TypeId,
										ItemDim2TypeId, ItemDim3TypeId, ItemDim1TypeName, ItemDim2TypeName, ItemDim3TypeName,
										Comments, ImageId, CUser, CDate, MUser, MDate, IsAvgQuantity, AverageCost
		FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		-- Inserting the data from current pStyleBOMDimensionItem into newly created
		INSERT INTO pStyleBOMDimensionItem (StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, StyleSet, 
											ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, 
											ItemDim2Name, ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, 
											ItemDim3Active, Comments, ImageId, CDate, CUser, MDate, MUser, Amlmeashdrid, Sizerangeid)
		SELECT @NewStyleBOMDimensionID, @WorkFlowID, @NewWorkFlowItemID, @NewStyleID, StyleSet, 
											ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, 
											ItemDim2Name, ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, 
											ItemDim3Active, Comments, ImageId, CDate, CUser, MDate, MUser, Amlmeashdrid, Sizerangeid
		FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		
		-- Inserting the data from pStyleBOMDimensionItems and adding records from Style BOM Item to it
		SET @StyleBOMDimensionItemsCursor = CURSOR SCROLL
		FOR SELECT StyleBOMDimensionItemID FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionId = @StyleBOMDimensionID
		OPEN @StyleBOMDimensionItemsCursor
		FETCH NEXT FROM @StyleBOMDimensionItemsCursor INTO @StyleBOMDimensionItemID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @NewStyleBOMDimensionItemID = NEWID()
			INSERT INTO pStyleBOMDimensionItems (StyleBOMDimensionItemID, StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, 
													StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, 
													ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, 
													ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, ItemDim3Active, 
													ItemDimActive, Comments, ImageId, CDate, CUser, MDate, MUser, SKUcost)
			SELECT @NewStyleBOMDimensionItemID, @NewStyleBOMDimensionID, WorkFlowID, @NewWorkFlowItemID, 
					@NewStyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, 
					ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, 
					ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, ItemDim3Active, 
					ItemDimActive, Comments, ImageId, CDate, CUser, MDate, MUser, SKUcost
			FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionItemID = @StyleBOMDimensionItemID
			
			INSERT INTO pStyleBOMItem (StyleBOMDimensionID, StyleBOMDimensionItemID, StyleMaterialID, WorkFlowID, 
										WorkFlowItemID, StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name, 
										ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name, ItemDim3ColSelId, MaterialColorId, MaterialQuantity, MaterialDimension, 
										MaterialPrice, Comments, ImageId, CDate, CUser, MDate, MUser)
			SELECT @NewStyleBOMDimensionID, @NewStyleBOMDimensionItemID, StyleMaterialID, @WorkFlowID, 
										@NewWorkFlowItemID, @NewStyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name, 
										ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name, ItemDim3ColSelId, MaterialColorId, MaterialQuantity, MaterialDimension, 
										MaterialPrice, Comments, ImageId, CDate, CUser, MDate, MUser
			FROM pStyleBOMItem WHERE StyleBOMDimensionItemID = @StyleBOMDimensionItemID
			
			FETCH NEXT FROM @StyleBOMDimensionItemsCursor INTO @StyleBOMDimensionItemID
		END
		CLOSE @StyleBOMDimensionItemsCursor
		DEALLOCATE @StyleBOMDimensionItemsCursor
		
		-- Inserting the data from current BOM into new BOM and copying BOMMisc from every of it.
		SET @StyleBOMCursor = CURSOR SCROLL
		FOR SELECT StyleMaterialID FROM pStyleBOM WHERE StyleBOMDimensionId = @StyleBOMDimensionID
		OPEN @StyleBOMCursor
		FETCH NEXT FROM @StyleBOMCursor INTO @StyleMaterialID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @NewStyleMaterialID = NEWID()
			INSERT INTO pStyleBOM (StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID, MainMaterial, Development, MiscColor, StyleSet, StyleID, 
									WorkflowId, WorkflowItemId, StyleBOMDimensionId, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, UOM, Qty, MaterialPrice, 
									Ext, MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, 
									MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
									ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E,
									 F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
									 Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
									 VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, 
									 height, width, CDate, CUser, MDate, MUser, MChange, SChange, DChange, 
									 CChange, Action, ColorPlacement, Artwork, License, Colorway, 
									 MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension, 
									 MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, 
									 MaterialSizeA4, MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, 
									 MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, MaterialSizeA11, 
									 MaterialSizeA12, MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, 
									 MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
									 MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, 
									 MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9, 
									 MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, 
									 MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, 
									 MaterialSizeB18, MaterialSizeB19, MaterialLining, MaterialSizeID, 
									 MaterialColorId, MaterialPackLabelGroupID, TradePartnerID, 
									 TradePartnerVendorID, MaterialBOM, MaterialCode, StyleMaterialLinkID, 
									 MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, 
									 WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode, WebPDMCustom_Approved, 
									 WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction, WebPDMCustom_GroupDesc, 
									 WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, 
									 WebPDMCustom_Comments, AUTOCOLOR)
			SELECT @NewStyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID, MainMaterial, Development, MiscColor, StyleSet, @NewStyleID, 
									@WorkflowId, @NewWorkflowItemId, @NewStyleBOMDimensionId, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, UOM, Qty, MaterialPrice, 
									Ext, MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, 
									MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
									ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E,
									 F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
									 Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
									 VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, 
									 height, width, CDate, CUser, MDate, MUser, MChange, SChange, DChange, 
									 CChange, Action, ColorPlacement, Artwork, License, Colorway, 
									 MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension, 
									 MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, 
									 MaterialSizeA4, MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, 
									 MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, MaterialSizeA11, 
									 MaterialSizeA12, MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, 
									 MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
									 MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, 
									 MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9, 
									 MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, 
									 MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, 
									 MaterialSizeB18, MaterialSizeB19, MaterialLining, MaterialSizeID, 
									 MaterialColorId, MaterialPackLabelGroupID, TradePartnerID, 
									 TradePartnerVendorID, MaterialBOM, MaterialCode, StyleMaterialLinkID, 
									 MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, 
									 WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode, WebPDMCustom_Approved, 
									 WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction, WebPDMCustom_GroupDesc, 
									 WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, 
									 WebPDMCustom_Comments, AUTOCOLOR
			FROM pStyleBOM WHERE StyleMaterialID = @StyleMaterialID
			-- Adding misc items to style material
			INSERT INTO pStyleBOMMiscItem (StyleBOMDimensionID, StyleBOMDimensionItemID, StyleMaterialMiscID, StyleMaterialID, 
											MaterialNo, MaterialName, Placement, SubMaterial, MiscColorId, Custom1, Custom2, Sort, CDate, CUser, 
											MDate, MUser)
			SELECT @NewStyleBOMDimensionID, StyleBOMDimensionItemID, StyleMaterialMiscID, @NewStyleMaterialID, 
					MaterialNo, MaterialName, Placement, SubMaterial, MiscColorId, Custom1, Custom2, Sort, CDate, CUser, 
					MDate, MUser
			FROM pStyleBOMMiscItem WHERE StyleMaterialID = @StyleMaterialID
			-- Updating pStyleBOMItem, which was added before, but with old StyleMaterialID
			UPDATE pStyleBOMItem SET StyleMaterialID = @NewStyleMaterialID WHERE StyleBOMDimensionID = @NewStyleBOMDimensionID AND StyleMaterialID = @StyleMaterialID
		
			FETCH NEXT FROM @StyleBOMCursor INTO @StyleMaterialID
		END
		CLOSE @StyleBOMCursor
		DEALLOCATE @StyleBOMCursor
		
		
		FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	 END 
   
	CLOSE @WorkflowItemCursor
	DEALLOCATE @WorkflowItemCursor
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04205', GetDate())
GO
