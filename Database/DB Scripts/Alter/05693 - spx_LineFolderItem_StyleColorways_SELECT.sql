/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_StyleColorways_SELECT]    Script Date: 05/20/2013 13:57:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleColorways_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleColorways_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_StyleColorways_SELECT]    Script Date: 05/20/2013 13:57:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleColorways_SELECT]
	@LineFolderItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, pStyleColorway.StyleColorID, pStyleColorway.Sort,
			1 AS IsVisible
	FROM pLineFolderItem
		INNER JOIN pStyleColorwaySeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pLineFolderItem.StyleSeasonYearID 
		AND pLineFolderItem.StyleID = pStyleColorwaySeasonYear.StyleID
		INNER JOIN pStyleColorway ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID
		INNER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID
	WHERE pLineFolderItem.LineFolderItemID = @LineFolderItemID
	UNION SELECT
	'00000000-0000-0000-0000-000000000000' AS ColorFolderID, '00000000-0000-0000-0000-000000000000' AS ColorPaletteID,
	'No Color' AS ColorCode, 'No Color' AS ColorName, 'No Color' AS StyleColorNo, 'No Color' AS StyleColorName, 
	'00000000-0000-0000-0000-000000000000' As StyleColorID, NULL AS Sort, 0 AS IsVisible
	ORDER BY IsVisible, Sort, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05693', GetDate())
GO
