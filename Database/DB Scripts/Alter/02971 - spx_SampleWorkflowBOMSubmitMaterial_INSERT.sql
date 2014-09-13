IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmitMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitMaterial_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitMaterial_INSERT]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleSet int,
@CreatedDate nvarchar(50),
@CreatedBy nvarchar(50),
@Submit int,
@NewSubmit nvarchar(50),
@SampleRequestSubmitID uniqueidentifier = null,
@SampleRequestSubmitVendorID uniqueidentifier = null)

AS 

DECLARE @ResubmitDays int
SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
DECLARE @SampleRequestSubmitNewId uniqueidentifier
set @SampleRequestSubmitNewId = NEWID()
BEGIN
IF (@SampleWorkflowID = '20A') --GCC
	BEGIN
	
		INSERT INTO pSampleRequestSubmitVendor
		(SampleRequestSubmitID, TradePartnerVendorID, VendorType, CUser, CDate)
		SELECT  @SampleRequestSubmitNewId, TradePartnerVendorID, VendorType, @CreatedBy, @CreatedDate
		FROM pSampleRequestSubmitVendor WITH (NOLOCK)
		WHERE (SampleRequestSubmitID = @SampleRequestSubmitID)
	
		INSERT INTO pSampleRequestGCCWorkflow
		(SampleRequestSubmitID, Custom1, Custom2, Custom3, Custom4, Sort, CUser, CDate, MUser, 
		 MDate,SampleRequestSubmitVendorID, Submit)
		SELECT  @SampleRequestSubmitNewId, Custom1, Custom2, Custom3, Custom4, Sort, @CreatedBy, @CreatedDate, @CreatedBy, 
		 @CreatedDate, SampleRequestSubmitVendorID,@NewSubmit
		FROM pSampleRequestGCCWorkflow WITH (NOLOCK)
		WHERE (SampleRequestSubmitID = @SampleRequestSubmitID) AND (SampleRequestSubmitVendorID = @SampleRequestSubmitVendorID) AND (Submit = @Submit)
		
		
		
	END
ELSE
	BEGIN
		INSERT INTO dbo.pSampleRequestMaterialBOM
		(Submit, DueDate, Status, SampleRequestWorkflowID, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, SampleRequestTradeID, 
		WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, 
		VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
		MUser, MChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialComment)
		SELECT @NewSubmit, DueDate, 0, SampleRequestWorkflowID, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, SampleRequestTradeID, 
		WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, 
		VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, @CreatedDate, @CreatedBy, @CreatedDate, 
		@CreatedBy, MChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialComment
		FROM dbo.pSampleRequestMaterialBOM WITH (NOLOCK)
		WHERE ((SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
		(StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (Submit = @Submit)) 
		AND (Status = 1 OR Status = 0)
	END
END

BEGIN
	INSERT INTO dbo.pSampleRequestSubmitBOM
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT  @SampleRequestSubmitNewId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, @NewSubmit, 0, StartDate, CONVERT(varchar(10), getdate() + ISNULL(@ResubmitDays,1) , 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM  dbo.pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02971'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02971', GetDate())

END

GO