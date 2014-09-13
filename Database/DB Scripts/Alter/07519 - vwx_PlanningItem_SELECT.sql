IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningItem_SELECT]'))
DROP VIEW [dbo].[vwx_PlanningItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_PlanningItem_SELECT]
AS
SELECT     dbo.pPlanningItem.PlanningID, dbo.pPlanningItem.PlanningItemID, dbo.pPlanningItem.PlanningItemDrop, 
                      dbo.pPlanningItem.PlanningItemDropUser, dbo.pPlanningItem.PlanningItemDropDate, dbo.pPlanningItem.PlanningImageID, 
                      dbo.pPlanningItem.PlanningImageVersion, dbo.pPlanningItem.CUser, dbo.pPlanningItem.CDate, dbo.pPlanningItem.MUser, dbo.pPlanningItem.MDate, 
                      dbo.pPlanningItem.MChange, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentNo + '*' + CAST(dbo.pStyleDevelopmentItem.Variation AS NVARCHAR(5)) 
                      AS ConceptNo, dbo.pStyleHeader.DevelopmentNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField5 AS PatternRef, 
                      dbo.pStyleHeader.Description, dbo.pStyleHeader.CustomField8 AS DMCStyleType, dbo.pStyleMaterials.F AS FabricYarnType, 
                      dbo.pStyleMaterials.MaterialName AS MainMaterial, dbo.pStyleMaterials.H AS [Content], dbo.pStyleMaterials.I AS FabricWeight, dbo.pStyleHeader.SizeRange, 
                      dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.DesignSketchID, 
                      dbo.pStyleHeader.DesignSketchVersion, dbo.pPlanningItem.PlanningItemSort, dbo.pStyleHeader.StyleCategory as StyleCategoryId, dbo.pStyleHeader.StyleType, 
                      dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.IntroSeasonYearID, 
                      dbo.pPlanningItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID AS ColorwaySeasonYearID, dbo.pStyleHeader.DivisionID,
                      dbo.pStyleCategory.StyleCategory, c.TeamId, c.AccessRoleId, c.AccessModify, dbo.pStyleHeader.CustomField3,
                      dbo.pStyleSeasonYear.SeasonYearID, dbo.pPlanningItem.StyleBOMDimensionID,
                      dbo.pStyleHeader.SubCategoryId, 
                      '<img src="' + REPLACE(dbo.fnx_GetStreamingImageSmallPath(dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.DesignSketchVersion), 'S=500', 'S=50') + '" alt="" />' AS [Image]
FROM dbo.pPlanningItem
INNER JOIN dbo.pStyleHeader ON dbo.pPlanningItem.StyleID = dbo.pStyleHeader.StyleID
INNER JOIN (
	SELECT AccessRoleId, AccessModify, TeamId, StyleTypeId
	FROM dbo.sAccessStyleFolder) AS c ON dbo.pStyleHeader.StyleType = c.StyleTypeId
INNER JOIN dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID
INNER JOIN dbo.pPlanning ON dbo.pPlanningItem.PlanningID = dbo.pPlanning.PlanningID
LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pPlanningItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
LEFT OUTER JOIN dbo.pStyleMaterials ON dbo.pStyleHeader.StyleID = dbo.pStyleMaterials.StyleID
	AND dbo.pStyleHeader.StyleSet = dbo.pStyleMaterials.StyleSet
	AND dbo.pStyleMaterials.MainMaterial = 1
INNER JOIN dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07519', GetDate())
GO