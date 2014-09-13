/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteSeasonYear_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteSeasonYear_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteSeasonYear_DELETE]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ColorPaletteSeasonYear_DELETE]  (
	@ColorFolderID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS 


IF (SELECT COUNT(*) FROM pColorPaletteSeasonYear WHERE ColorPaletteID = @ColorPaletteID AND SeasonYearID = @SeasonYearID) <> 0
BEGIN

	DELETE FROM pColorPaletteSeasonYear WHERE ColorPaletteID = @ColorPaletteID AND SeasonYearID = @SeasonYearID 

	DECLARE @ColorSeason NVARCHAR(100)
	DECLARE @ColorYear NVARCHAR(100)
	DECLARE @ColorEvent NVARCHAR(200)
	SELECT @ColorSeason = Season, @ColorYear = [Year] FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
	SET @ColorEvent = 'Color Chip: Deleted Season & Year: ' + @ColorSeason + '/ ' + @ColorYear 

	exec spx_ColorFolderActivity_INSERT @ColorFolderId=@ColorFolderID,
	@ColorPaletteId=@ColorPaletteID,
	@TeamId=@TeamID,
	@TradePartner='0',
	@CreatedBy=@CUser,	
	@CreatedDate=@CDate,
	@ColorActivity=N'D',
	@ColorActivityDetail=@ColorEvent,
	@TimeInterval=0


END

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03480', GetDate())

GO