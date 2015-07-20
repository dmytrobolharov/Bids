/****** Object:  StoredProcedure [dbo].[spx_MaterialNew_ColorSearch_SELECT]    Script Date: 05/23/2013 17:16:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNew_ColorSearch_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNew_ColorSearch_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_MaterialNew_ColorSearch_SELECT]    Script Date: 05/23/2013 17:16:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	ORDER BY ColorCode, ColorName
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05743', GetDate())
GO