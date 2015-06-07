IF OBJECT_ID(N'[dbo].[rpx_Planning_MainMaterial_SELECT]') IS NOT NULL
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
	, c.ImageHistoryID, pi.PlanningItemID, pi.PlanningItemDrop, pi.PlanningItemDropUser, pi.PlanningItemDropDate
	, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
	, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
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
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE pi.PlanningID = @PlanningID
ORDER BY
	pi.PlanningItemSort
	, sh.StyleNo
	, sh.Description

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09603', GetDate())
GO
