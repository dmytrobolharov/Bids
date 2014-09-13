IF EXISTS (select * from sysobjects where id = object_id('spx_StyleSizeClassNew_Logic_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleSizeClassNew_Logic_UPDATE
GO


CREATE PROCEDURE [dbo].[spx_StyleSizeClassNew_Logic_UPDATE] (
@StyleID UNIQUEIDENTIFIER,
@StyleCopyFromID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS 



--***
--** Burberry Logic, Define PLMCode 
--***
UPDATE pStyleColorway 
SET PLMCode = ISNULL(pStyleHeader.StyleNo,'')  + ISNULL(pColorPalette.ColorCode,''),
MDate = @CDate, MUser = @CUser 
FROM pStyleColorway 
INNER JOIN pStyleHeader ON pStyleColorway.StyleID = pStyleHeader.StyleID	
INNER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID 
WHERE pStyleHeader.StyleID = @StyleID


GO