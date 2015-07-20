/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_StyleColorways_SELECT]    Script Date: 11/29/2012 14:39:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleColorways_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleColorways_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_StyleColorways_SELECT]    Script Date: 11/29/2012 14:39:49 ******/
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
			pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, pStyleColorway.StyleColorID
	FROM pLineFolderItem
		INNER JOIN pStyleColorwaySeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pLineFolderItem.StyleSeasonYearID 
		AND pLineFolderItem.StyleID = pStyleColorwaySeasonYear.StyleID
		INNER JOIN pStyleColorway ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID
		INNER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID
	WHERE pLineFolderItem.LineFolderItemID = @LineFolderItemID
	ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04496', GetDate())
GO
