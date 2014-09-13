/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleColorwayLogic_INSERT]    Script Date: 03/01/2012 14:40:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleColorwayLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanStyleColorwayLogic_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleColorwayLogic_INSERT]    Script Date: 03/01/2012 14:40:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanStyleColorwayLogic_INSERT] (
@ColorPaletteID UNIQUEIDENTIFIER ,
@StyleSeasonYearID UNIQUEIDENTIFIER ,
@Params NVARCHAR(4000),
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS

DECLARE @SQL NVARCHAR(4000)
DECLARE @StyleID UNIQUEIDENTIFIER 
DECLARE @ColorCode NVARCHAR(200)
DECLARE @ColorName NVARCHAR(200)
DECLARE @StyleColorwayID UNIQUEIDENTIFIER 

SELECT @StyleID = StyleID FROM pStyleSeasonYear  WHERE StyleSeasonyearID = @StyleSeasonYearID
SELECT @ColorCode = a.ColorCode, @ColorName  = a.ColorName  FROM pColorPalette a WHERE ColorPaletteID = @ColorPaletteID 



SELECT TOP 1 @StyleColorwayID = StyleColorID
FROM pStyleColorway a
INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
WHERE StyleID = @StyleID 
AND b.ColorCode = @ColorCode 
AND b.ColorName = @ColorName 

IF @StyleColorwayID IS NULL 
BEGIN
	SET @StyleColorwayID = NEWID()

	INSERT INTO  pStyleColorway  (StyleColorID, StyleID , StyleSet, StyleColorNo, StyleColorname, Maincolor,  
	Version, CDate,CUser, MDate, MUser, ColorPaletteID )
	VALUES (@StyleColorwayID, @StyleID , 1, @ColorCode, @ColorName, @ColorName,  
	1, @CDate,@CUser, @CDate, @CUser, @ColorPaletteID )

END 

SELECT * FROM pStyleColorwaySeasonYear
DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER 
SET @StyleColorwaySeasonYearID = NEWID()

INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID , StyleSeasonYearID , StyleColorwayID , StyleID )
VALUES ( @StyleColorwaySeasonYearID, @StyleSeasonYearID , @StyleColorwayID , @StyleID )


SET @SQL = 'UPDATE pStyleColorwaySeasonYear SET ' + @Params + ' WHERE StyleColorwaySeasonYearID = ''' 
+ CAST(@StyleColorwaySeasonYearID AS NVARCHAR(40)) + ''' '

EXEC (@SQL)

DECLARE @StyleColorDelivery1 INT
DECLARE @StyleColorDelivery2 INT
DECLARE @StyleColorDelivery3 INT
DECLARE @StyleColorDelivery4 INT

SELECT @StyleColorDelivery1=StyleColorDelivery1, @StyleColorDelivery2=StyleColorDelivery2, 
@StyleColorDelivery3=StyleColorDelivery3
FROM pStyleColorwaySeasonYear WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID

IF @StyleColorDelivery1 = 1 
	SELECT @StyleColorDelivery2 = 1, @StyleColorDelivery3 = 1 
ELSE IF  @StyleColorDelivery2 = 1
	SET @StyleColorDelivery3 = 1 

IF @StyleColorDelivery1 = 1 OR @StyleColorDelivery2 = 1 OR @StyleColorDelivery3 = 1 
	SET @StyleColorDelivery4 = 0 
ELSE
	SET @StyleColorDelivery1 = 1 

UPDATE pStyleColorwaySeasonYear 
SET StyleColorDelivery1 = @StyleColorDelivery1, StyleColorDelivery2 = @StyleColorDelivery2,
StyleColorDelivery3 = @StyleColorDelivery3 , StyleColorDelivery4 = @StyleColorDelivery4,
StyleColorStatus = 100 , SampleStatus = 100
WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID

EXEC spx_LinePlanStyleSourcingQuote_INSERT @StyleID, @StyleColorwayID, @CUser, @CDate
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03160'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03160', GetDate())

END
GO