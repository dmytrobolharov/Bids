IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorWhereUsed_Style]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorWhereUsed_Style]
GO


CREATE PROCEDURE [dbo].[spx_ColorWhereUsed_Style] (@ColorPaletteID UNIQUEIDENTIFIER)
AS 

SELECT scsy.StyleColorwaySeasonYearID, cp.ColorPaletteID,  cp.ColorCode as StyleColorNo, cp.ColorName as StyleColorName, 
		sh.StyleID, sh.StyleSet, sh.StyleNo, sh.DevelopmentNo, sh.[Description] as StyleDescription, 
		sh.DesignSketchID, sh.DesignSketchVersion, ssy.StyleSeason, ssy.StyleYear
FROM pStyleColorwaySeasonYear scsy
	INNER JOIN pStyleColorway sc ON scsy.StyleColorwayID = sc.StyleColorID
	INNER JOIN pStyleSeasonYear ssy ON scsy.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
	INNER JOIN pStyleHeader sh ON ssy.StyleID = sh.StyleID
	INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
WHERE cp.ColorPaletteID = @ColorPaletteID

UNION
/* check is color used in BOM but not added to Seasonal Colorway */
SELECT NULL as StyleColorwaySeasonYearID, cp.ColorPaletteID,  cp.ColorCode as StyleColorNo, cp.ColorName as StyleColorName, 
		sh.StyleID, sh.StyleSet, sh.StyleNo, sh.DevelopmentNo, sh.[Description] as StyleDescription, 
		sh.DesignSketchID, sh.DesignSketchVersion, ssy.StyleSeason, ssy.StyleYear
FROM pStyleBOMDimensionItem sdi
	INNER JOIN pWorkFlowItem wi ON sdi.WorkFlowItemID = wi.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
	INNER JOIN pStyleHeader sh ON ssy.StyleID = sh.StyleID
	INNER JOIN pStyleColorway sc ON (sdi.ItemDim1Id = sc.StyleColorID) OR (sdi.ItemDim2Id = sc.StyleColorID) OR (sdi.ItemDim3Id = sc.StyleColorID)
	INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
WHERE cp.ColorPaletteID = @ColorPaletteID 
 AND cp.ColorPaletteID NOT IN (
  SELECT a.ColorPaletteID 
  FROM pStyleColorway a 
	INNER JOIN pStyleColorwaySeasonYear b ON a.StyleColorID = b.StyleColorwayID
  WHERE a.StyleID = sdi.StyleID AND wi.StyleSeasonYearID = b.StyleSeasonYearID
 )

ORDER BY StyleNo, StyleSeason, StyleYear

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07304', GetDate())
GO
