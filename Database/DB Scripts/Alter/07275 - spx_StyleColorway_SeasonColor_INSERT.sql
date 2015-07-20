IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_INSERT] (  
@ColorPaletteID UNIQUEIDENTIFIER,   
@StyleID UNIQUEIDENTIFIER,  
@StyleSet INT,  
@SeasonYearID UNIQUEIDENTIFIER,  
@AllSizeClasses INT,  
@CUser NVARCHAR(200),   
@CDate DATETIME,  
@ChangeTransID UNIQUEIDENTIFIER,  
@ChangeTransUserID UNIQUEIDENTIFIER,
@ChangeTransPageName  NVARCHAR(200) = null
)  
AS  
  
  
  
DECLARE @StyleColorID UNIQUEIDENTIFIER   
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER  
DECLARE @ColorCode NVARCHAR(200)  
DECLARE @ColorName NVARCHAR(200)  
  
SELECT @StyleColorID = a.StyleColorID, @ColorCode = b.ColorCode, @ColorName = b.ColorName  
FROM pStyleColorway a WITH (NOLOCK)  
 INNER JOIN dbo.pColorPalette  b WITH (NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID  
WHERE a.StyleID = @StyleID    
AND a.ColorPaletteID = @ColorPaletteID   
  
  
SELECT @StyleSeasonYearID = StyleSeasonYearID     
FROM pStyleSeasonYear WITH (NOLOCK)  
WHERE StyleId = @StyleID AND SeasonYearID = @SeasonYearID  
  
DECLARE @Season NVARCHAR(200)  
DECLARE @Year NVARCHAR(200) 
 
 SELECT @Season=a.Season, @Year=a.Year 
 FROM pSeasonYear a, pStyleSeasonYear b
 WHERE b.StyleSeasonYearID=@StyleSeasonYearID 
 and a.SeasonYearID = b.SeasonYearID  
  
  
IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK)  
  WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID = @StyleColorID )   
BEGIN  
  
 DECLARE @ChangeLogID UNIQUEIDENTIFIER  
 DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER  
 SET @StyleColorwaySeasonYearID  = NEWID()  
   
 INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID, StyleSeasonYearID , StyleColorwayID , StyleID,     
  StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus, Units, ColorType )  
 VALUES  ( @StyleColorwaySeasonYearID, @StyleSeasonYearID , @StyleColorID , @StyleID,     
  1, 1, 1, 1, 800, 0, 'F')  
  
  
 --** Insert Log    
 DECLARE @ChangeAfterText NVARCHAR(400)  
 SET @ChangeAfterText = '('+ ISNULL(@ColorCode,'') + ') ' + ISNULL(@ColorName,'')  
   
  DECLARE @Changeseason NVARCHAR(400)  
 SET @Changeseason = 'Colorway Season '+ ISNULL(@Season,'') + ' ' + ISNULL(@Year,'')
   
 EXECUTE spx_ChangeLog_INSERTID  
  @changeTableId = '00000002-c1cc-df11-af06-005056c00008',  
  @changeTransId = @ChangeTransID,  
  @changeTablePKId = @StyleID,  
  @changeUserId = @ChangeTransUserID,   
  @ChangeUserName = @CUser,  
  @changeDate = @CDate,  
  @changeSort = '0000',  
  @ShowResult = 0,  
  @ChangeLogID = @ChangeLogID OUTPUT,
  @ChangeTransPageName = @ChangeTransPageName,
  @ChangeTransTypeID = 1
   
 EXECUTE spx_ChangeLogItem_INSERT  
  @ChangeLogID = @ChangeLogID,  
  @ChangeTransID = @ChangeTransID,  
  @ChangeFieldName = 'StyleColorwaySeasonYearID',  
  @ChangeFieldAlias = @Changeseason,  
  @ChangeBeforeValue = NULL,  
  @ChangeAfterValue = @StyleColorwaySeasonYearID,  
  @ChangeBeforeText = NULL,  
  @ChangeAfterText = @ChangeAfterText,  
  @ChangeSort = '0001'   
  
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07275', GetDate())
GO
