IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPalette_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPalette_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorPalette_DELETE]
(@ColorPaletteId  uniqueidentifier
)
AS 

DECLARE @Msg NVARCHAR(4000)
SET @Msg  = ''
-- Making the Where Used check consistent -- this select is similar to one that used in spx_ColorWhereUsed_Style
IF (SELECT COUNT(*) FROM pColorPalette INNER JOIN
        pStyleColorway ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID INNER JOIN
        pStyleHeader ON pStyleColorway.StyleID = pStyleHeader.StyleID INNER JOIN
        pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN
        pStyleColorwaySeasonYear ON pStyleColorway.StyleID = pStyleColorwaySeasonYear.StyleID AND 
        pStyleSeasonYear.StyleSeasonYearID = pStyleColorwaySeasonYear.StyleSeasonYearID AND 
        pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID INNER JOIN
        pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
	WHERE pColorPalette.ColorPaletteID=@ColorPaletteID ) > 0
	SET @Msg = 'Color is in use as a Style' 
ELSE IF ( SELECT COUNT(*) FROM pMaterialColor WHERE ColorPaletteID  = @ColorPaletteId) > 0
	SET @Msg = 'Color is in use in a Material' 
ELSE IF ( SELECT COUNT(*) FROM pLinePlanColor WHERE ColorPaletteID  = @ColorPaletteId) > 0	
	SET @Msg = 'Color is in use in a LinePlan' 

IF LEN(@Msg) = 0
BEGIN 

	DELETE FROM ColorLibrary WHERE ColorPaletteID  = @ColorPaletteId
	DELETE FROM pColorPalette WHERE ColorPaletteID  = @ColorPaletteId

END 


SELECT @Msg as Msg

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03827', GetDate())
GO
