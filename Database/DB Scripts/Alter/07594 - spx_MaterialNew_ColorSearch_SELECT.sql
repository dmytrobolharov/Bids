IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNew_ColorSearch_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNew_ColorSearch_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialNew_ColorSearch_SELECT]
	@SearchCondition NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER
AS
BEGIN
	SET @SearchCondition = '%' + @SearchCondition + '%'
	
	;WITH Colors AS (
		SELECT ColorCode, ColorName, ColorSource, ColorPaletteID, ColorFolderID,
		ROW_NUMBER() OVER (PARTITION BY ColorCode, ColorName ORDER BY ColorPaletteID) AS RowNumber
		FROM pColorPalette
		WHERE (ColorCode LIKE @SearchCondition OR ColorName LIKE @SearchCondition) AND NOT ColorPaletteID IN (SELECT ColorPaletteID FROM tmpMaterialColor WHERE MaterialID = @MaterialID )
	)
	SELECT * FROM Colors WHERE RowNumber = 1
	ORDER BY ColorName, ColorCode
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07594', GetDate())
GO
