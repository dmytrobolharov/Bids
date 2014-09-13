--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

DELETE FROM ColorLibrary WHERE ColorLibraryTypeID = '00000000-0000-0000-0000-000000000001'

INSERT INTO ColorLibrary (
	PantoneType, PantoneNumber, PantoneName, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, Hex, Active, CUser, CDate, MUser, MDate, ColorPaletteID, ColorSource, ColorLibraryTypeID
)
SELECT 'Color Library', ColorCode, ColorName, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, Hex, Active, CUser, CDate, MUser, MDate, ColorPaletteID, ColorSource, ColorFolderID FROM pColorPalette
WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001'


UPDATE pColorPalette SET ColorLibraryID = a.ColorLibraryID 
FROM ColorLibrary AS a
WHERE pColorPalette.ColorPaletteID = a.ColorPaletteID AND a.ColorLibraryTypeID = '00000000-0000-0000-0000-000000000001'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06735', GetDate())
GO
