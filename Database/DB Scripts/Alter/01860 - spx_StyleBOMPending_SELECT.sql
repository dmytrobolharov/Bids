IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMPending_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMPending_SELECT]    Script Date: 09/06/2011 11:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_StyleBOMPending_SELECT]
(
@StyleId uniqueidentifier,
@StyleSet int,
@WorkflowItemId uniqueidentifier,
@WorkflowId uniqueidentifier,
@StyleBOMDimensionID uniqueidentifier
)
AS

SELECT pStyleBOMTemp.StyleMaterialID, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
      pStyleBOMTemp.MainMaterial, pStyleBOMTemp.Development, pStyleBOMTemp.MiscColor, pStyleBOMTemp.StyleSet, pStyleBOMTemp.StyleID, 
      pStyleBOMTemp.StyleBOMDimensionID, pStyleBOMTemp.WorkflowItemId, pStyleBOMTemp.WorkflowId,
      pStyleBOMTemp.UOM, pStyleBOMTemp.Qty, pStyleBOMTemp.MaterialPrice, pStyleBOMTemp.Ext, pStyleBOMTemp.MaterialSize, 
      pStyleBOMTemp.MaterialID, pStyleBOMTemp.MaterialPlacement, pStyleBOMTemp.MaterialPlacementCode, pStyleBOMTemp.MaterialPlacementDetail, 
      pStyleBOMTemp.MaterialImageID, pStyleBOMTemp.MaterialImageVersion, pStyleBOMTemp.NoColorMatch, pStyleBOMTemp.SupplierID, 
      pStyleBOMTemp.ComponentTypeID, pStyleBOMTemp.MaterialType, pStyleBOMTemp.MaterialNo, pStyleBOMTemp.MaterialName, pStyleBOMTemp.A, 
      pStyleBOMTemp.B, pStyleBOMTemp.C, pStyleBOMTemp.D, pStyleBOMTemp.E, pStyleBOMTemp.F, pStyleBOMTemp.G, pStyleBOMTemp.H, 
      pStyleBOMTemp.I, pStyleBOMTemp.J, pStyleBOMTemp.K, pStyleBOMTemp.L, pStyleBOMTemp.M, pStyleBOMTemp.N, pStyleBOMTemp.O, 
      pStyleBOMTemp.P, pStyleBOMTemp.Q, pStyleBOMTemp.R, pStyleBOMTemp.S, pStyleBOMTemp.T, pStyleBOMTemp.U, pStyleBOMTemp.V, 
      pStyleBOMTemp.W, pStyleBOMTemp.X, pStyleBOMTemp.Y, pStyleBOMTemp.Z, pStyleBOMTemp.Source, pStyleBOMTemp.Notes, 
      pStyleBOMTemp.Placement, pStyleBOMTemp.VendorPrice, pStyleBOMTemp.VolumePrice, pStyleBOMTemp.VolumePriceMinimum, 
      pStyleBOMTemp.VendorProductionMin, pStyleBOMTemp.VendorProductionLeadTime, pStyleBOMTemp.DetailYesNo, pStyleBOMTemp.ImageType, 
      pStyleBOMTemp.height, pStyleBOMTemp.width, pStyleBOMTemp.CDate, pStyleBOMTemp.CUser, pStyleBOMTemp.MDate, 
      pStyleBOMTemp.MUser, pStyleBOMTemp.MChange, pStyleBOMTemp.SChange, pStyleBOMTemp.DChange, pStyleBOMTemp.CChange, 
      pStyleBOMTemp.Action, pStyleBOMTemp.ColorPlacement, pStyleBOMTemp.Artwork, pStyleBOMTemp.License, pStyleBOMTemp.Colorway, 
      pStyleBOMTemp.MaterialTrack, pStyleBOMTemp.MaterialLinked, pStyleBOMTemp.MaterialDimension, 
      pStyleBOMTemp.MaterialLining, MaterialSizeID, pStyleBOMTemp.MaterialPackLabelGroupID, pStyleBOMTemp.TradePartnerID, 
      pStyleBOMTemp.TradePartnerVendorID, pStyleBOMTemp.MaterialBOM,  
      pComponentType.ComponentOrder, '' AS GroupName, 0 AS MaterialDel ,

	  '<table width="100%" ><tr><td align="center"><img src=''../System/Control/ImageStream.ashx?S=50&V=' + CAST(ISNULL(pStyleBOMTemp.MaterialImageVersion, 0) 
      AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOMTemp.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
      + ''' /></td></tr></table>' AS MaterialImage

FROM  pStyleBOMTemp INNER JOIN
      pComponentType ON pStyleBOMTemp.MaterialType = pComponentType.ComponentTypeID
WHERE pStyleBOMTemp.StyleId = @StyleId AND pStyleBOMTemp.StyleSet = @StyleSet
AND pStyleBOMTemp.WorkflowItemId = @WorkflowItemId AND pStyleBOMTemp.WorkflowId = @WorkflowId
ORDER BY pStyleBOMTemp.MainMaterial DESC, pComponentType.ComponentOrder

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01860'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01860', GetDate())
END

GO