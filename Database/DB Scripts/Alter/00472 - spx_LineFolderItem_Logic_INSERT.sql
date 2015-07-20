IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_Logic_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItem_Logic_INSERT](
@StyleID UNIQUEIDENTIFIER,
@LineFolderItemID UNIQUEIDENTIFIER,
@LineFolderID UNIQUEIDENTIFIER,
@CDate DATETIME,
@CUser NVARCHAR(200)
)
AS 

--***
--** Define the season/Year
--***
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @SeasonYearID UNIQUEIDENTIFIER 
DECLARE @Season NVARCHAR(200)
DECLARE @Year VARCHAR(200)

SELECT @Season = b.Season, @year = b.Year, @SeasonYearID =  b.SeasonYearID
FROM dbo.pLineFolder a
INNER JOIN dbo.pSeasonYear  b ON b.Season =  a.LineSubFolder6 AND b.Year = a.LineSubFolder7
WHERE a.LineFolderID = @LineFolderID

SELECT @StyleSeasonYearID = StyleSeasonYearID
FROM dbo.pStyleSeasonYear 
WHERE StyleID = @StyleID  AND SeasonYearID = @SeasonYearID


IF @StyleSeasonYearID IS NULL
BEGIN
	SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID FROM dbo.pStyleSeasonYear WHERE StyleID = @StyleID 
	
	IF @StyleSeasonYearID IS NULL 
	BEGIN
		--***
		--** Add *NA *NA season year 
		--***
		SELECT @Season = b.Season, @year = b.Year, @SeasonYearID =  b.SeasonYearID
		FROM dbo.pSeasonYear b
		WHERE Season = '*NA' AND Year = '*NA'

		IF @SeasonYearID IS NOT NULL 
		BEGIN 
			SET @StyleSeasonYearID = NEWID()
			
			INSERT INTO dbo.pStyleSeasonYear (StyleSeasonYearID,StyleID,StyleSeason,StyleYear, CUser,CDate,SeasonYearID)
			VALUES( @StyleSeasonYearID, @StyleID, @Season,@Year, @CUser,@CDate,@SeasonYearID )
		
		END 		
		
	END 
	
END 

IF @StyleSeasonYearID IS NOT NULL 
BEGIN
	--***
	--** Call standar procedure
	--***
	EXECUTE spx_LineFolderItem_INSERT
	@StyleSeasonYearID=@StyleSeasonYearID, @LineFolderItemID=@LineFolderItemID,
	@LineFolderID=@LineFolderID, @CreatedDate=@CDate, @CreatedBy=@CUser
	
END



GO