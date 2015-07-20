IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningColor_INSERT]
	@PlanningID UNIQUEIDENTIFIER
	, @ColorPaletteID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @PlanningColorID UNIQUEIDENTIFIER = NULL
	, @TeamID UNIQUEIDENTIFIER
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
AS

BEGIN

	SET @PlanningColorID = ISNULL(@PlanningColorID, NEWID())
	
	DECLARE @ColorFolderID UNIQUEIDENTIFIER
	SELECT @ColorFolderID = ColorFolderID FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteID
	
	-- Add new color to Planning
	INSERT INTO pPlanningColor (PlanningColorID, PlanningID, ColorFolderID, ColorPaletteID, CUser, CDate, MUser, MDate, SeasonYearID)
	VALUES (@PlanningColorID, @PlanningID, @ColorFolderID, @ColorPaletteID, @CUser, @CDate, @CUser, @CDate, @SeasonYearID)
	
	---- Add Color to Color Folder SeasonYear
	EXEC spx_ColorPaletteSeasonYear_INSERT
			@ColorFolderID = @ColorFolderID,
			@ColorPaletteID = @ColorPaletteID,
			@SeasonYearID = @SeasonYearID,
			@TeamID = @TeamID,
			@CUser = @CUser,
			@CDate = @CDate
			

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06712', GetDate())
GO
