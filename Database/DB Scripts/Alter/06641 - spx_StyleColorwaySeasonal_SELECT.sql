/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonal_SELECT]    Script Date: 11/21/2013 13:48:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonal_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonal_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonal_SELECT]    Script Date: 11/21/2013 13:48:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleColorwaySeasonal_SELECT](
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER

SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear
WHERE StyleID=@StyleID and SeasonYearID=@SeasonYearID

select sci.StyleColorwayID as colorid, ColorName from pStyleColorwaySeasonYear sci  
INNER JOIN dbo.pStyleColorway A ON sci.StyleColorwayID = A.StyleColorID       
INNER JOIN pColorPalette AS E ON A.ColorPaletteID = E.ColorPaletteID
where sci.StyleID=@StyleID and sci.StyleSeasonYearID = @StyleSeasonYearID
UNION
select sci.ColorPaletteID as colorid, ColorName from pStyleColorwaySeasonYear sci  
INNER JOIN pColorPalette AS E ON sci.ColorPaletteID = E.ColorPaletteID
where sci.StyleID=@StyleID and sci.StyleSeasonYearID = @StyleSeasonYearID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06641', GetDate())
GO