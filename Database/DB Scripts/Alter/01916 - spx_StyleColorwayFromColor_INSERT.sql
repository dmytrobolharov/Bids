
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 09 sep 2011                                                                                */
-- * WorkItem #4590                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayFromColor_INSERT]    Script Date: 09/09/2011 19:17:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayFromColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayFromColor_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayFromColor_INSERT]    Script Date: 09/09/2011 19:17:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleColorwayFromColor_INSERT]  (
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ColorPaletteID UNIQUEIDENTIFIER, 
	@CUser  NVARCHAR (200), 
	@CDate DATETIME, 
	@AllSizeClasses INT,
	@SeasonYearID UNIQUEIDENTIFIER  = NULL, 
	@ChangeTransID UNIQUEIDENTIFIER = NULL,
	@ChangeTransUserID UNIQUEIDENTIFIER = NULL,
	@ChangeTransPageName NVARCHAR(200) = NULL
)
AS 


DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleColorwaySeasonYearID2 UNIQUEIDENTIFIER
DECLARE @StyleColorID UNIQUEIDENTIFIER  
DECLARE @StyleColorNo varchar(200)
DECLARE @StyleColorName varchar(200)

DECLARE @ChangeAfterText NVARCHAR(400)
DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @ChangeLogID2 UNIQUEIDENTIFIER

		
SELECT @StyleColorNo = ColorCode, @StyleColorName = ColorName 
FROM pColorPalette WITH (NOLOCK)
WHERE ColorPaletteID = @ColorPaletteID

SET @ChangeAfterText = '('+ ISNULL(@StyleColorNo,'') + ') ' + ISNULL(@StyleColorName,'')
	

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


IF @StyleColorID IS NULL
BEGIN 
	SET @StyleColorID = NEWID()
	INSERT INTO pStyleColorway ( StyleColorID, StyleID, StyleSet, StylecolorStandardID , ColorPaletteID , StyleColorNo, StyleColorName,  MainColor,
				CUser, CDate, MUser, MDate , PLMCode) 
	VALUES ( @StyleColorID,  @StyleID, @StyleSet, NULL , @ColorPaletteID , @StyleColorNo, @StyleColorName,  @StyleColorName ,
				@CUser, @CDate, @CUser, @CDate , @PLMCode  ) 

	-- ** Log Insert 			
	IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
	BEGIN

		--** Log in pStylecolorway 
		SET @ChangeLogID = NULL
			
		EXECUTE spx_ChangeLog_INSERTID
			@changeTableId = '00000003-c1cc-df11-af06-005056c00008',
			@changeTransId = @ChangeTransID,
			@changeTablePKId = @StyleColorID,
			@changeUserId = @ChangeTransUserID, 
			@ChangeUserName = @CUser,
			@changeDate = @CDate,
			@changeSort = '0000',
			@ShowResult = 0,
			@ChangeLogID = @ChangeLogID OUTPUT
				
		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName = 'StyleColorID',
			@ChangeFieldAlias = 'StyleColorID',
			@ChangeBeforeValue = NULL,
			@ChangeAfterValue = @StyleColorID,
			@ChangeBeforeText = NULL,
			@ChangeAfterText = @ChangeAfterText,
			@ChangeSort = '0001'
	END 
	
END 


EXEC dbo.spx_StyleColorwayItem_FIX  @StyleId = @StyleID ,@StyleSet = 1


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
	WHERE StyleID = @StyleID AND SeasonYearID =  @SeasonYearID 

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
		
		INSERT INTO pStyleSeasonYear ( StyleSeasonYearID , StyleID , StyleSeason, StyleYear, CUser, CDate, MUser, MDate, SeasonYearID, StyleNo, CurrentSeason )
		SELECT @StyleSeasonYearID, @StyleID , a.Season, a.Year, @CUser, @CDate, @CUser, @CDate,	a.SeasonYearID, @StyleNo, 0
		FROM  pSeasonYear a WITH(NOLOCK) WHERE a.SeasonYearID = @SeasonYearID
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
		
		
		IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
		BEGIN 
			
			--** Log Insert		
			SET @ChangeLogID = NULL
				
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
	
		--** --Comment #01
		--** Add Logic INSERT 		
		EXEC spx_StyleColorway_Logic_INSERT @StyleSeasonYearID = @StyleSeasonYearID, @StyleColorID = @StyleColorID, 
		@CUser= @CUser, @CDate = @CDate

	END 
		
END 


