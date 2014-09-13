IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_LinePlanColor_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_DELETE](
@ColorPaletteID UNIQUEIDENTIFIER, 
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SeasonYearID UNIQUEIDENTIFIER,
@ChangeTransID UNIQUEIDENTIFIER,
@ChangeTransUserID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS

DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER 


DECLARE @StyleColorID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER
DECLARE @ColorName NVARCHAR(200)
DECLARE @ColorCode NVARCHAR(200)

DECLARE @ROWID INT
DECLARE @TOTAL INT 
DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @ChangeBeforeText NVARCHAR(400)

DECLARE @StyleSourcingItemID UNIQUEIDENTIFIER
DECLARE @StyleQuoteItemID UNIQUEIDENTIFIER


SELECT @StyleSeasonYearID = StyleSeasonYearID   
FROM pStyleSeasonYear WITH (NOLOCK)
WHERE StyleId = @StyleID AND SeasonYearID = @SeasonYearID


SELECT @StyleColorID = a.StyleColorID, @ColorName = ISNULl(b.ColorName,''), @ColorCode = ISNULL(b.ColorCode,'')
FROM pStyleColorway a WITH (NOLOCK)
	INNER JOIN pColorPalette  b  WITH (NOLOCK) ON b.ColorPaletteID =  a.ColorPaletteID 
WHERE a.StyleID = @StyleID  
AND a.ColorPaletteID = @ColorPaletteID 

SET @ChangeBeforeText = '(' + @ColorCode + ') ' + @ColorName 


--***
--**DELETE StyleColorwaySeasonYear
--***
CREATE TABLE #tmpSCSY(
	RowId INT IDENTITY (1,1) ,
	StyleColorwaySeasonYearID UNIQUEIDENTIFIER
)

INSERT INTO #tmpSCSY( StyleColorwaySeasonYearID )
SELECT StyleColorwaySeasonYearID 
FROM dbo.pStyleColorwaySeasonYear a WITH (NOLOCK)
	INNER JOIN dbo.pStyleColorway b WITH (NOLOCK) ON a.StyleColorwayID = b.StyleColorID
WHERE a.StyleSeasonYearID = @StyleSeasonYearID
	AND b.ColorPaletteID = @ColorPaletteID


SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmpSCSY

WHILE @ROWID <= @TOTAL
BEGIN

	SET @ChangeLogID = NULL

	SELECT @StyleColorwaySeasonYearID = StyleColorwaySeasonYearID 
	FROM #tmpSCSY WHERE RowId = @ROWID 

	--** DELETE Colorway / SeasonYear 
	DELETE FROM pStyleColorwaySeasonYear WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID

	IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
	BEGIN 
		--** Log action 
		EXECUTE spx_ChangeLog_INSERTID
			@changeTableId = '00000002-c1cc-df11-af06-005056c00008',
			@changeTransId = @ChangeTransID,
			@changeTablePKId = @StyleColorwaySeasonYearID,
			@changeUserId = @ChangeTransUserID, 
			@ChangeUserName = @MUser,
			@changeDate = @MDate,
			@changeSort = '0000',
			@ShowResult = 0,
			@ChangeLogID = @ChangeLogID OUTPUT

		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName = 'StyleColorwasySeasonYearID',
			@ChangeFieldAlias = 'StyleColorwasySeasonYearID',
			@ChangeBeforeValue = @StyleColorwaySeasonYearID,
			@ChangeAfterValue = NULL,
			@ChangeBeforeText = @ChangeBeforeText,
			@ChangeAfterText = NULL,
			@ChangeSort = '0001'
	END

	SET @ROWID = @ROWID + 1 	

END 

DROP TABLE #tmpSCSY




--***
--**DELETE SourcingItems
--***
CREATE TABLE #tmpSSI(
	RowId INT IDENTITY (1,1) ,
	StyleSourcingItemID UNIQUEIDENTIFIER
)

INSERT INTO #tmpSSI(StyleSourcingItemID)
SELECT  b.StyleSourcingItemID 
FROM pStyleSourcing a WITH (NOLOCK)
	INNER JOIN pStyleSourcingItem  b WITH (NOLOCK) ON a.StyleSourcingID =  b.StyleSourcingID 
	INNER JOIN pStyleColorway c WITH (NOLOCK) ON c.StyleColorID  =  b.StyleColorID 
WHERE StyleSeasonYearID = @StyleSeasonYearID
AND c.ColorPaletteID = @ColorPaletteID


SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmpSSI


