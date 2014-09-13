
/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]    Script Date: 03/17/2010 01:27:59 ******/


--
-- Comments:
--
--  #01 - Ryan Cabanas - October 29, 2009
--	  Modified the select to show not only the color name, but also the
--        color code.
--


ALTER PROCEDURE spx_StyleColorway_SeasonColorAvaliable_SELECT(
@StyleID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER
)
AS

/*
SELECT b.ColorPaletteID
	,b.ColorCode
	,b.ColorName + ' (' + b.ColorCode + ')' AS ColorName		--Comment #01
FROM pStyleColorway a
INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
WHERE a.StyleID = @StyleID
AND StyleColorID NOT IN (
	SELECT StyleColorwayID 
	FROM pStyleColorwaySeasonYear a
	INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID
	WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID
)
*/
/**
** Colorways avaliable for a NON LinePlan style always going to be EMPTY !!! 
**/

SELECT ColorPaletteID, ColorCode, ColorName		
FROM pColorPalette WHERE 1 = 2 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '024', GetDate())

GO



