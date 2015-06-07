IF OBJECT_ID(N'[dbo].[spx_LinePlanMultiClothColorTemp_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanMultiClothColorTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiClothColorTemp_SELECT]
(
 @LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS
BEGIN

	SELECT cp.ColorPaletteID, cp.ColorFolderID, cp.ColorCode, cp.ColorName, cp.ColorSource, cp.ColorNotes, 
		   cp.Hex, cp.R, cp.G, cp.B, cp.C, cp.M, cp.Y, cp.K, cp.H, cp.S, cp.L, cp.LAB_L, cp.LAB_A, cp.LAB_B, 
		   cp.CUser, cp.CDate, cp.MUser, cp.MDate, cp.ColorID, cp.Change, cp.Action, cp.Active, cp.Sort, 
		   cp.ColorImage, cp.ColorImageType, cp.CopyColorPaletteID, lpcit.LinePlanID, lpcit.LinePlanColorItemID, 
		   lpcit.LinePlanColorID, lpcit.LinePlanRangeID, lpcit.LinePlanColorGroupID,
		   dbo.fnx_GetStreamingColorImageHTML(cp.ColorFolderID, cp.ColorPaletteID, 20, 'border="0"') AS ColorUrl,
		   0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 0 AS StyleColorDelivery3, 1 AS StyleColorDelivery4,
	       0 AS Units
	FROM dbo.pColorPalette cp 
	INNER JOIN dbo.pLinePlanColorItemTemp lpcit ON cp.ColorPaletteID = lpcit.ColorPaletteID
	WHERE lpcit.LinePlanColorGroupID = @LinePlanColorGroupID
	ORDER BY cp.ColorName

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10358', GetUTCDate())
GO
