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

	SELECT lfi.LineFolderItemID
	FROM pLineFolderItem lfi
	INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID
	INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = lf.SeasonYearID
	INNER JOIN pLineFolderSKUHeader lfsh ON lfi.LineFolderID = lfsh.LineFolderID
	LEFT JOIN pStyleSKUItem ssi ON lfi.StyleBOMDimensionID = ssi.StyleBOMDimensionID AND lfsh.LineFolderSKUHeaderID = ssi.LineFolderSKUHeaderID
	WHERE lfi.LineFolderID = @LineFolderID
		AND lfsh.LineFolderSKUHeaderID = @LineFolderSKUHeaderID
		AND lfi.LineFolderItemDrop = 'No'
		AND ssi.StyleSKUItemID IS NULL

END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10404', GetUTCDate())
GO
