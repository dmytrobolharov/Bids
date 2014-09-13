IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialColorSeasonYear_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialColorSeasonYear_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialColorSeasonYear_INSERT]  (
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialColorID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS 

IF (SELECT COUNT(*) FROM pMaterialColorSeasonYear WHERE MaterialColorID = @MaterialColorID AND SeasonYearID = @SeasonYearID) = 0
BEGIN

	DECLARE @ColorSeason VARCHAR(100)
	DECLARE @ColorYear VARCHAR(100)
	DECLARE @ColorEvent VARCHAR(200)
	SELECT @ColorSeason = Season, @ColorYear = [Year] FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
	SET @ColorEvent = 'Material Color: New Season & Year: ' + @ColorSeason + '/ ' + @ColorYear 

	INSERT INTO pMaterialColorSeasonYear(SeasonYearID, MaterialId, MaterialColorID, MaterialSeason, MaterialYear, CUser, CDate, MUser, MDate)
	VALUES (@SeasonYearID, @MaterialID, @MaterialColorID, @ColorSeason, @ColorYear, @CUser, @CDate, @CUser, @CDate) 

	exec spx_MaterialActivity_INSERT 
	@MaterialId=@MaterialID,
	@TeamId=@TeamID,
	@TradePartner='0',
	@CreatedBy=@CUser,	
	@CreatedDate=@CDate,
	@MaterialActivity=N'U',
	@MaterialActivityDetail=@ColorEvent,
	@TimeInterval=0

	EXEC spx_MaterialColorSeasonYear_Logic_INSERT 
	@SeasonYearID = @SeasonYearID,
	@MaterialColorID = @MaterialColorID,
	@MaterialID = @MaterialID,
	@CUser = @CUser ,
	@CDate = @CDate 


END









GO