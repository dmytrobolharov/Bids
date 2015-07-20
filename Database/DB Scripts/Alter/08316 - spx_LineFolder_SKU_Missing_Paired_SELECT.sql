IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKU_Missing_Paired_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKU_Missing_Paired_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKU_Missing_Paired_SELECT]
(
	@LineFolderID UNIQUEIDENTIFIER
	, @LineFolderSKUHeaderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		lfi.LineFolderItemID
	FROM
		pLineFolderItem lfi
		INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID
		INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = lf.SeasonYearID
		INNER JOIN pLineFolderSKUHeader lfsh ON lfi.LineFolderID = lfsh.LineFolderID
		INNER JOIN vwx_LineFolderSKUHeader_StyleSKU_Matching_SEL vsku ON lfsh.LineFolderSKUHeaderID = vsku.LineFolderSKUHeaderID AND lfi.StyleID = vsku.StyleID
	WHERE
		lfi.LineFolderItemDrop = 'No'
		AND lfi.LineFolderID = @LineFolderID
		AND lfsh.LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	GROUP BY
		lfi.LineFolderItemID
	HAVING SUM(CASE WHEN vsku.StyleSKUHeaderID IS NOT NULL THEN 1 ELSE 0 END) = 0
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08316', GetDate())
GO
