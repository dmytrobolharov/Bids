IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPalette_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderPalette_SELECT]
	@LineFolderTypeID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT '00000000-0000-0000-0000-000000000001' AS LinePaletteID, 'Line List Planning' AS LinePaletteName, 
		'Line List Planning' AS LinePaletteDescription, 0 AS LinePaletteSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000002' AS LinePaletteID, 'Palette Edit' AS LinePaletteName, 
		'Palette Edit' AS LinePaletteDescription, 1 AS LinePaletteSort, '0' As Child
		UNION
    SELECT LineFolderFlashEditId AS LinePaletteID, LineFolderFlashEditFormName AS LinePaletteName, 
			LineFolderFlashEditDescription AS LinePaletteDescription, LineFolderFlashEditSort+1 AS LinePaletteSort, '1' As Child
			FROM pLineFolderFlashEdit
		UNION		
	SELECT '00000000-0000-0000-0000-000000000003' AS LinePaletteID, 'Attachment' AS LinePaletteName, 
		'Attachment' AS LinePaletteDescription, 100 AS LinePaletteSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000004' AS LinePaletteID, 'Flash Edit' AS LinePaletteName,
		'Flash Edit' AS LinePaletteDescription, 101 AS LinePaletteSort, '0' As Child
		UNION
     SELECT LineListFlashEditID AS LinePaletteID, LineListFlashEditName AS LinePaletteName, 
			LineListFlashEditDescription AS LinePaletteDescription, LineListFlashEditSort+102 AS LinePaletteSort, '1' As Child
			FROM pLineListFlashEdit
		UNION
	SELECT '00000000-0000-0000-0000-000000000005' AS LinePaletteID, 'Sample Requests' AS LinePaletteName, 
		'Sample Requests' AS LinePaletteDescription, 200 AS LinePaletteSort, '0' As Child
	ORDER BY LinePaletteSort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07399', GetDate())
GO
