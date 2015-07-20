IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColorSelected_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColorSelected_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

#01 - Ryan Cabanas - October 29, 2009
	Modified the select to show not only the color name, but also the
color code.
*/


CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColorSelected_SELECT](
@StyleID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER
)
AS


SELECT d.ColorPaletteID
	,d.ColorCode
	,d.ColorName + ' (' + d.ColorCode + ')' AS ColorName		--Comment #01
	,c.PLMCode
FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID
INNER JOIN pStyleColorway c ON c.StyleColorID  =  a.StyleColorwayID 
INNER JOIN pColorPalette d ON d.ColorPaletteID = c.ColorPaletteID 
WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID
ORDER BY PLMCode

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04018', GetDate())
GO
