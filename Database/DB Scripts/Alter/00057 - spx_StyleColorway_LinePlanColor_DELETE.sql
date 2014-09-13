
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_LinePlanColor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_DELETE](
@ColorPaletteID UNIQUEIDENTIFIER, 
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SeasonYearID UNIQUEIDENTIFIER
)
AS


DECLARE @StyleColorID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER

SELECT @StyleSeasonYearID = StyleSeasonYearID   
FROM pStyleSeasonYear
WHERE StyleId = @StyleID AND SeasonYearID = @SeasonYearID


SELECT @StyleColorID = StyleColorID 
FROM pStyleColorway 
WHERE StyleID = @StyleID  
AND ColorPaletteID = @ColorPaletteID 


--***
--** DELETE Colorway / SeasonYear 
--***
DELETE FROM pStyleColorwaySeasonYear 
WHERE StyleColorwaySeasonYearID IN ( 
	SELECT  a.StyleColorwaySeasonYearID
	FROM pStyleColorwaySeasonYear a
	INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID 
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID
	AND b.ColorPaletteID = @ColorPaletteID
)

--***
--**DELETE SourcingItems
--***
DELETE FROM pStyleSourcingItem
WHERE StyleSourcingItemID IN ( 
	SELECT  b.StyleSourcingItemID 
	FROM pStyleSourcing a
	INNER JOIN pStyleSourcingItem  b ON a.StyleSourcingID =  b.StyleSourcingID 
	INNER JOIN pStyleColorway c ON c.StyleColorID  =  b.StyleColorID 
	WHERE StyleSeasonYearID = @StyleSeasonYearID
	AND c.ColorPaletteID = @ColorPaletteID
)

--***
--** DELETE QuoteItems 
--***
DELETE FROM pStyleQuoteItem
WHERE StyleQuoteItemID IN ( 
	SELECT a.StyleQuoteItemID
	FROM pStyleQuoteItem a
	INNER JOIN pStyleSourcing c ON a.StyleSourcingID = c.StyleSourcingID 
	INNER JOIN pStyleColorway d ON d.StyleColorID = a.StyleColorID 
	WHERE c.StyleSeasonYearID = @StyleSeasonYearID
	AND d.ColorPaletteID = @ColorPaletteID
)


--***
--** Check if the colorway is being used in a different SeasonYear 
--***
IF ( SELECT COUNT(*) FROM pStyleColorwaySeasonYear WHERE StyleColorwayID = @StyleColorID ) = 0
BEGIN
	DELETE FROM pStyleColorway WHERE StyleColorID = @StyleColorID 
END 





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '057', GetDate())

GO