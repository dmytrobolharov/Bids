IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_LinePlanColor_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_INSERT] (
@ColorPaletteID UNIQUEIDENTIFIER, 
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SeasonYearID UNIQUEIDENTIFIER,
@AllSizeClasses INT,
@CUser NVARCHAR(200), 
@CDate DATETIME,
@ChangeTransID UNIQUEIDENTIFIER,
@ChangeTransUserID UNIQUEIDENTIFIER
)
AS

DECLARE @ChangeAfterText NVARCHAR(400)

DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER


DECLARE @StyleColorID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER
DECLARE @ColorCode NVARCHAR(200)
DECLARE @ColorName NVARCHAR(200)

SELECT @ColorCode = ColorCode, @ColorName = ColorName FROM pColorPalette WITH (NOLOCK)  WHERE ColorPaletteID =@ColorPaletteID

SELECT TOP 1 @StyleColorID = a.StyleColorID 
FROM pStyleColorway a WITH (NOLOCK)
	INNER JOIN pColorPalette b WITH (NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
WHERE StyleID = @StyleID  
	AND b.ColorName = @ColorName 
	AND b.ColorCode = @ColorCode


IF @StyleColorID IS NULL 
BEGIN

	-- INSERT NEW RECORD
	EXEC dbo.spx_StyleColorwayFromColor_INSERT 
		@StyleID = @StyleID,	
		@StyleSet = @StyleSet,
		@ColorPaletteID = @ColorPaletteID,	
		@CUser = @CUser, 
		@CDate = @CDate,
		@AllSizeClasses = @AllSizeClasses, 
		@SeasonYearID = @SeasonYearID,
		@ChangeTransID = @ChangeTransID,
		@ChangeTransUserID = @ChangeTransUserID

	SELECT TOP 1 @StyleColorID = a.StyleColorID 
	FROM pStyleColorway a WITH (NOLOCK)
		INNER JOIN pColorPalette b WITH (NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID  
		AND b.ColorName = @ColorName 
		AND b.ColorCode = @ColorCode	


END

SELECT @StyleSeasonYearID = StyleSeasonYearID   
FROM pStyleSeasonYear WITH (NOLOCK) 
WHERE StyleId = @StyleID AND SeasonYearID = @SeasonYearID

IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK)
	WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID = @StyleColorID) 
BEGIN

	INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID, StyleSeasonYearID , StyleColorwayID , StyleID,   
		StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, 
		StyleColorStatus, SampleStatus, Units, ColorType )
	VALUES  ( NEWID(), @StyleSeasonYearID , @StyleColorID , @StyleID,   
		0, 0, 0, 1, 100, 100, 0, 'F')


	SET @ChangeLogID = NEWID()
	SET @StyleColorwaySeasonYearID = NEWID() 


	IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
	BEGIN 

		--** Log event 
		SET @ChangeAfterText = '('+ ISNULL(@ColorCode,'') + ') ' + ISNULL(@ColorName,'')

		EXECUTE spx_ChangeLog_INSERTID
		@changeTableId = '00000002-c1cc-df11-af06-005056c00008',
		@changeTransId = @ChangeTransID,
		@changeTablePKId = @StyleColorwaySeasonYearID,
		@changeUserId = @ChangeTransUserID, 
		@ChangeUserName = @CUser,
		@changeDate = @CDate,
		@changeSort = '0000',
		@ShowResult = 0,
		@ChangeLogID = @ChangeLogID OUTPUT

		EXECUTE spx_ChangeLogItem_INSERT
		@ChangeLogID = @ChangeLogID,
		@ChangeTransID = @ChangeTransID,
		@ChangeFieldName = 'StyleColorwasySeasonYearID',
		@ChangeFieldAlias = 'StyleColorwasySeasonYearID',
		@ChangeBeforeValue = NULL,
		@ChangeAfterValue = @StyleColorwaySeasonYearID,
		@ChangeBeforeText = NULL,
		@ChangeAfterText = @ChangeAfterText,
		@ChangeSort = '0001'

	END

	--** Add Logic INSERT 		
	EXEC spx_StyleColorway_Logic_INSERT @StyleSeasonYearID = @StyleSeasonYearID, @StyleColorID = @StyleColorID, 
		@CUser= @CUser, @CDate = @CDate		
END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '692', GetDate())
GO
