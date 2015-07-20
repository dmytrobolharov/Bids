IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_Color_INSERT_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_Color_INSERT_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleColorway_Color_INSERT_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200),
	@ColorName NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER = NULL OUT,
	@StyleColorID UNIQUEIDENTIFIER = NULL OUT,
	@CUser NVARCHAR(200) = 'System',
	@CDate DATETIME = NULL,
	@NewSeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER
	DECLARE @StyleColorwaySeasonYearID2 UNIQUEIDENTIFIER

	DECLARE @ChangeAfterText NVARCHAR(400)
	DECLARE @ChangeLogID UNIQUEIDENTIFIER
	DECLARE @ChangeLogID2 UNIQUEIDENTIFIER

	SET @ChangeAfterText = '('+ ISNULL(@ColorCode,'') + ') ' + ISNULL(@ColorName,'')

	IF @CDate IS NULL
		SET @CDate = CURRENT_TIMESTAMP

	--**
	--** Check if a Colorway with the same color Name/Code exists already 
	--**
	SELECT TOP 1 @StyleColorID = a.StyleColorID
	FROM pStyleColorway a WITH(NOLOCK) 
		INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID 
	AND b.ColorCode = @ColorCode
	AND b.ColorName = @ColorName

	/**
	** Define PLMCode
	**/
	DECLARE @PLMCode NVARCHAR (200) 
	DECLARE @StyleNo NVARCHAR(20)
	SELECT @PLMCode= StyleNo + @ColorCode, @StyleNo = StyleNo 
	FROM pStyleHeader WITH(NOLOCK) WHERE StyleID = @StyleID 


	IF @StyleColorID IS NULL
	BEGIN 
		SET @StyleColorID = NEWID()
		INSERT INTO pStyleColorway ( StyleColorID, StyleID, StyleSet, StylecolorStandardID , ColorPaletteID , StyleColorNo, StyleColorName,  MainColor,
					CUser, CDate, MUser, MDate , PLMCode) 
		VALUES ( @StyleColorID,  @StyleID, 1, NULL , @ColorPaletteID , @ColorCode, @ColorName,  @ColorName ,
					@CUser, @CDate, @CUser, @CDate , @PLMCode  ) 
	END

	/**
	** ALWAYS, need a SeasonYearID 
	** This for intra/season styles
	*/
	IF @SeasonYearID  IS NULL
	BEGIN
		SELECT TOP 1 @SeasonYearID = SeasonYearID  FROM pStyleSeasonYear
		WHERE StyleID = @StyleID 
	END 


	BEGIN
		DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
		DECLARE @LinePlanItemID  UNIQUEIDENTIFIER 
		DECLARE @ColorStatus INT 
		DECLARE @StyleColorwayDelivery INT 

		SELECT @StyleSeasonYearID = StyleSeasonYearID, @LinePlanItemID  = LinePlanItemID 
		FROM pStyleSeasonYear WITH(NOLOCK) 
		WHERE StyleID = @StyleID AND SeasonYearID =  @NewSeasonYearID 

		IF @LinePlanItemID IS NULL 
		BEGIN
			SET @ColorStatus = 800
			SET @StyleColorwayDelivery = 1
		END 
		ELSE 
		BEGIN
			SET @ColorStatus = 100
			SET @StyleColorwayDelivery = 0
		END 

		IF @StyleSeasonYearID IS NULL
		BEGIN
			SET @StyleSeasonYearID = NEWID() 
			
				EXEC spx_StyleSeasonYearTrans_INSERT @StyleID = @StyleID, @SeasonYearID = @SeasonYearID, 
				@CUser = @CUser, @CDate = @CDate, @ChangeTransID = NULL, 
				@ChangeTransUserID = NULL, @ChangeTransPageName = NULL, @Sort = NULL
		END 


		IF NOT EXISTS (SELECT * FROM pStyleColorwaySeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID =  @StyleColorID ) 
		BEGIN
			
			SET @StyleColorwaySeasonYearID = NEWID()
		
			INSERT INTO  pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID , StyleSeasonYearID , StyleColorwayID , StyleID ,  
			StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4,StyleColorDelivery5, 
			StyleColorStatus, Units, SampleStatus, MUser, MDate )
			VALUES ( @StyleColorwaySeasonYearID, @StyleSeasonYearID , @StyleColorID , @StyleID ,  
			1, 1, 1, 1, 0, 
			@ColorStatus , 0 , @ColorStatus, @CUser, @CDate ) 
			
			--** --Comment #01
			--** Add Logic INSERT 		
			EXEC spx_StyleColorway_Logic_INSERT @StyleSeasonYearID = @StyleSeasonYearID, @StyleColorID = @StyleColorID, 
			@CUser= @CUser, @CDate = @CDate

		END 
			
	END
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09949', GetUTCDate())
GO