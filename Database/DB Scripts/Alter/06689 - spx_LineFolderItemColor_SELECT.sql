IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColor_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItemColor_SELECT]
(
@StyleID uniqueidentifier,
@LineFolderItemID uniqueidentifier
)
AS 

SELECT     dbo.pLineFolderItemColor.LineFolderItemColorID, dbo.pLineFolderItemColor.LineFolderItemID, dbo.pLineFolderItemColor.LineFolderID, 
      dbo.pLineFolderItemColor.LineFolderItemColorDrop, dbo.pLineFolderItemColor.LineFolderItemColorDropUser, 
      dbo.pLineFolderItemColor.LineFolderItemColorDropDate, dbo.pStyleColorway.StyleColorID, dbo.pStyleColorway.StyleID, 
      dbo.pStyleColorway.StyleColorStandardID, dbo.pStyleColorway.StyleColorNo, dbo.pStyleColorway.StyleColorName, dbo.pStyleColorway.Sort, 
      dbo.pLineFolderItemColor.CDate, dbo.pLineFolderItemColor.CUser, dbo.pLineFolderItemColor.MDate, dbo.pLineFolderItemColor.MUser,
      dbo.pStyleColorway.StyleColorName as ColorComboDescription, 
      dbo.pStyleColorway.ColorPaletteID, dbo.pColorPalette.ColorFolderID
FROM         dbo.pLineFolderItemColor WITH (NOLOCK) INNER JOIN
      dbo.pStyleColorway WITH (NOLOCK) ON dbo.pLineFolderItemColor.StyleColorID = dbo.pStyleColorway.StyleColorID LEFT JOIN
      dbo.pColorPalette WITH (NOLOCK) ON dbo.pStyleColorway.ColorPaletteID = dbo.pColorPalette.ColorPaletteID
WHERE  pLineFolderItemColor.StyleID = @StyleID AND pLineFolderItemColor.LineFolderItemID = @LineFolderItemID

UNION

SELECT     dbo.pLineFolderItemColor.LineFolderItemColorID, dbo.pLineFolderItemColor.LineFolderItemID, dbo.pLineFolderItemColor.LineFolderID, 
      dbo.pLineFolderItemColor.LineFolderItemColorDrop, dbo.pLineFolderItemColor.LineFolderItemColorDropUser, 
      dbo.pLineFolderItemColor.LineFolderItemColorDropDate, NULL as StyleColorID, @StyleID as StyleID, 
      dbo.pLineFolderItemColor.StyleColorStandardID, dbo.pLineFolderItemColor.StyleColorNo, dbo.pLineFolderItemColor.StyleColorName, dbo.pLineFolderItemColor.Sort, 
      dbo.pLineFolderItemColor.CDate, dbo.pLineFolderItemColor.CUser, dbo.pLineFolderItemColor.MDate, dbo.pLineFolderItemColor.MUser,
      dbo.pLineFolderItemColor.StyleColorName as ColorComboDescription, 
      dbo.pLineFolderItemColor.ColorPaletteID, dbo.pColorPalette.ColorFolderID
FROM         dbo.pLineFolderItemColor WITH (NOLOCK) INNER JOIN
      dbo.pColorPalette WITH (NOLOCK) ON dbo.pLineFolderItemColor.ColorPaletteID = dbo.pColorPalette.ColorPaletteID
WHERE  pLineFolderItemColor.StyleID = @StyleID AND pLineFolderItemColor.LineFolderItemID = @LineFolderItemID

ORDER BY Sort, StyleColorNo, StyleColorName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06689', GetDate())
GO
