IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningColor_INSERT]
	@PlanningID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,	
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN

	DECLARE @PlanningColorID UNIQUEIDENTIFIER = NEWID()
	
	DECLARE @ColorFolderID UNIQUEIDENTIFIER
	SELECT @ColorFolderID = ColorFolderID FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteID
	
	-- Add new color to Planning
	INSERT INTO pPlanningColor (PlanningColorID, PlanningID, ColorFolderID, ColorPaletteID, CUser, CDate, MUser, MDate)
	VALUES (@PlanningColorID, @PlanningID, @ColorFolderID, @ColorPaletteID, @CUser, @CDate, @CUser, @CDate)
	
	
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID
	
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
VALUES ('DB_Version', '0.5.0000', '06335', GetDate())
GO
