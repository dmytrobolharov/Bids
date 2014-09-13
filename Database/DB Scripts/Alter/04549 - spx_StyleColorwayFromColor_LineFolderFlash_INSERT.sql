/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayFromColor_LineFolderFlash_INSERT]    Script Date: 12/05/2012 12:22:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayFromColor_LineFolderFlash_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayFromColor_LineFolderFlash_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayFromColor_LineFolderFlash_INSERT]    Script Date: 12/05/2012 12:22:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleColorwayFromColor_LineFolderFlash_INSERT]  (
	@LineFolderItemID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER, 
	@CUser  NVARCHAR (200), 
	@CDate DATETIME
)
AS 

DECLARE @LineFolderID UNIQUEIDENTIFIER
DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleColorwaySeasonYearID2 UNIQUEIDENTIFIER
DECLARE @StyleColorID UNIQUEIDENTIFIER  
DECLARE @StyleColorNo nvarchar(200)
DECLARE @StyleColorName nvarchar(200)

SELECT @StyleID = StyleID, @StyleSeasonYearID = StyleSeasonYearID, @LineFolderID = LineFolderID
FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID
		
SELECT @StyleColorNo = ColorCode, @StyleColorName = ColorName 
FROM pColorPalette WITH (NOLOCK)
WHERE ColorPaletteID = @ColorPaletteID

/** Checking for duplicates for current color palette in current season/year **/

IF EXISTS (SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, pStyleColorway.StyleColorID
			FROM pLineFolderItem
				INNER JOIN pStyleColorwaySeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pLineFolderItem.StyleSeasonYearID 
				AND pLineFolderItem.StyleID = pStyleColorwaySeasonYear.StyleID
				INNER JOIN pStyleColorway ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID
				INNER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID
			WHERE pLineFolderItem.LineFolderItemID = @LineFolderItemID AND pStyleColorwaySeasonYear.StyleSeasonYearID = @StyleSeasonYearID
					AND pColorPalette.ColorPaletteID = @ColorPaletteID)
BEGIN
	RETURN
END
			

--**
--** Check if a Colorway with the same color Name/Code exists already 
--**
SELECT TOP 1 @StyleColorID = a.StyleColorID
FROM pStyleColorway a WITH(NOLOCK) 
	INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
WHERE StyleID = @StyleID 
AND b.ColorCode = @StyleColorNo
AND b.ColorName = @StyleColorName 


/**
** Define PLMCode
**/
DECLARE @PLMCode NVARCHAR (200) 
DECLARE @StyleNo NVARCHAR(20)
SELECT @PLMCode= StyleNo + @StyleColorNo, @StyleNo = StyleNo 
FROM pStyleHeader WITH(NOLOCK) WHERE StyleID = @StyleID 

DECLARE @StyleSet INT = 1

IF @StyleColorID IS NULL
BEGIN 
		SET @StyleColorID = NEWID()
		INSERT INTO pStyleColorway ( StyleColorID, StyleID, StyleSet, StylecolorStandardID , ColorPaletteID , StyleColorNo, StyleColorName,  MainColor,
					CUser, CDate, MUser, MDate , PLMCode) 
		VALUES ( @StyleColorID,  @StyleID, @StyleSet, NULL , @ColorPaletteID , @StyleColorNo, @StyleColorName,  @StyleColorName ,
					@CUser, @CDate, @CUser, @CDate , @PLMCode  )
		
		EXEC spx_LineFolderItemColor_INSERT
		@StyleID = @StyleID,
		@StyleColorID = @StyleColorID,
		@LineFolderItemID = @LineFolderItemID,
		@LineFolderID = @LineFolderID,
		@ModifiedDate = @CDate,
		@ModifiedBy = @CUser
END 


EXEC dbo.spx_StyleColorwayItem_FIX  @StyleId = @StyleID ,@StyleSet = 1


BEGIN
	DECLARE @ColorStatus INT 
	DECLARE @StyleColorwayDelivery INT
	DECLARE @LinePlanItemID UNIQUEIDENTIFIER

	SELECT @LinePlanItemID  = LinePlanItemID 
	FROM pStyleSeasonYear WITH(NOLOCK) 
	WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID

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


