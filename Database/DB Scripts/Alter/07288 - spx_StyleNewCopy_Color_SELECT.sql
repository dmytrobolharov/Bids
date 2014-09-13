IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewCopy_Color_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewCopy_Color_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleNewCopy_Color_SELECT](
	@StyleID UNIQUEIDENTIFIER, 
	@SeasonYearID UNIQUEIDENTIFIER,
	@ImageServer NVARCHAR(MAX)
)
AS

SELECT b.StyleColorwaySeasonYearID, 
	@ImageServer + '/ColorStream.ashx?S=25&CFID='  + CAST(d.ColorFolderID AS NVARCHAR(40))+ '&CPID=' + CAST(d.ColorPaletteID AS NVARCHAR(40)) AS ColorUrl,
	d.ColorCode,
	d.ColorName 
FROM pStyleColorway a
	INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleColorID = b.StyleColorwayID
	INNER JOIN dbo.pStyleSeasonYear c ON c.StyleSeasonYearID =  b.StyleSeasonYearID
	INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = a.ColorPaletteID
WHERE b.StyleID =  @StyleID
	AND c.SeasonYearID = @SeasonYearID

ORDER BY ColorCode

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07288', GetDate())
GO
