IF OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialColorTemp_SELECT]
(
 @LinePlanColorGroupID UNIQUEIDENTIFIER,
 @LinePlanMaterialItemID UNIQUEIDENTIFIER
)
AS

	DECLARE @MaterialID UNIQUEIDENTIFIER

BEGIN

	SELECT @MaterialID = MaterialID 
	FROM dbo.pLinePlanMaterialItem 
	WHERE LinePlanMaterialItemID = @LinePlanMaterialItemID

	SELECT cp.ColorPaletteID, cp.ColorFolderID, cp.ColorCode, cp.ColorName, cp.ColorSource, cp.ColorNotes, 
		   cp.Hex, cp.R, cp.G, cp.B, cp.C, cp.M, cp.Y, cp.K, cp.H, cp.S, cp.L, cp.LAB_L, cp.LAB_A, cp.LAB_B, 
		   cp.CUser, cp.CDate, cp.MUser, cp.MDate, cp.ColorID, cp.Change, cp.Action, cp.Active, cp.Sort, 
		   cp.ColorImage, cp.ColorImageType, cp.CopyColorPaletteID, 
		   dbo.fnx_GetStreamingColorImageHTML(cp.ColorFolderID, cp.ColorPaletteID, 20, 'border="0"') AS ColorUrl, 
		   0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 0 AS StyleColorDelivery3, 1 AS StyleColorDelivery4, 
		   0 AS Units, lpmcct.LinePlanColorGroupID, lpmcct.MaterialCoreColorID, lpmcct.LinePlanColorItemID, 
		   lpmcct.LinePlanRangeID, lpmcct.LinePlanID, lpmcct.LinePlanMultiCloth2ColorTempID
	FROM dbo.pColorPalette cp
	INNER JOIN dbo.pLinePlanMultiCloth2ColorTemp lpmcct ON cp.ColorPaletteID = lpmcct.ColorPaletteID
	WHERE lpmcct.LinePlanColorGroupID = @LinePlanColorGroupID AND lpmcct.MaterialID = @MaterialID AND 
		  lpmcct.MaterialCoreColorID <> '00000000-0000-0000-0000-000000000000'	
	ORDER BY cp.ColorCode

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10357', GetUTCDate())
GO
