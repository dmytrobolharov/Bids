IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKU_Mismatching_BOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKU_Mismatching_BOM_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKU_Mismatching_BOM_SELECT]
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
		INNER JOIN pWorkFlowItem wfi ON lfi.StyleSeasonYearID = wfi.StyleSeasonYearID
		INNER JOIN pStyleSKUItem ssh ON wfi.WorkFlowItemID = ssh.WorkflowItemID AND lfsh.LineFolderSKUHeaderID = ssh.LineFolderSKUHeaderID
	WHERE
		lfi.LineFolderItemDrop = 'No'
		AND lfi.LineFolderID = @LineFolderID
		AND lfsh.LineFolderSKUHeaderID = @LineFolderSKUHeaderID
		AND lfi.StyleBOMDimensionID != ssh.StyleBOMDimensionID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08314', GetDate())
GO
