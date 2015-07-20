/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteSeasonal_CREATE_API]    Script Date: 11/13/2013 11:56:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteSeasonal_CREATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteSeasonal_CREATE_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteSeasonal_CREATE_API]    Script Date: 11/13/2013 11:56:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ColorPaletteSeasonal_CREATE_API] (
	@ColorPaletteID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@CUser NVARCHAR(200),
	@CDate datetime
	)
AS

DECLARE @Season nvarchar(200)
DECLARE @Year nvarchar(200)
SELECT @Season=Season, @Year=Year from pSeasonYear WHERE SeasonYearID=@SeasonYearID

INSERT INTO pColorPaletteSeasonYear(ColorPaletteSeasonYearID,SeasonYearID,ColorFolderID,ColorPaletteID, ColorSeason, ColorYear, CUser, CDate,MUser,MDate)
select newid(), @SeasonYearID, ColorFolderID, ColorPaletteID, @Season, @Year, @CUser, @CDate, @CUser, @CDate from pColorPalette where ColorPaletteID=@ColorPaletteID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06574', GetDate())
GO