WHILE @ROWID <= @TOTAL
BEGIN
	SET @ChangeLogID = NULL

	SELECT @StyleSourcingItemID = StyleSourcingItemID
	FROM #tmpSSI WHERE RowId = @ROWID 

	--** DELETE record
	DELETE FROM pStyleSourcingItem WHERE StyleSourcingItemID = @StyleSourcingItemID

	IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
	BEGIN 

		--** Log action 
		EXECUTE spx_ChangeLog_INSERTID
			@changeTableId = '00000004-c1cc-df11-af06-005056c00008',
			@changeTransId = @ChangeTransID,
			@changeTablePKId = @StyleColorwaySeasonYearID,
			@changeUserId = @ChangeTransUserID, 
			@ChangeUserName = @MUser,
			@changeDate = @MDate,
			@changeSort = '0000',
			@ShowResult = 0,
			@ChangeLogID = @ChangeLogID OUTPUT

		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName = 'StyleSourcingItemID',
			@ChangeFieldAlias = 'StyleSourcingItemID',
			@ChangeBeforeValue = @StyleSourcingItemID,
			@ChangeAfterValue = NULL,
			@ChangeBeforeText = @ChangeBeforeText,
			@ChangeAfterText = NULL,
			@ChangeSort = '0001'	
	END 


	SET @ROWID = @ROWID + 1 	

END


DROP TABLE #tmpSSI



--***
--** DELETE QuoteItems 
--***
CREATE TABLE #tmpSQI(
	RowId INT IDENTITY (1,1) ,
	StyleQuoteItemID UNIQUEIDENTIFIER
)

INSERT INTO #tmpSQI(StyleQuoteItemID)
SELECT a.StyleQuoteItemID
FROM pStyleQuoteItem a WITH (NOLOCK)
	INNER JOIN pStyleSourcing c WITH (NOLOCK) ON a.StyleSourcingID = c.StyleSourcingID 
	INNER JOIN pStyleColorway d WITH (NOLOCK) ON d.StyleColorID = a.StyleColorID 
WHERE c.StyleSeasonYearID = @StyleSeasonYearID
AND d.ColorPaletteID = @ColorPaletteID

SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmpSQI

WHILE @ROWID <= @TOTAL
BEGIN
	SET @ChangeLogID = NULL

	SELECT @StyleQuoteItemID = StyleQuoteItemID
	FROM #tmpSQI WHERE RowId = @ROWID 

	--** DELETE record
	DELETE FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

	IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'	
	BEGIN
		--** Log action 
		EXECUTE spx_ChangeLog_INSERTID
			@changeTableId = '00000005-c1cc-df11-af06-005056c00008',
			@changeTransId = @ChangeTransID,
			@changeTablePKId = @StyleQuoteItemID,
			@changeUserId = @ChangeTransUserID, 
			@ChangeUserName = @MUser,
			@changeDate = @MDate,
			@changeSort = '0000',
			@ShowResult = 0,
			@ChangeLogID = @ChangeLogID OUTPUT

		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName = 'StyleQuoteItemID',
			@ChangeFieldAlias = 'StyleQuoteItemID',
			@ChangeBeforeValue = @StyleQuoteItemID,
			@ChangeAfterValue = NULL,
			@ChangeBeforeText = @ChangeBeforeText,
			@ChangeAfterText = NULL,
			@ChangeSort = '0001'	
	END 



	SET @ROWID = @ROWID + 1 	

END

DROP TABLE #tmpSQI


--***
--** Check if the colorway is being used in a different SeasonYear 
--***
IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK) WHERE StyleColorwayID = @StyleColorID )
BEGIN

	--** DELETE record
	DELETE FROM pStyleColorway WHERE StyleColorID = @StyleColorID 

	IF @@ROWCOUNT < 0 
	BEGIN

		IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'	
		BEGIN 

			--** Log action 
			EXECUTE spx_ChangeLog_INSERTID
				@changeTableId = '00000003-c1cc-df11-af06-005056c00008',
				@changeTransId = @ChangeTransID,
				@changeTablePKId = @StyleColorID,
				@changeUserId = @ChangeTransUserID, 
				@ChangeUserName = @MUser,
				@changeDate = @MDate,
				@changeSort = '0000',
				@ShowResult = 0,
				@ChangeLogID = @ChangeLogID OUTPUT

			EXECUTE spx_ChangeLogItem_INSERT
				@ChangeLogID = @ChangeLogID,
				@ChangeTransID = @ChangeTransID,
				@ChangeFieldName = 'StyleColorID',
				@ChangeFieldAlias = 'StyleColorID',
				@ChangeBeforeValue = @StyleColorID,
				@ChangeAfterValue = NULL,
				@ChangeBeforeText = @ChangeBeforeText,
				@ChangeAfterText = NULL,
				@ChangeSort = '0001'	 		

		END 


	END 


END 




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '691', GetDate())
GO
