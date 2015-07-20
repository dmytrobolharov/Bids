IF OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorSummaryTemp_SELECT]
(
 @LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

BEGIN

	SELECT cp.ColorPaletteID, cp.ColorFolderID, cp.ColorCode, cp.ColorName, cp.ColorSource, cp.ColorNotes, 
		   cp.Hex, cp.R, cp.G, cp.B, cp.C, cp.M, cp.Y, cp.K, cp.H, cp.S, cp.L, cp.LAB_L, cp.LAB_A, cp.LAB_B, 
		   cp.CUser, cp.CDate, cp.MUser, cp.MDate, cp.ColorID, cp.Change, cp.Action, cp.Active, cp.Sort, 
		   cp.ColorImage, cp.ColorImageType, cp.CopyColorPaletteID, 
		   dbo.fnx_GetStreamingColorImageHTML(cp.ColorFolderID, cp.ColorPaletteID, 20, 'border="0"') AS ColorUrl, 
		   0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 0 AS StyleColorDelivery3, 1 AS StyleColorDelivery4, 
		   0 AS Units, lpmcct.LinePlanColorGroupID, lpmcct.LinePlanColorItemID, lpmcct.LinePlanRangeID, lpmcct.LinePlanID
	FROM pColorPalette cp
	INNER JOIN pLinePlanMultiCloth2ColorTemp lpmcct ON cp.ColorPaletteID = lpmcct.ColorPaletteID
	WHERE lpmcct.LinePlanColorGroupID = @LinePlanColorGroupID 
	ORDER BY cp.ColorCode

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10355', GetUTCDate())
GO
