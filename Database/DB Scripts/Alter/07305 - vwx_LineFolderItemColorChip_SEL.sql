IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderItemColorChip_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderItemColorChip_SEL]
GO


CREATE VIEW [dbo].[vwx_LineFolderItemColorChip_SEL]
AS
	SELECT pLineFolderItemColor.LineFolderItemColorID, pLineFolderItemColor.LineFolderItemID, pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, 
		pColorPalette.ColorCode, pColorPalette.ColorName, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, 
		NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion, pStyleColorway.Sort,
		pLineFolderItemColor.LineFolderItemColorDrop
	FROM pStyleColorway WITH (NOLOCK) 
		INNER JOIN pLineFolderItemColor WITH (NOLOCK) ON pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID 
		INNER JOIN pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID
	WHERE pLineFolderItemColor.StyleColorID IS NOT NULL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07305', GetDate())
GO
