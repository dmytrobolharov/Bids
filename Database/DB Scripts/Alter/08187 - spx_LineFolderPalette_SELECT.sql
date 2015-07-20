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
	
	CREATE TABLE #tmpLineListPlanningItems (
		LinePaletteID UNIQUEIDENTIFIER,
		LinePaletteName NVARCHAR(200),
		LinePaletteDescription NVARCHAR(200),
		LinePaletteSort NVARCHAR(5),
		Child NVARCHAR(5)
	)
	
	INSERT INTO #tmpLineListPlanningItems
	VALUES ('00000000-0000-0000-0000-000000000020', 'Financial Plan', 'Financial Plan...', 1, '1'),
		('00000000-0000-0000-0000-000000000021', 'Historical List', 'Historical List...', 2, '1'),
		('00000000-0000-0000-0000-000000000022', 'SKU Plan', 'SKU Plan...', 3, '1'),
		('00000000-0000-0000-0000-000000000023', 'Notifications', 'Notifications...', 4, '1')
	
    SELECT '00000000-0000-0000-0000-000000000001' AS LinePaletteID, 'Line List Planning' AS LinePaletteName, 
		'Line List Planning' AS LinePaletteDescription, 0 AS LinePaletteSort, '0' As Child
		UNION
	SELECT LinePaletteID, LinePaletteName, LinePaletteDescription, LinePaletteSort, Child 
			FROM #tmpLineListPlanningItems
		UNION
	SELECT '00000000-0000-0000-0000-000000000002' AS LinePaletteID, 'Palette Edit' AS LinePaletteName, 
		'Palette Edit' AS LinePaletteDescription, 100 AS LinePaletteSort, '0' As Child
		UNION
    SELECT LineFolderFlashEditId AS LinePaletteID, LineFolderFlashEditFormName AS LinePaletteName, 
			LineFolderFlashEditDescription AS LinePaletteDescription, LineFolderFlashEditSort+100 AS LinePaletteSort, '1' As Child
			FROM pLineFolderFlashEdit
		UNION		
	SELECT '00000000-0000-0000-0000-000000000003' AS LinePaletteID, 'Attachment' AS LinePaletteName, 
		'Attachment' AS LinePaletteDescription, 200 AS LinePaletteSort, '0' As Child
		UNION
	SELECT '00000000-0000-0000-0000-000000000004' AS LinePaletteID, 'Flash Edit' AS LinePaletteName,
		'Flash Edit' AS LinePaletteDescription, 201 AS LinePaletteSort, '0' As Child
		UNION
     SELECT LineListFlashEditID AS LinePaletteID, LineListFlashEditName AS LinePaletteName, 
			LineListFlashEditDescription AS LinePaletteDescription, LineListFlashEditSort+202 AS LinePaletteSort, '1' As Child
			FROM pLineListFlashEdit
		UNION
	SELECT '00000000-0000-0000-0000-000000000005' AS LinePaletteID, 'Sample Requests' AS LinePaletteName, 
		'Sample Requests' AS LinePaletteDescription, 300 AS LinePaletteSort, '0' As Child
	ORDER BY LinePaletteSort
	
	DROP TABLE #tmpLineListPlanningItems
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08187', GetDate())
GO
