/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_ColorSearch_SELECT]    Script Date: 04/30/2013 15:55:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_ColorSearch_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_ColorSearch_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_ColorSearch_SELECT]    Script Date: 04/30/2013 15:55:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_ColorSearch_SELECT]
	@SearchCondition NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	SET @SearchCondition = '%' + @SearchCondition + '%'
	
	;WITH Colors AS (
		SELECT ColorCode, ColorName, ColorSource, ColorPaletteID, ColorFolderID,
		ROW_NUMBER() OVER (PARTITION BY ColorCode, ColorName ORDER BY ColorPaletteID) AS RowNumber
		FROM pColorPalette
		WHERE ColorCode LIKE @SearchCondition OR ColorName LIKE @SearchCondition
	)
	SELECT * FROM Colors WHERE RowNumber = 1
	ORDER BY ColorCode, ColorName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05651', GetDate())
GO
