

/****** Object:  StoredProcedure [dbo].[spx_MaterialCoreColor_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialCoreColor_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialSummaryTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialSummaryTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialSummaryTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECTED]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2QueueTemp_UPDATE]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2QueueTemp_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2QueueTemp_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2BodyTemp_INSERT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2BodyTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2BodyTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2ColorTemp_UPDATE]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2ColorTemp_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorTemp_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2ColorTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2ColorTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiClothColorTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiClothColorTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiClothColorTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECTED]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_INSERT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT]    Script Date: 06/14/2010 11:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialCoreColor_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialCoreColor_SELECT](@MaterialCoreID uniqueidentifier)
AS 

SELECT     pColorPalette.ColorFolderID, pColorPalette.ColorCode, pColorPalette.ColorName, pMaterialCoreColor.MaterialCoreColorID, 
      pMaterialCoreColor.MaterialCoreID, pMaterialCoreColor.ColorPaletteID
FROM         pColorPalette INNER JOIN
      pMaterialCoreColor ON pColorPalette.ColorPaletteID = pMaterialCoreColor.ColorPaletteID
WHERE     (pMaterialCoreColor.MaterialCoreID = @MaterialCoreID)
ORDER BY pMaterialCoreColor.Sort, pColorPalette.ColorCode, pColorPalette.ColorName





GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialSummaryTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialSummaryTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

BEGIN
  

SELECT pLinePlanMultiCloth2MaterialTemp.LinePlanMultiCloth2MaterialTempID, pLinePlanMultiCloth2MaterialTemp.LinePlanColorGroupID, 
      pLinePlanMultiCloth2MaterialTemp.LinePlanMaterialItemID, pLinePlanMultiCloth2MaterialTemp.LinePlanRangeID, pLinePlanMultiCloth2MaterialTemp.LinePlanID, 
      pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.NoColorMatch, 
      pMaterial.SupplierID, pMaterial.MaterialType, pMaterial.MaterialNo, pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, pMaterial.E, 
      pMaterial.F, pMaterial.G, pMaterial.MaterialID, pMaterial.TempID, pMaterial.TempNo, pMaterial.H, pMaterial.I, pMaterial.J, pMaterial.K, pMaterial.L, pMaterial.M, 
      pMaterial.N, pMaterial.O, pMaterial.P, pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, 
      pMaterial.Source, pMaterial.Notes, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, pMaterial.VendorProductionMin, 
      pMaterial.VendorProductionLeadTime, pMaterial.MaterialPlacement, pMaterial.DetailYesNo, pMaterial.ImageType1, pMaterial.height, pMaterial.width, pMaterial.CDate,
       pMaterial.CUser, pMaterial.MDate, pMaterial.MUser, pMaterial.MChange, pMaterial.DChange, pMaterial.Action, pMaterial.Status, pMaterial.Active, 
      pMaterial.MultiDimension, pMaterial.UOM, pMaterial.MaterialCode, pMaterial.MaterialCodeNo,
  CAST(pLinePlanMultiCloth2ColorTemp.ColorPaletteID AS VARCHAR(40)) AS ColorPaletteID, 
  CAST(dbo.pLinePlanMultiCloth2ColorTemp.MaterialCoreColorID AS VARCHAR(40)) AS MaterialCoreColorID,
	dbo.pColorPalette.ColorCode, dbo.pColorPalette.ColorName
INTO #tmpLinePlanMultiCloth2                     
FROM         dbo.pLinePlanMultiCloth2MaterialTemp INNER JOIN
                      dbo.pMaterial ON dbo.pLinePlanMultiCloth2MaterialTemp.MaterialID = dbo.pMaterial.MaterialID INNER JOIN
                      dbo.pLinePlanMultiCloth2ColorTemp ON dbo.pMaterial.MaterialID = dbo.pLinePlanMultiCloth2ColorTemp.MaterialID INNER JOIN
                      dbo.pColorPalette ON dbo.pLinePlanMultiCloth2ColorTemp.ColorPaletteID = dbo.pColorPalette.ColorPaletteID
WHERE  pLinePlanMultiCloth2MaterialTemp.LinePlanColorGroupID = @LinePlanColorGroupID
ORDER BY pMaterial.MaterialNo      

END


EXECUTE spx_Crosstab 
	'SELECT LinePlanMultiCloth2MaterialTempID, LinePlanColorGroupID, 
	LinePlanMaterialItemID, LinePlanRangeID, LinePlanID, 
	MaterialImageID, MaterialImageVersion, MaterialImageDetailID, MaterialImageDetailVersion, NoColorMatch, 
	SupplierID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, 
	F, G, MaterialID, TempID, TempNo, H, I, J, K, L, M, 
	N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
	Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, 
	VendorProductionLeadTime, MaterialPlacement, DetailYesNo, ImageType1, height, width, CDate,
	CUser, MDate, MUser, MChange, DChange, Action, Status, Active, 
	MultiDimension, UOM, MaterialCode, MaterialCodeNo, ColorPaletteID,
	MaterialCoreColorID FROM #tmpLinePlanMultiCloth2',
	NULL,
	NULL,
	'ColorPaletteID',
	'MaterialCoreColorID',
	'MAX'

DROP TABLE #tmpLinePlanMultiCloth2




GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

SELECT pLinePlanMultiCloth2MaterialTemp.LinePlanColorGroupID, pLinePlanMultiCloth2MaterialTemp.LinePlanMaterialItemID, 
      pLinePlanMultiCloth2MaterialTemp.LinePlanID, pMaterial.MaterialID, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 
      pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.MaterialType, pMaterial.MaterialNo, 
      pMaterial.MaterialName, pLinePlanMultiCloth2MaterialTemp.LinePlanMultiCloth2MaterialTempID, 
      pLinePlanMultiCloth2MaterialTemp.LinePlanMultiCloth2Queued
FROM  pMaterial INNER JOIN
      pLinePlanMultiCloth2MaterialTemp ON pMaterial.MaterialID = pLinePlanMultiCloth2MaterialTemp.MaterialID
WHERE pLinePlanMultiCloth2MaterialTemp.LinePlanColorGroupID = @LinePlanColorGroupID     
ORDER BY pMaterial.MaterialNo








GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECTED]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_SELECTED](
@LinePlanColorGroupID UNIQUEIDENTIFIER,
@LinePlanMaterialItemID UNIQUEIDENTIFIER
)
AS

SELECT pLinePlanMultiCloth2MaterialTemp.LinePlanColorGroupID, pLinePlanMultiCloth2MaterialTemp.LinePlanMaterialItemID, 
      pLinePlanMultiCloth2MaterialTemp.LinePlanID, pMaterial.MaterialID, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 
      pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.MaterialType, pMaterial.MaterialNo, 
      pMaterial.MaterialName, pLinePlanMultiCloth2MaterialTemp.LinePlanMultiCloth2MaterialTempID, 
      pLinePlanMultiCloth2MaterialTemp.LinePlanMultiCloth2Queued
FROM  pMaterial INNER JOIN
      pLinePlanMultiCloth2MaterialTemp ON pMaterial.MaterialID = pLinePlanMultiCloth2MaterialTemp.MaterialID
WHERE pLinePlanMultiCloth2MaterialTemp.LinePlanColorGroupID = @LinePlanColorGroupID 
	AND pLinePlanMultiCloth2MaterialTemp.LinePlanMaterialItemID = @LinePlanMaterialItemID    
ORDER BY pMaterial.MaterialNo








GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2QueueTemp_UPDATE]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2QueueTemp_UPDATE](
@LinePlanColorGroupID UNIQUEIDENTIFIER,
@LinePlanMaterialItemID UNIQUEIDENTIFIER,
@LinePlanRangeID UNIQUEIDENTIFIER,
@LinePlanID UNIQUEIDENTIFIER,
@MaterialID UNIQUEIDENTIFIER
)
AS


BEGIN
	UPDATE pLinePlanMultiCloth2MaterialTemp SET LinePlanMultiCloth2Queued = 1
	WHERE LinePlanID = @LinePlanID 
	AND LinePlanMaterialItemID = @LinePlanMaterialItemID
	--AND LinePlanRangeID = @LinePlanRangeID
	AND LinePlanColorGroupID = @LinePlanColorGroupID
	AND MaterialID = @MaterialID 
END


GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

BEGIN

SELECT TOP (1) dbo.pLinePlanMultiCloth2BodyTemp.LinePlanMultiCloth2BodyTempID, dbo.pLinePlanMultiCloth2BodyTemp.LinePlanColorGroupID, 
      dbo.pLinePlanMultiCloth2BodyTemp.LinePlanBodyItemID, dbo.pLinePlanMultiCloth2BodyTemp.LinePlanRangeID, dbo.pLinePlanMultiCloth2BodyTemp.LinePlanID, 
      dbo.pLinePlanMultiCloth2BodyTemp.CUser, dbo.pLinePlanMultiCloth2BodyTemp.CDate, dbo.pLinePlanMultiCloth2BodyTemp.MUser, 
      dbo.pLinePlanMultiCloth2BodyTemp.MDate, dbo.pBody.BodyNo, dbo.pBody.Description
FROM  dbo.pLinePlanBodyItem INNER JOIN
      dbo.pLinePlanMultiCloth2BodyTemp ON dbo.pLinePlanBodyItem.LinePlanBodyItemID = dbo.pLinePlanMultiCloth2BodyTemp.LinePlanBodyItemID INNER JOIN
      dbo.pBody ON dbo.pLinePlanBodyItem.BodyID = dbo.pBody.BodyID
WHERE pLinePlanMultiCloth2BodyTemp.LinePlanColorGroupID = @LinePlanColorGroupID 

END










GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2BodyTemp_INSERT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2BodyTemp_INSERT] (
	@LinePlanRangeID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@BodyItemID UNIQUEIDENTIFIER
)
AS

IF (SELECT COUNT(*) FROM pLinePlanMultiCloth2BodyTemp WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND LinePlanColorGroupID = @LinePlanColorGroupID) = 0

BEGIN
	INSERT INTO pLinePlanMultiCloth2BodyTemp (LinePlanBodyItemID, LinePlanId, LinePlanRangeID, LinePlanColorGroupID)
	VALUES (@BodyItemID, @LinePlanId, @LinePlanRangeID, @LinePlanColorGroupID) 		
END

















GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2ColorTemp_UPDATE]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorTemp_UPDATE](
@MaterialCoreColorID UNIQUEIDENTIFIER,
@LinePlanMultiCloth2ColorTempID UNIQUEIDENTIFIER
)
AS


BEGIN
	UPDATE pLinePlanMultiCloth2ColorTemp SET MaterialCoreColorID = @MaterialCoreColorID
	WHERE LinePlanMultiCloth2ColorTempID = @LinePlanMultiCloth2ColorTempID
END

BEGIN

	DECLARE @tmpLinePlanColorGroupID UNIQUEIDENTIFIER
	SELECT @tmpLinePlanColorGroupID = LinePlanColorGroupID FROM pLinePlanMultiCloth2ColorTemp 
	WHERE MaterialCoreColorID = @MaterialCoreColorID AND LinePlanMultiCloth2ColorTempID = @LinePlanMultiCloth2ColorTempID

	CREATE TABLE #LinePlanMultiCloth2MaterialGroupItemTemp(
		[RecID] int IDENTITY(1,1) NOT NULL,
		[LinePlanColorItemTempID] [uniqueidentifier] NULL,
		[LinePlanColorGroupID] [uniqueidentifier] NULL,
		[MaterialCoreColorItemID] [uniqueidentifier] NULL,
		[MaterialCoreColorID] [uniqueidentifier] NULL,
		[MaterialCoreItemID] [uniqueidentifier] NULL,
		[MaterialCoreID] [uniqueidentifier] NULL,
		[MaterialID] [uniqueidentifier] NOT NULL,
		[MaterialColorID] [uniqueidentifier] NULL,
		[LinePlanMultiCloth2ColorTempID] [uniqueidentifier] NULL)


	INSERT INTO #LinePlanMultiCloth2MaterialGroupItemTemp(LinePlanMultiCloth2ColorTempID, LinePlanColorGroupID, MaterialCoreColorItemID, MaterialCoreColorID, MaterialCoreItemID, MaterialCoreID, MaterialColorId, MaterialId)
	SELECT @LinePlanMultiCloth2ColorTempID, @tmpLinePlanColorGroupID, MaterialCoreColorItemID, MaterialCoreColorID, MaterialCoreItemID, MaterialCoreID, MaterialColorId, MaterialId FROM pMaterialCoreColorItem WHERE MaterialCoreColorID = @MaterialCoreColorID 			

	DECLARE
		@tmpMaterialCoreColorItemID UNIQUEIDENTIFIER, 
		@tmpMaterialCoreColorID UNIQUEIDENTIFIER, 
		@tmpMaterialCoreItemID UNIQUEIDENTIFIER, 
		@tmpMaterialCoreID UNIQUEIDENTIFIER, 
		@tmpMaterialId UNIQUEIDENTIFIER, 
		@tmpMaterialColorID UNIQUEIDENTIFIER


		DECLARE @RowStyleLoop int
		DECLARE @RowStyleCount int

		SET @RowStyleLoop = 1
		SET @RowStyleCount = (SELECT COUNT(*) FROM #LinePlanMultiCloth2MaterialGroupItemTemp)

		WHILE @RowStyleLoop <= @RowStyleCount 

			BEGIN

			SELECT @tmpMaterialCoreColorItemID = MaterialCoreColorItemID, 
					@tmpMaterialCoreColorID = MaterialCoreColorID,
					@tmpMaterialCoreItemID = MaterialCoreItemID, 
					@tmpMaterialCoreID = MaterialCoreID,  
					@tmpMaterialColorId = MaterialColorId, 
					@tmpMaterialId = MaterialId 
			FROM #LinePlanMultiCloth2MaterialGroupItemTemp
			WHERE RecID = @RowStyleLoop	
				
			IF (SELECT COUNT(*) FROM pLinePlanMultiCloth2MaterialGroupItemTemp  
				WHERE MaterialCoreColorID = @MaterialCoreColorID 
				AND LinePlanMultiCloth2ColorTempID = @LinePlanMultiCloth2ColorTempID
				AND MaterialCoreColorItemID = @tmpMaterialCoreColorItemID ) = 0
				BEGIN
					INSERT INTO pLinePlanMultiCloth2MaterialGroupItemTemp(LinePlanMultiCloth2ColorTempID, LinePlanColorGroupID, MaterialCoreColorItemID, MaterialCoreColorID, MaterialCoreItemID, MaterialCoreID, MaterialColorId, MaterialId)
					VALUES (@LinePlanMultiCloth2ColorTempID, @tmpLinePlanColorGroupID, @tmpMaterialCoreColorItemID, @tmpMaterialCoreColorID, @tmpMaterialCoreItemID, @tmpMaterialCoreID, @tmpMaterialColorId, @tmpMaterialId) 			
				END
			ELSE
				BEGIN
					UPDATE pLinePlanMultiCloth2MaterialGroupItemTemp SET MaterialCoreColorID = @tmpMaterialCoreColorID, MaterialColorID = @tmpMaterialColorID, LinePlanColorGroupID = @tmpLinePlanColorGroupID 
					WHERE LinePlanMultiCloth2ColorTempID = @LinePlanMultiCloth2ColorTempID AND MaterialCoreColorItemID = @tmpMaterialCoreColorItemID
				END	

			SET @RowStyleLoop = @RowStyleLoop + 1
				
			END	

		END

		DROP TABLE #LinePlanMultiCloth2MaterialGroupItemTemp

--DELETE FROM pLinePlanMultiCloth2MaterialGroupItemTemp


GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER,
@LinePlanMaterialItemID UNIQUEIDENTIFIER
)
AS

DECLARE @MaterialID UNIQUEIDENTIFIER
SELECT @MaterialID = MaterialID FROM pLinePlanMaterialItem WHERE LinePlanMaterialItemID = @LinePlanMaterialItemID

BEGIN
	SELECT pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID, pColorPalette.ColorCode, pColorPalette.ColorName, pColorPalette.ColorSource, pColorPalette.ColorNotes, 
		  pColorPalette.Hex, pColorPalette.R, pColorPalette.G, pColorPalette.B, pColorPalette.C, pColorPalette.M, pColorPalette.Y, pColorPalette.K, pColorPalette.H, 
		  pColorPalette.S, pColorPalette.L, pColorPalette.LAB_L, pColorPalette.LAB_A, pColorPalette.LAB_B, pColorPalette.CUser, pColorPalette.CDate, pColorPalette.MUser, 
		  pColorPalette.MDate, pColorPalette.ColorID, pColorPalette.Change, pColorPalette.Action, pColorPalette.Active, pColorPalette.Sort, pColorPalette.ColorImage, 
		  pColorPalette.ColorImageType, pColorPalette.CopyColorPaletteID, 
		  '<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(pColorPalette.ColorFolderID AS NVARCHAR(50)) 
		  + '&CPID=' + CAST(pColorPalette.ColorPaletteID AS NVARCHAR(50)) + '" border="0" />' AS ColorUrl, 0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 
		  0 AS StyleColorDelivery3, 1 AS StyleColorDelivery4, 0 AS Units, pLinePlanMultiCloth2ColorTemp.LinePlanColorGroupID, pLinePlanMultiCloth2ColorTemp.MaterialCoreColorID, 
		  pLinePlanMultiCloth2ColorTemp.LinePlanColorItemID, pLinePlanMultiCloth2ColorTemp.LinePlanRangeID, pLinePlanMultiCloth2ColorTemp.LinePlanID, 
		  pLinePlanMultiCloth2ColorTemp.LinePlanMultiCloth2ColorTempID
	FROM  pColorPalette INNER JOIN
		  pLinePlanMultiCloth2ColorTemp ON pColorPalette.ColorPaletteID = pLinePlanMultiCloth2ColorTemp.ColorPaletteID
	WHERE pLinePlanMultiCloth2ColorTemp.LinePlanColorGroupID = @LinePlanColorGroupID 
			AND pLinePlanMultiCloth2ColorTemp.MaterialID = @MaterialID
			AND pLinePlanMultiCloth2ColorTemp.MaterialCoreColorID <> '00000000-0000-0000-0000-000000000000'	
ORDER BY pColorPalette.ColorCode
END








GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2ColorTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER,
@LinePlanMaterialItemID UNIQUEIDENTIFIER
)
AS

DECLARE @MaterialID UNIQUEIDENTIFIER
SELECT @MaterialID = MaterialID FROM pLinePlanMaterialItem WHERE LinePlanMaterialItemID = @LinePlanMaterialItemID

BEGIN
	SELECT pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID, pColorPalette.ColorCode, pColorPalette.ColorName, pColorPalette.ColorSource, pColorPalette.ColorNotes, 
		  pColorPalette.Hex, pColorPalette.R, pColorPalette.G, pColorPalette.B, pColorPalette.C, pColorPalette.M, pColorPalette.Y, pColorPalette.K, pColorPalette.H, 
		  pColorPalette.S, pColorPalette.L, pColorPalette.LAB_L, pColorPalette.LAB_A, pColorPalette.LAB_B, pColorPalette.CUser, pColorPalette.CDate, pColorPalette.MUser, 
		  pColorPalette.MDate, pColorPalette.ColorID, pColorPalette.Change, pColorPalette.Action, pColorPalette.Active, pColorPalette.Sort, pColorPalette.ColorImage, 
		  pColorPalette.ColorImageType, pColorPalette.CopyColorPaletteID, 
		  '<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(pColorPalette.ColorFolderID AS NVARCHAR(50)) 
		  + '&CPID=' + CAST(pColorPalette.ColorPaletteID AS NVARCHAR(50)) + '" border="0" />' AS ColorUrl, 0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 
		  0 AS StyleColorDelivery3, 1 AS StyleColorDelivery4, 0 AS Units, pLinePlanMultiCloth2ColorTemp.LinePlanColorGroupID, pLinePlanMultiCloth2ColorTemp.MaterialCoreColorID, 
		  pLinePlanMultiCloth2ColorTemp.LinePlanColorItemID, pLinePlanMultiCloth2ColorTemp.LinePlanRangeID, pLinePlanMultiCloth2ColorTemp.LinePlanID, 
		  pLinePlanMultiCloth2ColorTemp.LinePlanMultiCloth2ColorTempID
	FROM  pColorPalette INNER JOIN
		  pLinePlanMultiCloth2ColorTemp ON pColorPalette.ColorPaletteID = pLinePlanMultiCloth2ColorTemp.ColorPaletteID
	WHERE pLinePlanMultiCloth2ColorTemp.LinePlanColorGroupID = @LinePlanColorGroupID 
			AND pLinePlanMultiCloth2ColorTemp.MaterialID = @MaterialID
ORDER BY pColorPalette.ColorCode
END








GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID, pColorPalette.ColorCode, pColorPalette.ColorName, pColorPalette.ColorSource, pColorPalette.ColorNotes, 
		  pColorPalette.Hex, pColorPalette.R, pColorPalette.G, pColorPalette.B, pColorPalette.C, pColorPalette.M, pColorPalette.Y, pColorPalette.K, pColorPalette.H, 
		  pColorPalette.S, pColorPalette.L, pColorPalette.LAB_L, pColorPalette.LAB_A, pColorPalette.LAB_B, pColorPalette.CUser, pColorPalette.CDate, pColorPalette.MUser, 
		  pColorPalette.MDate, pColorPalette.ColorID, pColorPalette.Change, pColorPalette.Action, pColorPalette.Active, pColorPalette.Sort, pColorPalette.ColorImage, 
		  pColorPalette.ColorImageType, pColorPalette.CopyColorPaletteID, 
		  '<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(pColorPalette.ColorFolderID AS NVARCHAR(50)) 
		  + '&CPID=' + CAST(pColorPalette.ColorPaletteID AS NVARCHAR(50)) + '" border="0" />' AS ColorUrl, 0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 
		  0 AS StyleColorDelivery3, 1 AS StyleColorDelivery4, 0 AS Units, pLinePlanMultiCloth2ColorTemp.LinePlanColorGroupID,
		  pLinePlanMultiCloth2ColorTemp.LinePlanColorItemID, pLinePlanMultiCloth2ColorTemp.LinePlanRangeID, pLinePlanMultiCloth2ColorTemp.LinePlanID
	FROM  pColorPalette INNER JOIN
		  pLinePlanMultiCloth2ColorTemp ON pColorPalette.ColorPaletteID = pLinePlanMultiCloth2ColorTemp.ColorPaletteID
	WHERE pLinePlanMultiCloth2ColorTemp.LinePlanColorGroupID = @LinePlanColorGroupID 
ORDER BY pColorPalette.ColorCode
END








GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiClothColorTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LinePlanMultiClothColorTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

SELECT pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID, pColorPalette.ColorCode, pColorPalette.ColorName, pColorPalette.ColorSource, pColorPalette.ColorNotes, 
      pColorPalette.Hex, pColorPalette.R, pColorPalette.G, pColorPalette.B, pColorPalette.C, pColorPalette.M, pColorPalette.Y, pColorPalette.K, pColorPalette.H, 
      pColorPalette.S, pColorPalette.L, pColorPalette.LAB_L, pColorPalette.LAB_A, pColorPalette.LAB_B, pColorPalette.CUser, pColorPalette.CDate, pColorPalette.MUser, 
      pColorPalette.MDate, pColorPalette.ColorID, pColorPalette.Change, pColorPalette.Action, pColorPalette.Active, pColorPalette.Sort, pColorPalette.ColorImage, 
      pColorPalette.ColorImageType, pColorPalette.CopyColorPaletteID, pLinePlanColorItemTemp.LinePlanID, pLinePlanColorItemTemp.LinePlanColorItemID, 
      pLinePlanColorItemTemp.LinePlanColorID, pLinePlanColorItemTemp.LinePlanRangeID, pLinePlanColorItemTemp.LinePlanColorGroupID,
		'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(pColorPalette.ColorFolderID AS NVARCHAR(50)) -- #01
		+ '&CPID=' + CAST(pColorPalette.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" />'     -- #01
		AS ColorUrl,	-- #01
	  0 AS StyleColorDelivery1,
	  0 AS StyleColorDelivery2,
	  0 AS StyleColorDelivery3,
	  1 AS StyleColorDelivery4,
	  0 as Units

FROM  pColorPalette INNER JOIN
      pLinePlanColorItemTemp ON pColorPalette.ColorPaletteID = pLinePlanColorItemTemp.ColorPaletteID
WHERE pLinePlanColorItemTemp.LinePlanColorGroupID = @LinePlanColorGroupID
ORDER BY pColorPalette.ColorName





GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECTED]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECTED](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

BEGIN

SELECT TOP 1 pLinePlanMultiCloth2MaterialGroupTemp.LinePlanMultiCloth2MaterialGroupID, pLinePlanMultiCloth2MaterialGroupTemp.LinePlanColorGroupID, 
	pLinePlanMultiCloth2MaterialGroupTemp.LinePlanMaterialGroupID, pLinePlanMultiCloth2MaterialGroupTemp.LinePlanRangeID, 
	pLinePlanMultiCloth2MaterialGroupTemp.LinePlanID, pLinePlanMultiCloth2MaterialGroupTemp.CUser, pLinePlanMultiCloth2MaterialGroupTemp.CDate, 
	pLinePlanMultiCloth2MaterialGroupTemp.MUser, pLinePlanMultiCloth2MaterialGroupTemp.MDate, pMaterialCore.MaterialCoreID, pMaterialCore.MaterialCoreName, 
	pMaterialCore.MaterialCoreDescription
FROM pLinePlanMultiCloth2MaterialGroupTemp INNER JOIN
	pMaterialCore ON pLinePlanMultiCloth2MaterialGroupTemp.LinePlanMaterialGroupID = pMaterialCore.MaterialCoreID
WHERE pLinePlanMultiCloth2MaterialGroupTemp.LinePlanColorGroupID = @LinePlanColorGroupID 

END










GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_SELECT] (
	@LinePlanRangeID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@MaterialGroupID UNIQUEIDENTIFIER
)
AS

SELECT pLinePlanMultiCloth2MaterialGroupTemp.LinePlanMultiCloth2MaterialGroupID, pLinePlanMultiCloth2MaterialGroupTemp.LinePlanColorGroupID, 
      pLinePlanMultiCloth2MaterialGroupTemp.LinePlanMaterialGroupID, pLinePlanMultiCloth2MaterialGroupTemp.LinePlanRangeID, 
      pLinePlanMultiCloth2MaterialGroupTemp.LinePlanID, pLinePlanMultiCloth2MaterialGroupTemp.CUser, pLinePlanMultiCloth2MaterialGroupTemp.CDate, 
      pLinePlanMultiCloth2MaterialGroupTemp.MUser, pLinePlanMultiCloth2MaterialGroupTemp.MDate, pMaterialCore.MaterialCoreName, 
      pMaterialCore.MaterialCoreDescription
FROM  pLinePlanMultiCloth2MaterialGroupTemp INNER JOIN
      pMaterialCore ON pLinePlanMultiCloth2MaterialGroupTemp.LinePlanMaterialGroupID = pMaterialCore.MaterialCoreID
	WHERE pLinePlanMultiCloth2MaterialGroupTemp.LinePlanRangeID = @LinePlanRangeID 
	AND pLinePlanMultiCloth2MaterialGroupTemp.LinePlanID = @LinePlanID 
	AND pLinePlanMultiCloth2MaterialGroupTemp.LinePlanColorGroupID = @LinePlanColorGroupID


GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_INSERT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_INSERT] (
	@LinePlanRangeID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@MaterialGroupID UNIQUEIDENTIFIER
)
AS

IF (SELECT COUNT(*) FROM pLinePlanMultiCloth2MaterialGroupTemp WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND LinePlanColorGroupID = @LinePlanColorGroupID) = 0

BEGIN
	INSERT INTO pLinePlanMultiCloth2MaterialGroupTemp (LinePlanMaterialGroupID, LinePlanId, LinePlanRangeID, LinePlanColorGroupID)
	VALUES (@MaterialGroupID, @LinePlanId, @LinePlanRangeID, @LinePlanColorGroupID) 		
END

















GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT]    Script Date: 06/14/2010 11:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT] (
	@LinePlanRangeID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER 
)
AS

IF (SELECT COUNT(*) FROM pLinePlanMultiCloth2MaterialTemp WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND MaterialID = @MaterialID AND LinePlanColorGroupID = @LinePlanColorGroupID) = 0

BEGIN
	INSERT INTO pLinePlanMultiCloth2MaterialTemp (LinePlanMaterialItemID, LinePlanId, LinePlanRangeID, MaterialID, LinePlanColorGroupID)
	SELECT LinePlanMaterialItemID, LinePlanId, LinePlanRangeID, MaterialID, @LinePlanColorGroupID FROM pLinePlanMaterialItem
	WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND MaterialID = @MaterialID 		
END

--This logic will apply only if you need color to load from main material color as style colorways
BEGIN
	--Select SeasonYearID from pLinePlan table
	DECLARE @LineSeason varchar(100)
	DECLARE @LineYear int
	DECLARE @LineSeasonYearID uniqueidentifier

	SELECT @LineSeason = [Season], @LineYear = [YEAR] FROM pLinePlan WHERE LinePlanID = @LinePlanID
	SELECT @LineSeasonYearID = SeasonYearID FROM pSeasonYear WHERE [Year] = @LineYear AND [Season] = @LineSeason 

	----Select Material Color ID's
	--DECLARE @SeasonYearID uniqueidentifier
	--DECLARE @ColorPaletteID uniqueidentifier
	--DECLARE @MaterialColorID uniqueidentifier
	--DECLARE @ColorCode varchar(50)
	--DECLARE @ColorName varchar(200)

	--Insert Material values to pLinePlanMultiCloth2
	INSERT INTO pLinePlanMultiCloth2ColorTemp (LinePlanColorGroupID, LinePlanRangeID, LinePlanID, MaterialColorID, MaterialID, ColorPaletteID)
	SELECT @LinePlanColorGroupID, @LinePlanRangeID, @LinePlanID, pMaterialColorSeasonYear.MaterialColorID, pMaterialColor.MaterialID, pMaterialColor.ColorPaletteID
	FROM  pMaterialColor INNER JOIN
	  pMaterialColorSeasonYear ON pMaterialColor.MaterialColorID = pMaterialColorSeasonYear.MaterialColorID
	 WHERE SeasonYearID = @LineSeasonYearID AND pMaterialColor.MaterialID = @MaterialId

END
















GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '159', GetDate())
GO