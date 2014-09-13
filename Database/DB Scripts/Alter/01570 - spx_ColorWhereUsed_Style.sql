IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorWhereUsed_Style]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorWhereUsed_Style]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_ColorWhereUsed_Style](@ColorPaletteID uniqueidentifier)
AS 

SELECT  pStyleColorwaySeasonYear.StyleColorwaySeasonYearID, pColorPalette.ColorPaletteID,  pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, 
		pStyleHeader.StyleID, pStyleHeader.StyleSet, pStyleHeader.StyleNo, pStyleHeader.DevelopmentNo, pStyleHeader.[Description] as StyleDescription, 
		pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, pStyleSeasonYear.StyleSeason, pStyleSeasonYear.StyleYear
FROM    pColorPalette INNER JOIN
        pStyleColorway ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID INNER JOIN
        pStyleHeader ON pStyleColorway.StyleID = pStyleHeader.StyleID INNER JOIN
        pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN
        pStyleColorwaySeasonYear ON pStyleColorway.StyleID = pStyleColorwaySeasonYear.StyleID AND 
        pStyleSeasonYear.StyleSeasonYearID = pStyleColorwaySeasonYear.StyleSeasonYearID AND 
        pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID INNER JOIN
        pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
where pColorPalette.ColorPaletteID=@ColorPaletteID 
order by pStyleHeader.StyleNo, pStyleSeasonYear.StyleSeason, pStyleSeasonYear.StyleYear
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01570', GetDate())
GO