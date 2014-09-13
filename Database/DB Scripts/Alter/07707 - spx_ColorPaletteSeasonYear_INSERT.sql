IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteSeasonYear_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteSeasonYear_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorPaletteSeasonYear_INSERT]  (
	@ColorFolderID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS 


IF (SELECT COUNT(*) FROM pColorPaletteSeasonYear WHERE ColorPaletteID = @ColorPaletteID AND SeasonYearID = @SeasonYearID) = 0
BEGIN

	DECLARE @ColorSeason NVARCHAR(100)
	DECLARE @ColorYear NVARCHAR(100)
	--DECLARE @ColorEvent NVARCHAR(200)
	SELECT @ColorSeason = Season, @ColorYear = [Year] FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
	--SET @ColorEvent = 'Color Chip: New Season & Year: ' + @ColorSeason + '/ ' + @ColorYear 

	INSERT INTO pColorPaletteSeasonYear(SeasonYearID, ColorPaletteID, ColorSeason, ColorYear, CUser, CDate, MUser, MDate , ColorFolderID)
	VALUES (@SeasonYearID, @ColorPaletteID, @ColorSeason, @ColorYear, @CUser, @CDate, @CUser, @CDate, @ColorFolderID) 


	--exec spx_ColorFolderActivity_INSERT @ColorFolderId=@ColorFolderID,
	--@ColorPaletteId=@ColorPaletteID,
	--@TeamId=@TeamID,
	--@TradePartner='0',
	--@CreatedBy=@CUser,	
	--@CreatedDate=@CDate,
	--@ColorActivity=N'U',
	--@ColorActivityDetail=@ColorEvent,
	--@TimeInterval=0

	--***
	--** Modified by: Artemio Gomez  3/9/2010
	--** Add Season/Year to the Colorfolder as well 
	--***
	DECLARE @ColorFolderSeasonYearID AS UNIQUEIDENTIFIER 
	SET @ColorFolderSeasonYearID = NEWID()

	EXEC spx_ColorFolderSeasonYear_INSERT 
	@ColorFolderSeasonYearID = @ColorFolderSeasonYearID,
	@ColorFolderID = @ColorfolderID,
	@SeasonYearID = @SeasonYearID,
	@CUser = @CUser , 
	@CDate = @CDate


END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07707', GetDate())
GO
