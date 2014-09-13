IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSizeClassNew_Colorways_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSizeClassNew_Colorways_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleSizeClassNew_Colorways_DELETE](
@StyleID UNIQUEIDENTIFIER, 
@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS 

DECLARE @ColorPaletteID UNIQUEIDENTIFIER
DECLARE @StyleColorID UNIQUEIDENTIFIER

SELECT @ColorPaletteID = b.ColorPaletteID
FROM pStyleColorwaySeasonYear a 
INNER JOIN pStyleColorway b ON a.StyleColorwayID  = b.StyleColorID
WHERE a.StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID

IF @ColorPaletteID IS NOT NULL 
BEGIN 

	SELECT @StyleColorID = a.StyleColorID 
	FROM pStyleColorway a 
	WHERE a.StyleID = @StyleID 
	AND a.ColorPaletteID = @ColorPaletteID 
	
	IF @StyleColorID IS NOT NULL
	BEGIN
		DELETE FROM pStyleColorwayItem WHERE StyleColorID = @StyleColorID 
		--DELETE FROM pStyleColorway WHERE StyleColorID = @StyleColorID 
		DELETE FROM pStyleColorwaySeasonYear WHERE StyleColorwayID = @StyleColorID 
	END 
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07286', GetDate())
GO
