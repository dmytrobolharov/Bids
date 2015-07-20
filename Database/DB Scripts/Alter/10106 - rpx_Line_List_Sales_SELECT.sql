IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Line_List_Sales_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Line_List_Sales_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Line_List_Sales_SELECT]
	@LineFolderID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @SeasonYearID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS
BEGIN
	IF @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	DECLARE @tmpLineLists TABLE (LineFolderID UNIQUEIDENTIFIER)
	INSERT INTO @tmpLineLists VALUES (@LineFolderID)
	IF @LineFolderID = '00000000-0000-0000-0000-000000000000'
		INSERT INTO @tmpLineLists SELECT LineFolderID FROM pLineFolder WHERE Active = 1

	SELECT
		(DENSE_RANK() OVER (ORDER BY lf.LineFolderDescription, sh.StyleNo, m.MaterialNo/*, sqi.StyleQuoteItemNo*/)-1) / 4 AS Row
		, (DENSE_RANK() OVER (ORDER BY lf.LineFolderDescription, sh.StyleNo, m.MaterialNo/*, sqi.StyleQuoteItemNo*/)-1) % 4 AS Col
		, lf.LineFolderDescription
		, sh.Description
		, sh.StyleNo
		, sh.SizeRange
		, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion, 2000) AS StyleImage
		, ISNULL(sb.MaterialName, '') + ' (' + sb.MaterialNo + ')' AS Material
		, m.B
		, (ROW_NUMBER () OVER(PARTITION BY lf.LineFolderDescription, sh.StyleNo, m.MaterialNo ORDER BY lf.LineFolderDescription, sh.StyleNo, m.MaterialNo, cp.ColorName)-1) / 8 AS ColorRow
		, (ROW_NUMBER () OVER(PARTITION BY lf.LineFolderDescription, sh.StyleNo, m.MaterialNo ORDER BY lf.LineFolderDescription, sh.StyleNo, m.MaterialNo, cp.ColorName)-1) % 8 AS ColorCol
		, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID, cp.ColorPaletteID, '100') AS ColorImage
		, cp.ColorName
	FROM pLineFolder lf
		INNER JOIN @tmpLineLists ll ON lf.LineFolderID = ll.LineFolderID
		INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID
		INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
		LEFT JOIN pStyleBOM sb INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID ON lfi.StyleBOMDimensionID = sb.StyleBOMDimensionId AND sb.MainMaterial = 1
		LEFT JOIN pStyleColorwaySeasonyear scs
			LEFT JOIN pStyleColorway sc ON scs.StyleColorwayID = sc.StyleColorID
			INNER JOIN pColorPalette cp ON ISNULL(scs.ColorPaletteID, sc.ColorPaletteID) = cp.ColorPaletteID
			INNER JOIN pStyleSeasonYear ssy ON scs.StyleSeasonYearID = ssy.StyleSeasonYearID
		ON sh.StyleID = scs.StyleID AND ssy.SeasonYearID = @SeasonYearID
		LEFT JOIN pStyleColorwayStatus st ON scs.StyleColorStatus = st.StatusID
		--LEFT JOIN pStyleQuoteItem sqi ON lfi.StyleID = sqi.StyleID AND ssy.StyleSeasonYearID = sqi.StyleSeasonYearID
	WHERE lf.SeasonYearID = @SeasonYearID
END




GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10106', GetUTCDate())
GO