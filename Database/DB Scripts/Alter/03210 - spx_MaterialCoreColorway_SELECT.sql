-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 March 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  StoredProcedure [dbo].[spx_MaterialCoreColorway_SELECT]    Script Date: 03/08/2012 16:44:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialCoreColorway_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialCoreColorway_SELECT]    Script Date: 03/08/2012 16:44:11 ******/
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreColorway_SELECT] (
	@MaterialCoreID UNIQUEIDENTIFIER
)
AS 

--Daniel Pak
--2/7/2010

--DECLARE @MaterialCoreID uniqueidentifier
--SET @MaterialCoreID = '5a3acd8c-b66a-4bf9-80fa-0294628f270e'

BEGIN

--Create temp table for available colors
CREATE TABLE #tmpMaterialCoreColor( 
	RecID						int IDENTITY(1,1)  NOT NULL,
	MaterialCoreColorID 	 	uniqueidentifier,
	MaterialCoreID 				uniqueidentifier
) ON [PRIMARY]

--Create temp table for available materials
CREATE TABLE #tmpMaterialCoreItem( 
	RecID						int IDENTITY(1,1)  NOT NULL,
	MaterialCoreItemID 	 	    uniqueidentifier,
	MaterialID 	 				uniqueidentifier,
	MaterialCoreID 				uniqueidentifier
) ON [PRIMARY]


DECLARE @RowMaterialCoreLoop 			int
DECLARE @RowMaterialCoreCount 			int
DECLARE @tmpMaterialCoreColorID			uniqueidentifier

DECLARE @RowMaterialCoreItemLoop 		int
DECLARE @RowMaterialCoreItemCount 		int
DECLARE @tmpMaterialCoreItemID			uniqueidentifier
DECLARE @tmpMaterialID					uniqueidentifier

BEGIN
--Populate colors 
	INSERT INTO #tmpMaterialCoreColor (MaterialCoreColorID, MaterialCoreID)
	SELECT MaterialCoreColorID, MaterialCoreID FROM pMaterialCoreColor WITH (NOLOCK)
	WHERE MaterialCoreId = @MaterialCoreId 
END

BEGIN
--Populate materials
	INSERT INTO #tmpMaterialCoreItem (MaterialCoreItemID, MaterialCoreID, MaterialID)
	SELECT MaterialCoreItemID, MaterialCoreID, MaterialID FROM pMaterialCoreItem WITH (NOLOCK)
	WHERE MaterialCoreId = @MaterialCoreId 
END

