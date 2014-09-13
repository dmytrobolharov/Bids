IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_FromLineFolders_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_FromLineFolders_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_FromLineFolders_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@LineFolderIDs NVARCHAR(MAX)
AS		
BEGIN

	DECLARE @LineLists TABLE(LineFolderID UNIQUEIDENTIFIER)
	INSERT INTO @LineLists(LineFolderID)
	SELECT value FROM dbo.fnx_Split(@LineFolderIDs, N',')
			
	;WITH LineLists AS (
		SELECT lf.*
		FROM @LineLists ll
		INNER JOIN pLineFolder lf ON ll.LineFolderID = lf.LinefolderID
	) SELECT pli.PlanningItemID
	FROM pPlanningItem pli
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN LineLists lf ON pli.PlanningID = lf.PlanningID AND ssy.SeasonYearID = lf.SeasonYearID
	INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID AND pli.StyleID = lfi.StyleID
	LEFT JOIN pLineFolder lf2 ON pli.PlanningID = lf2.PlanningID AND ssy.SeasonYearID = lf2.SeasonYearID
		AND lf2.LineFolderID NOT IN (SELECT LineFolderID FROM @LineLists)
	LEFT JOIN pLineFolderItem lfi2 ON lf2.LineFolderID = lfi2.LineFolderID AND lfi.StyleID = lfi2.StyleID
	WHERE pli.PlanningID = @PlanningID
	GROUP BY pli.PlanningItemID
	HAVING COUNT(lfi2.LineFolderItemID) = 0
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07762', GetDate())
GO
