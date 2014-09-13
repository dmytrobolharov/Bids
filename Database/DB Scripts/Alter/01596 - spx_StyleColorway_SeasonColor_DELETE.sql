IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColor_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_DELETE](  
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@SeasonYearID UNIQUEIDENTIFIER,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@StyleColorID UNIQUEIDENTIFIER = NULL, 
	@ColorPaletteID UNIQUEIDENTIFIER = NULL
)  
AS  
  

DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER  
  
SELECT @StyleSeasonYearID = StyleSeasonYearID   
FROM pStyleSeasonYear WITH(NOLOCK)
WHERE StyleId = @StyleID 
	AND SeasonYearID = @SeasonYearID  
 
  

--** DELETE Colorway / SeasonYear   
DELETE FROM pStyleColorwaySeasonYear   
WHERE StyleColorwaySeasonYearID IN (   
	SELECT  a.StyleColorwaySeasonYearID  
	FROM pStyleColorwaySeasonYear a  WITH(NOLOCK)
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID  
		AND a.StyleColorwayID = @StyleColorID
)  
 
  

--**DELETE SourcingItems  
DELETE FROM pStyleSourcingItem  
WHERE StyleSourcingItemID IN (   
	SELECT  b.StyleSourcingItemID   
	FROM pStyleSourcing a  WITH(NOLOCK)
		INNER JOIN pStyleSourcingItem  b WITH(NOLOCK) ON a.StyleSourcingID =  b.StyleSourcingID   
	WHERE a.StyleSeasonYearID = @StyleSeasonYearID  
		AND b.StyleColorID = @StyleColorID
)  
  

--** DELETE QuoteItems   
DELETE FROM pStyleQuoteItem  
WHERE StyleQuoteItemID IN (   
	SELECT a.StyleQuoteItemID  
	FROM pStyleQuoteItem a  WITH(NOLOCK)
		INNER JOIN pStyleSourcing c WITH(NOLOCK) ON a.StyleSourcingID = c.StyleSourcingID   
	WHERE c.StyleSeasonYearID = @StyleSeasonYearID  
		AND a.StyleColorID = @StyleColorID
)  
  
  
/*  
DECLARE @StyleColorID UNIQUEIDENTIFIER  
DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER  
  
SELECT  @StyleColorID = StyleColorID, @StyleColorwaySeasonYearID = a.StyleColorwaySeasonYearID  
FROM pStyleColorwaySeasonYear a  
INNER JOIN pStyleSeasonYear b ON a.StyleSeasonyearID = b.StyleSeasonYearID   
INNER JOIN pStyleColorway c ON c.StyleColorID =  a.StyleColorwayID  
WHERE b.StyleID =  @StyleID  
AND ColorPaletteID =  @ColorPaletteID  
AND SeasonYearID  = @SeasonYearID  
  
  
DELETE FROM pStyleColorwaySeasonYear   
WHERE StyleColorwaySeasonYearID  = @StyleColorwaySeasonYearID   
*/  
  
  
  
  
--***  
--** Check if the colorway is being used in a different SeasonYear   
--***  
IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH(NOLOCK) WHERE StyleColorwayID = @StyleColorID ) 
	DELETE FROM pStyleColorway WHERE StyleColorID = @StyleColorID   
  
  

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01596'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01596', GetDate())
END	

GO










