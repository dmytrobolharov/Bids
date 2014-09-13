IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColor_DELETE]') AND type in (N'P', N'PC'))
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
 @ColorPaletteID UNIQUEIDENTIFIER = NULL,
 @ChangeTransPageName VARCHAR(200) = NULL
)    
AS    

DECLARE @ColorCode NVARCHAR(200)  
DECLARE @ColorName NVARCHAR(200) 

    --For fetch StyleColorID
SELECT @StyleColorID = a.StyleColorID, @ColorCode = b.ColorCode, @ColorName = b.ColorName  
FROM pStyleColorway a WITH (NOLOCK)  
 INNER JOIN dbo.pColorPalette  b WITH (NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID  
WHERE a.StyleID = @StyleID    
AND a.ColorPaletteID = @ColorPaletteID   
    --
    
  
  
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER    
    
SELECT @StyleSeasonYearID = StyleSeasonYearID     
FROM pStyleSeasonYear WITH(NOLOCK)  
WHERE StyleId = @StyleID   
 AND SeasonYearID = @SeasonYearID    
   
    
DECLARE @Season NVARCHAR(200)  
DECLARE @Year NVARCHAR(200) 
 
 SELECT @Season=a.Season, @Year=a.Year 
 FROM pSeasonYear a, pStyleSeasonYear b
 WHERE b.StyleSeasonYearID=@StyleSeasonYearID 
 and a.SeasonYearID = b.SeasonYearID
  

    
    
   IF EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK)  
  WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID = @StyleColorID )   
BEGIN

DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER 

SELECT  @StyleColorwaySeasonYearID=a.StyleColorwaySeasonYearID    
 FROM pStyleColorwaySeasonYear a  WITH(NOLOCK)  
 WHERE a.StyleSeasonYearID = @StyleSeasonYearID    
  AND a.StyleColorwayID = @StyleColorID
  
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
    
    
    --** Insert Log    
 DECLARE @ChangeAfterText NVARCHAR(400)  
 SET @ChangeAfterText = '('+ ISNULL(@ColorCode,'') + ') ' + ISNULL(@ColorName,'')  
   DECLARE @ChangeLogID UNIQUEIDENTIFIER
   
    DECLARE @Changeseason NVARCHAR(400)  
 SET @Changeseason = 'Colorway Season '+ ISNULL(@Season,'') + ' ' + ISNULL(@Year,'')
   
 EXECUTE spx_ChangeLog_INSERTID  
  @changeTableId = '00000002-c1cc-df11-af06-005056c00008',  
  @changeTransId = @ChangeTransID,  
  @changeTablePKId = @StyleID,  
  @changeUserId = @ChangeTransUserID,   
  @ChangeUserName = @MUser,  
  @changeDate = @MDate,  
  @changeSort = '0000',  
  @ShowResult = 0,  
  @ChangeLogID = @ChangeLogID OUTPUT,
  @ChangeTransPageName = @ChangeTransPageName,
  @ChangeTransTypeID = 2
   
 EXECUTE spx_ChangeLogItem_INSERT  
  @ChangeLogID = @ChangeLogID,  
  @ChangeTransID = @ChangeTransID,  
  @ChangeFieldName = 'StyleColorwaySeasonYearID',  
  @ChangeFieldAlias = @Changeseason,  
  @ChangeBeforeValue = @StyleColorwaySeasonYearID,  
  @ChangeAfterValue = NULL,  
  @ChangeBeforeText = @ChangeAfterText,  
  @ChangeAfterText = NULL,  
  @ChangeSort = '0001'   
  
   END 
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
--IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH(NOLOCK) WHERE StyleColorwayID = @StyleColorID )   
-- DELETE FROM pStyleColorway WHERE StyleColorID = @StyleColorID     
    


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07276', GetDate())
GO
