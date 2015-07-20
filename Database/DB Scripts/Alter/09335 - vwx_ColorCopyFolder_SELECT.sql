IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorCopyFolder_SELECT]'))
DROP VIEW [dbo].[vwx_ColorCopyFolder_SELECT]
GO

CREATE VIEW [dbo].[vwx_ColorCopyFolder_SELECT]

AS
	SELECT cps.*, T.ColorFolderID AS TargetColorFolderID, CASE WHEN cpt.ColorPaletteID IS NULL THEN 1 ELSE 0 END AS IsAvailable
	FROM pColorFolder S
	CROSS JOIN pColorFolder T
	INNER JOIN pColorPalette cpS ON S.ColorFolderID = cps.ColorFolderID
	LEFT JOIN pColorPalette cpT ON T.ColorFolderID = cpT.ColorFolderID
		AND cpS.ColorCode = cpt.ColorCode AND cpS.ColorName=cpT.ColorName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09335', GetDate())
GO
