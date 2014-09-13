-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]    Script Date: 12/18/2011 18:27:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]    Script Date: 12/18/2011 18:27:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestMaterialBOMTemp_INSERT]
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
	FROM         dbo.pStyleMaterials WITH (NOLOCK)
	WHERE     (StyleMaterialID = @StyleMaterialID)
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02392'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02392', GetDate())

END

GO