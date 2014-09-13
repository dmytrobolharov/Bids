/****** Object:  StoredProcedure [dbo].[spx_LineFolderPalette_SELECT]    Script Date: 06/11/2013 13:48:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPalette_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderPalette_SELECT]    Script Date: 06/11/2013 13:48:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderPalette_SELECT]
	@LineFolderTypeID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT LineFolderFlashEditId AS LinePaletteID, LineFolderFlashEditFormName AS LinePaletteName, 
			LineFolderFlashEditDescription AS LinePaletteDescription, LineFolderFlashEditSort AS LinePaletteSort
			FROM pLineFolderFlashEdit
		UNION
    SELECT '00000000-0000-0000-0000-000000000001' AS LinePaletteID, 'Line List Planning' AS LinePaletteName, 
		'Line List Planning' AS LinePaletteDescription, '0000' AS LinePaletteSort
	ORDER BY LinePaletteSort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05837', GetDate())
GO
