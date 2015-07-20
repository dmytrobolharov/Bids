IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_Material_Color_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Material_Color_SELECT](
	@MaterialID UNIQUEIDENTIFIER,
	@SqlFilter NVARCHAR(MAX) = NULL,
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
)
AS 
BEGIN
	SELECT
		a.MaterialColorID, a.MaterialColorImageID, a.MaterialColorImageVersion, 
		a.MaterialColorNote,
		a.ColorCode, a.Sort, a.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
		b.ColorPaletteID, b.ColorFolderID, b.Hex, b.R, b.G, b.B, b.LAB_A, b.LAB_B, b.LAB_L
	INTO #tmp0
	FROM dbo.pMaterialColor a WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID

	DECLARE @sqlString  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, @SqlFilter)

	EXEC sp_executesql @sqlString
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09717', GetDate())
GO