/**
** Insert colorway to all size classes 
**/
IF   @AllSizeClasses  =   1  
BEGIN 

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
	
	DECLARE @ChangeTransID2 UNIQUEIDENTIFIER 
	DECLARE @ChangeTransTableID2 UNIQUEIDENTIFIER 
	SET @ChangeTransTableID2 = 'D612FAAE-7ACD-DF11-AF06-005056C00008'

	WHILE  @Row_current  <= @Row  
	BEGIN 
		SELECT @StyleID2 = StyleID FROM  #TmpStyle WHERE Rec_ID = @Row_current 
		SELECT @PLMCode= StyleNo + @StyleColorNo, @StyleNo2 = StyleNo FROM pStyleHeader WITH(NOLOCK) WHERE StyleID = @StyleID2		
		SET @StyleColorID2 = NULL

	
		IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
		BEGIN 
			--** Logging changes, 
			--** Need to create a different transaction becasue the ChangeTransID should be  linked to the StyleID
			SET @ChangeTransID2 =  NEWID()

			--** Insert Transaction 
			INSERT INTO pChangeTransaction( ChangeTransID, ChangeTransPageName , 
				ChangeTransTableID, ChangeTransTablePKID, ChangeTransUserID, ChangeTransDate, ChangeTransTypeID) 
			VALUES( @ChangeTransID2, @ChangeTransPageName, 
				@ChangeTransTableID2, @StyleID2, @ChangeTransUserID, @CDate, 1 )  -- ** ChangeTransTypeID=1 FOR INSERT 
		END 
		

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
						
			IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
			BEGIN
				--** Log in pStylecolorway 
				SET @ChangeLogID2 = NULL
					
				EXECUTE spx_ChangeLog_INSERTID
					@changeTableId = '00000003-c1cc-df11-af06-005056c00008',
					@changeTransId = @ChangeTransID2,
					@changeTablePKId = @StyleColorID2,
					@changeUserId = @ChangeTransUserID, 
					@ChangeUserName = @CUser,
					@changeDate = @CDate,
					@changeSort = '0000',
					@ShowResult = 0,
					@ChangeLogID = @ChangeLogID2 OUTPUT
						
				EXECUTE spx_ChangeLogItem_INSERT
					@ChangeLogID = @ChangeLogID2,
					@ChangeTransID = @ChangeTransID2,
					@ChangeFieldName = 'StyleColorID',
					@ChangeFieldAlias = 'StyleColorID',
					@ChangeBeforeValue = NULL,
					@ChangeAfterValue = @StyleColorID2,
					@ChangeBeforeText = NULL,
					@ChangeAfterText = @ChangeAfterText,
					@ChangeSort = '0001'			
			END 
		END 


		EXEC dbo.spx_StyleColorwayItem_FIX  @StyleId = @StyleID2 ,@StyleSet = 1

		/**
		** ADD Colorway - Season year
		**/
		IF @SeasonYearID  IS NOT NULL 
		BEGIN
			DECLARE @StyleSeasonYearID2 UNIQUEIDENTIFIER 
			SELECT @StyleSeasonYearID2 = StyleSeasonYearID 
			FROM pStyleSeasonYear WITH(NOLOCK) 
			WHERE StyleID = @StyleID2 AND SeasonYearID =  @SeasonYearID 

			IF @StyleSeasonYearID2 IS NULL
			BEGIN
				SET @StyleSeasonYearID2 = NEWID() 

				INSERT INTO pStyleSeasonYear ( StyleSeasonYearID , StyleID , StyleSeason, StyleYear, CUser, CDate, MUser, MDate,
				SeasonYearID, StyleNo, CurrentSeason )
				SELECT @StyleSeasonYearID2, @StyleID2 , a.Season, a.Year, @CUser, @CDate, @CUser, @CDate,
				a.SeasonYearID, @StyleNo2, 0
				FROM  pSeasonYear a WITH(NOLOCK) 
				WHERE a.SeasonYearID = @SeasonYearID
			END 

			IF NOT EXISTS(SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK) WHERE StyleSeasonYearID = @StyleSeasonYearID2 AND StyleColorwayID =  @StyleColorID2 ) 
			BEGIN 
				
				SET @StyleColorwaySeasonYearID2 = NEWID()
				
				INSERT INTO  pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID , StyleSeasonYearID , StyleColorwayID , StyleID ,  
				StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorDelivery5, StyleColorStatus, Units , SampleStatus)
				VALUES ( @StyleColorwaySeasonYearID2, @StyleSeasonYearID2 , @StyleColorID2 , @StyleID2 ,  
				1, 1, 1, 1,0, @ColorStatus, 0,  @ColorStatus) 

				IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40))  <> '00000000-0000-0000-0000-000000000000'
				BEGIN 
					--** Log Insert		
					SET @ChangeLogID2 = NULL
						
					EXECUTE spx_ChangeLog_INSERTID
						@changeTableId = '00000002-c1cc-df11-af06-005056c00008',
						@changeTransId = @ChangeTransID2,
						@changeTablePKId = @StyleColorwaySeasonYearID2,
						@changeUserId = @ChangeTransUserID, 
						@ChangeUserName = @CUser,
						@changeDate = @CDate,
						@changeSort = '0000',
						@ShowResult = 0,
						@ChangeLogID = @ChangeLogID2 OUTPUT
						
					EXECUTE spx_ChangeLogItem_INSERT
						@ChangeLogID = @ChangeLogID2,
						@ChangeTransID = @ChangeTransID2,
						@ChangeFieldName = 'StyleColorwasySeasonYearID',
						@ChangeFieldAlias = 'StyleColorwasySeasonYearID',
						@ChangeBeforeValue = NULL,
						@ChangeAfterValue = @StyleColorwaySeasonYearID2,
						@ChangeBeforeText = NULL,
						@ChangeAfterText = @ChangeAfterText,
						@ChangeSort = '0001'				
				END 				
				
				
				--***	
				--** Add Logic INSERT 		
				--***
				EXEC spx_StyleColorway_Logic_INSERT @StyleSeasonYearID = @StyleSeasonYearID2, @StyleColorID = @StyleColorID2, 
				@CUser= @CUser, @CDate = @CDate
				
			END 
				
		END 

		SET @Row_current = @Row_current  + 1 
	END 

	DROP TABLE #TmpStyle


END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01916'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01916', GetDate())

END

GO 



