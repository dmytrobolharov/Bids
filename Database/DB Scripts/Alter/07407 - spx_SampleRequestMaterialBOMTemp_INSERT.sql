IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]
(@SampleWorkflowID nvarchar(50),
@Submit nvarchar(10),
@StyleSet nvarchar(10),
@WorkflowID nvarchar(50),
@UserDate datetime ,
@UserName nvarchar(50),
@SampleRequestMaterialID nvarchar(50),
@Stylematerialid uniqueidentifier,
@SampleRequestWorkflowID nvarchar(50),
@ItemDim1Id  nvarchar(50) = null,
@ItemDim2Id  nvarchar(50) = null,
@ItemDim3Id  nvarchar(50) = null,
@SampleRequestGroupID nvarchar(50))
AS 


IF (SELECT COUNT(*)  FROM dbo.pSampleRequestMaterialBOMTemp WITH (NOLOCK)
	WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND WorkflowID = @WorkflowID 
	AND SampleRequestGroupID = @SampleRequestGroupID
	AND Stylematerialid = @Stylematerialid
	AND StyleSet = @StyleSet
	AND Submit = @Submit) = 0

BEGIN
	INSERT INTO dbo.pSampleRequestMaterialBOMTemp
                      (SampleWorkflowID, SampleRequestGroupID, Submit, Status, WorkflowID, SampleRequestMaterialID, SampleRequestWorkflowID,ItemDim1Id,ItemDim2Id,ItemDim3Id, CDate, CUser, MDate, MUser, 
                      StyleMaterialID, MainMaterial, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialPlacement, 
                      MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, 
                      MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,  Source, Notes, Placement, VendorPrice, VolumePrice, 
                      VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, Artwork, License, Colorway)
	SELECT     @SampleWorkflowID, @SampleRequestGroupID, @Submit, 0, @WorkflowID, @SampleRequestMaterialID, @SampleRequestWorkflowID,  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @UserDate, @UserName, 
                      @UserDate, @UserName, StyleMaterialID, MainMaterial, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, 
                      MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
                      ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, 
                      VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, Artwork, License, 
                      Colorway
	FROM         dbo.pStyleBOM WITH (NOLOCK)
	WHERE     (StyleMaterialID = @StyleMaterialID)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07407', GetDate())
GO