/**
** Insert colorway to all size classes 
**/

	DECLARE @DevelopmentID UNIQUEIDENTIFIER 
	DECLARE @Variation   INT 
	DECLARE @StyleID2  UNIQUEIDENTIFIER 
	DECLARE @Row INT
	DECLARE @Row_current INT 
	

	CREATE TABLE #TmpStyle (	
		Rec_ID INT IDENTITY  (1,1 )  ,
		StyleID UNIQUEIDENTIFIER  
	)


	SELECT @DevelopmentID  = a.DevelopmentID ,  @Variation  =  b.Variation  
	FROM pStyleHeader a WITH(NOLOCK) 
		INNER JOIN pStyleDevelopmentItem b WITH(NOLOCK) ON a.StyleID = b.StyleID AND	
			a.DevelopmentID = b.StyleDevelopmentID
	WHERE a.StyleID = @StyleID 

	

	INSERT INTO  #TmpStyle   ( StyleID   )
	SELECT  StyleID
	FROM pStyleDevelopmentItem  WITH(NOLOCK) 
	WHERE StyleDevelopmentID = @DevelopmentID AND Variation = @Variation 
	AND StyleID <>  @StyleID 

	SELECT @Row  = COUNT(*) FROM #TmpStyle 
	SET @Row_current  =  1


	DECLARE @StyleColorID2 UNIQUEIDENTIFIER
	DECLARE @StyleNo2 NVARCHAR(20)

	WHILE  @Row_current  <= @Row  
	BEGIN 
		SELECT @StyleID2 = StyleID FROM  #TmpStyle WHERE Rec_ID = @Row_current 
		SELECT @PLMCode= StyleNo + @StyleColorNo, @StyleNo2 = StyleNo FROM pStyleHeader WITH(NOLOCK) WHERE StyleID = @StyleID2		
		SET @StyleColorID2 = NULL
		
		--**
		--** Check if a Colorway with the same color Name/ Code exists already 
		--**
		SELECT TOP 1 @StyleColorID2 = a.StyleColorID
		FROM pStyleColorway a WITH(NOLOCK) 
			INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
		WHERE StyleID = @StyleID2 
			AND b.ColorCode = @StyleColorNo
			AND b.ColorName = @StyleColorName 

		IF @StyleColorID2 IS NULL 
		BEGIN 
			SET @StyleColorID2  = NEWID() 
			INSERT INTO pStyleColorway ( StyleColorID, StyleID, StyleSet, StylecolorStandardID , ColorPaletteID , StyleColorNo, StyleColorName,  MainColor,
						CUser, CDate, MUser, MDate , PLMCode ) 
			VALUES ( @StyleColorID2 ,  @StyleID2, @StyleSet, NULL , @ColorPaletteID , @StyleColorNo, @StyleColorName,  @StyleColorName ,
						@CUser, @CDate, @CUser, @CDate , @PLMCode ) 
						
		END 


		EXEC dbo.spx_StyleColorwayItem_FIX  @StyleId = @StyleID2 ,@StyleSet = 1

		/**
		** ADD Colorway - Season year
		**/
		BEGIN

			IF NOT EXISTS(SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK) WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID =  @StyleColorID2 ) 
			BEGIN 
				
				SET @StyleColorwaySeasonYearID2 = NEWID()
				
				INSERT INTO  pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID , StyleSeasonYearID , StyleColorwayID , StyleID ,  
				StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorDelivery5, StyleColorStatus, Units , SampleStatus)
				VALUES ( @StyleColorwaySeasonYearID2, @StyleSeasonYearID , @StyleColorID2 , @StyleID2 ,  
				1, 1, 1, 1,0, @ColorStatus, 0,  @ColorStatus) 
				--***	
				--** Add Logic INSERT 		
				--***
				EXEC spx_StyleColorway_Logic_INSERT @StyleSeasonYearID = @StyleSeasonYearID, @StyleColorID = @StyleColorID2, 
				@CUser= @CUser, @CDate = @CDate
				
			END 
				
		END 

		SET @Row_current = @Row_current  + 1 
	

	DROP TABLE #TmpStyle


END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04549', GetDate())
GO
