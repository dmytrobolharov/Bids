IF OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2ColorInUseSummaryTemp_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorInUseSummaryTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorInUseSummaryTemp_SELECT]
(
 @LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS
BEGIN

  SELECT DISTINCT b.ColorPaletteID, b.ColorFolderID ,  b.ColorCode, b.ColorName, 
         dbo.fnx_GetStreamingColorImageHTML(b.ColorFolderID, b.ColorPaletteID, 20, 'border="0"') AS ColorUrl	
  FROM dbo.pLinePlanMultiCloth2ColorTemp a
  INNER JOIN  dbo.pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
  WHERE a.LinePlanColorGroupID = @LinePlanColorGroupID AND 
        a.MaterialCoreColorID IS NOT NULL AND 
        a.MaterialCoreColorID  <> '00000000-0000-0000-0000-000000000000'
  ORDER BY b.ColorCode

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10354', GetUTCDate())
GO
