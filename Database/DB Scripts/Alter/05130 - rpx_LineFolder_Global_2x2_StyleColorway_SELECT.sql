IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Global_2x2_StyleColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Global_2x2_StyleColorway_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_Global_2x2_StyleColorway_SELECT] 
	@StyleID UNIQUEIDENTIFIER
	, @LineFolderItemID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT
		IDENTITY(INT, 0, 1) AS RowNum
		, lfic.StyleColorName
		, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID, sc.ColorPaletteID) AS ColorImagePath
	INTO #tmpStyleColorway
	FROM
		pLineFolderItemColor lfic
		INNER JOIN pStyleColorway sc ON lfic.StyleColorID = sc.StyleColorID
		INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
		INNER JOIN pLineFolder lf ON lfic.LineFolderID = lf.LineFolderID
	WHERE
		lfic.StyleID = @StyleID
		AND lfic.LineFolderItemID = @LineFolderItemID
		AND lfic.LineFolderItemColorDrop = 0	

	SELECT RowNum / 3 AS [Row], RowNum % 3 AS [Column], * FROM #tmpStyleColorway
	DROP TABLE #tmpStyleColorway
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05130', GetDate())
GO
