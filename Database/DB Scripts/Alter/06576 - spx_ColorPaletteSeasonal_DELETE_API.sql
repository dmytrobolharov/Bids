/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteSeasonal_DELETE_API]    Script Date: 11/13/2013 11:59:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteSeasonal_DELETE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteSeasonal_DELETE_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteSeasonal_DELETE_API]    Script Date: 11/13/2013 11:59:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ColorPaletteSeasonal_DELETE_API] (
	@ColorPaletteID uniqueidentifier,
	@SeasonYearID uniqueidentifier
	)
AS

delete from pColorPaletteSeasonYear where ColorPaletteID=@ColorPaletteID and SeasonYearID=@SeasonYearID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06576', GetDate())
GO