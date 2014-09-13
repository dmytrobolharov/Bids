IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Global_2x2_StyleColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Global_2x2_StyleColorway_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_Global_2x2_StyleColorway_SELECT] 
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT
		IDENTITY(INT, 0, 1) AS RowNum
		, sc.StyleColorName
		, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID, sc.ColorPaletteID) AS ColorImagePath
	INTO #tmpStyleColorway
	FROM
		pStyleColorway sc
		INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
	WHERE
		sc.StyleID = @StyleID

	SELECT RowNum / 3 AS [Row], RowNum % 3 AS [Column], * FROM #tmpStyleColorway
	DROP TABLE #tmpStyleColorway
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05203', GetDate())
GO