SET @RowMaterialCoreLoop = 1
SET @RowMaterialCoreCount = (SELECT COUNT(*) FROM #tmpMaterialCoreColor)
--Loop available colors
WHILE @RowMaterialCoreLoop <= @RowMaterialCoreCount 

	BEGIN
		SELECT @tmpMaterialCoreColorID = MaterialCoreColorID FROM #tmpMaterialCoreColor WHERE RecID = @RowMaterialCoreLoop

			BEGIN	

					SET @RowMaterialCoreItemLoop = 1
					SET @RowMaterialCoreItemCount = (SELECT COUNT(*) FROM #tmpMaterialCoreItem)
					--Loop available materials
					WHILE @RowMaterialCoreItemLoop <= @RowMaterialCoreItemCount 
						BEGIN

							SELECT @tmpMaterialCoreItemID = MaterialCoreItemID, @tmpMaterialID = MaterialID FROM #tmpMaterialCoreItem WHERE RecID = @RowMaterialCoreItemLoop
								BEGIN	

									--Check if color is available on pMaterialCoreColorItem for PIVOT function
									IF (SELECT COUNT(*) FROM pMaterialCoreColorItem WHERE MaterialCoreItemID = @tmpMaterialCoreItemID AND MaterialID = @tmpMaterialID AND MaterialCoreColorID = @tmpMaterialCoreColorID) = 0
									BEGIN
										--If not found create a blank insert.
										--INSERT INTO pMaterialCoreColorItem (MaterialCoreColorID, MaterialCoreItemID, MaterialCoreID, MaterialColorId, MaterialId)
										--SELECT @tmpMaterialCoreColorID, @tmpMaterialCoreItemID, @MaterialCoreID, '00000000-0000-0000-0000-000000000000', @tmpMaterialId 

										INSERT INTO pMaterialCoreColorItem (MaterialCoreColorID, MaterialCoreItemID, MaterialCoreID, MaterialColorId, MaterialId)
										SELECT @tmpMaterialCoreColorID, @tmpMaterialCoreItemID, @MaterialCoreID, NULL, @tmpMaterialId 										


									END
								END	

							SET @RowMaterialCoreItemLoop = @RowMaterialCoreItemLoop + 1

						END

			END	

		SET @RowMaterialCoreLoop = @RowMaterialCoreLoop + 1

	END

	DROP TABLE #tmpMaterialCoreItem
	DROP TABLE #tmpMaterialCoreColor

END

--BEGIN
----Update MaterialColorId NULL with '00000000-0000-0000-0000-000000000000'
----This will avoid error on color dropdownlist with null values
--	UPDATE pMaterialCoreColorItem SET MaterialColorID = '00000000-0000-0000-0000-000000000000' WHERE (MaterialColorID IS NULL) AND (MaterialCoreID = @MaterialCoreID)
--END


IF  @RowMaterialCoreCount = 0
	BEGIN
		SELECT 0 AS MainMaterial, pMaterial.MaterialID, pMaterial.TempID, pMaterial.TempNo, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 
			  pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, pMaterial.MaterialType, 
			  pMaterial.MaterialNo, pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, pMaterial.E, pMaterial.F, 
			  pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, 
			  pMaterial.P, pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, pMaterial.W, pMaterial.X, 
			  pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, pMaterial.VendorPrice, pMaterial.VolumePrice, 
			  pMaterial.VolumePriceMinimum, pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.MaterialPlacement, 
			  pMaterial.DetailYesNo, pMaterial.ImageType1, pMaterial.height, pMaterial.width, pMaterial.MChange, pMaterial.DChange, 
			  pMaterial.Action, pMaterial.Status, pMaterial.Active, pMaterial.MultiDimension, pMaterial.MaterialCode, pMaterial.MaterialCodeNo, 
			  pMaterial.SAPCode, pMaterial.SAPControl, pMaterial.MaterialColorRequired, pMaterial.FactorySourced, pMaterial.TradePartnerID, 
			  pMaterial.TradePartnerVendorID, pMaterialCoreItem.MaterialCoreID, pMaterialCoreItem.MaterialCoreItemID, pComponentType.ComponentTypeID, 
			  pComponentType.ComponentDescription, pComponentType.ComponentType, pComponentType.ComponentOrder, (SELECT TOP 1 UOM FROM UOM WHERE UOMValue=pMaterial.UOM) AS UOM, 
			  pMaterialCoreItem.Qty, pMaterialCoreItem.MaterialPrice, pMaterialCoreItem.Ext, pMaterialCoreItem.MaterialSize, pMaterialCoreItem.Placement, 
			  pMaterialCoreItem.Artwork, pMaterialCoreItem.License, pMaterialCoreItem.Colorway, pMaterialCoreItem.CUser, pMaterialCoreItem.CDate, 
			  pMaterialCoreItem.MUser, pMaterialCoreItem.MDate, 
			  '<img src="../System/Control/ImageStream.ashx?S=50&V=' + CAST(pMaterial.MaterialImageVersion AS NVARCHAR(5)) 
			  + '&IID=' + CAST(pMaterial.MaterialImageID AS NVARCHAR(40)) + '" />' AS ImagePath
		FROM  pMaterial INNER JOIN
			  pMaterialCoreItem ON pMaterial.MaterialID = pMaterialCoreItem.MaterialID INNER JOIN
			  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID
		WHERE pMaterialCoreItem.MaterialCoreID = @MaterialCoreID

	END
ELSE
	BEGIN 
	--Create a temp table with all available color to pivot the table
		SELECT 0 AS MainMaterial,  pMaterial.MaterialID, pMaterial.TempID, pMaterial.TempNo, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 
		  pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, pMaterial.MaterialType, 
		  pMaterial.MaterialNo, pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, pMaterial.E, pMaterial.F, 
		  pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, 
		  pMaterial.P, pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, pMaterial.W, pMaterial.X, 
		  pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, pMaterial.VendorPrice, pMaterial.VolumePrice, 
		  pMaterial.VolumePriceMinimum, pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.MaterialPlacement, 
		  pMaterial.DetailYesNo, pMaterial.ImageType1, pMaterial.height, pMaterial.width, pMaterial.MChange, pMaterial.DChange, 
		  pMaterial.Action, pMaterial.Status, pMaterial.Active, pMaterial.MultiDimension, pMaterial.MaterialCode, pMaterial.MaterialCodeNo, 
		  pMaterial.SAPCode, pMaterial.SAPControl, pMaterial.MaterialColorRequired, pMaterial.FactorySourced, pMaterial.TradePartnerID, 
		  pMaterial.TradePartnerVendorID, pMaterialCoreItem.MaterialCoreID, pMaterialCoreItem.MaterialCoreItemID, pMaterialCoreColor.MaterialCoreColorID, pMaterialCoreColor.ColorPaletteID, 
		  pMaterialCoreColor.ColorCode, pMaterialCoreColor.ColorName, pMaterialCoreColor.Sort, pMaterialCoreColorItem.MaterialColorID, 
		  pComponentType.ComponentTypeID, pComponentType.ComponentDescription, pComponentType.ComponentType, 
		  pComponentType.ComponentOrder, (SELECT TOP 1 UOM FROM UOM WHERE UOMValue=pMaterial.UOM) AS UOM, pMaterialCoreItem.Qty, pMaterialCoreItem.MaterialPrice, pMaterialCoreItem.Ext, 
		  pMaterialCoreItem.MaterialSize, pMaterialCoreItem.Placement, pMaterialCoreItem.Artwork, pMaterialCoreItem.License, 
		  pMaterialCoreItem.Colorway, pMaterialCoreItem.CUser, pMaterialCoreItem.CDate, pMaterialCoreItem.MUser, pMaterialCoreItem.MDate, pMaterialCoreColorItem.MaterialCoreColorItemID,

		'<img src="../System/Control/ImageStream.ashx?S=50&V='  +  CAST(pMaterial.MaterialImageVersion  AS NVARCHAR(5))+  
		'&IID=' + CAST ( pMaterial.MaterialImageID AS NVARCHAR(40)) + '" />'
		as ImagePath 
		INTO #MaterialCore
		FROM pMaterial INNER JOIN
		  pMaterialCoreItem ON pMaterial.MaterialID = pMaterialCoreItem.MaterialID INNER JOIN
		  pMaterialCoreColor ON pMaterialCoreItem.MaterialCoreID = pMaterialCoreColor.MaterialCoreID INNER JOIN
		  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID LEFT OUTER JOIN
		  pMaterialCoreColorItem ON pMaterialCoreColor.MaterialCoreColorID = pMaterialCoreColorItem.MaterialCoreColorID AND 
		  pMaterialCoreItem.MaterialCoreItemID = pMaterialCoreColorItem.MaterialCoreItemID
		WHERE pMaterialCoreItem.MaterialCoreID = @MaterialCoreID
		ORDER BY pMaterial.MaterialType, pMaterial.MaterialNo

		--Finally we got it pivoting the table.
		EXECUTE spx_Crosstab 'SELECT MainMaterial,  
		ComponentOrder, MaterialCoreItemID, MaterialCoreID, Placement, 
		MaterialNo, MaterialCode, MaterialName, MaterialType, 
		MaterialID, UOM, Qty, MaterialPrice, ImagePath,
		Ext, MaterialSize, MaterialPlacement, 
		MaterialImageID, 
		MaterialImageVersion, ComponentTypeID, 
		A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, 
		V, W, X, Y, Z, 
		CDate, CUser, MDate, MUser, 
		Artwork, License, Colorway, '''' AS GroupName,
		ComponentDescription, LTRIM(RTRIM(MaterialColorID)) AS MaterialColorID , MaterialCoreColorID
		FROM #MaterialCore',
		NULL,
		NULL,
		'MaterialCoreColorID',
		'MaterialColorID',
		'MAX'

		DROP TABLE #MaterialCore

	END 
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03210'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03210', GetDate())

END
GO
