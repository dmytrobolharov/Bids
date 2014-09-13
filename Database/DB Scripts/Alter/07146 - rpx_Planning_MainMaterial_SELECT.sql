IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Planning_MainMaterial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Planning_MainMaterial_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Planning_MainMaterial_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
)
AS

SELECT
	sh.StyleID, sh.StyleNo, sh.[Description]
	, dbo.fnx_GetStreamingImagePath(c.ImageID, c.[Version]) AS FilePath
	, c.ImageHistoryID, pi.PlanningItemID, pi.PlanningItemDrop, pi.PlanningItemDropUser, pi.PlanningItemDropDate, sh.SizeClass, sh.SizeRange
	,STUFF(
	(SELECT ', ' + sb.MaterialNo FROM
		(SELECT DISTINCT sb.MaterialNo FROM pStyleBOM sb
			INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID AND wi.StyleSeasonYearID = pi.StyleSeasonYearID
		WHERE sb.StyleBOMDimensionId = pi.StyleBOMDimensionID AND sb.MainMaterial = 1) sb
	FOR XML PATH('')), 1, 2, '') AS MaterialNo
	, sh.DivisionID
	, sh.StyleType
	, sh.StyleCategory
	, ISNULL(sh.SubCategoryId, '00000000-0000-0000-0000-000000000000') AS SubCategoryId
FROM pPlanningItem pi
	INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
	INNER JOIN pStyleHeader sh ON pi.StyleID = sh.StyleID
	LEFT OUTER JOIN hImage c ON sh.DesignSketchID = c.ImageID
							AND sh.DesignSketchVersion = c.Version
WHERE pi.PlanningID = @PlanningID
ORDER BY
	pi.PlanningItemSort
	, sh.StyleNo
	, sh.Description
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07146', GetDate())
GO
