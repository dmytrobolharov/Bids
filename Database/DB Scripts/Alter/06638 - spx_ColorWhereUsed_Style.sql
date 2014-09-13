IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorWhereUsed_Style]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorWhereUsed_Style]
GO

CREATE PROCEDURE [dbo].[spx_ColorWhereUsed_Style] (@ColorPaletteID UNIQUEIDENTIFIER)
AS 

SELECT scsy.StyleColorwaySeasonYearID, cp.ColorPaletteID,  cp.ColorCode as StyleColorNo, cp.ColorName as StyleColorName, 
		sh.StyleID, sh.StyleSet, sh.StyleNo, sh.DevelopmentNo, sh.[Description] as StyleDescription, 
		sh.DesignSketchID, sh.DesignSketchVersion, ssy.StyleSeason, ssy.StyleYear
FROM pStyleColorwaySeasonYear scsy
LEFT JOIN pStyleColorway sc ON scsy.StyleColorwayID = sc.StyleColorID
INNER JOIN pStyleSeasonYear ssy ON scsy.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
INNER JOIN pStyleHeader sh ON ssy.StyleID = sh.StyleID
INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID OR scsy.ColorPaletteID = cp.ColorPaletteID
WHERE cp.ColorPaletteID = @ColorPaletteID
ORDER BY sh.StyleNo, ssy.StyleSeason, ssy.StyleYear


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06638', GetDate())
GO
