/****** Object:  View [dbo].[vwx_PlanningItem_SELECT]    Script Date: 08/21/2014 15:20:50 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningItem_SELECT]'))
DROP VIEW [dbo].[vwx_PlanningItem_SELECT]
GO

/****** Object:  View [dbo].[vwx_PlanningItem_SELECT]    Script Date: 08/21/2014 15:20:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_PlanningItem_SELECT]
AS
SELECT     dbo.pPlanningItem.PlanningID, dbo.pPlanningItem.PlanningItemID, dbo.pPlanningItem.PlanningItemDrop, dbo.pPlanningItem.PlanningItemDropUser, 
                      dbo.pPlanningItem.PlanningItemDropDate, dbo.pPlanningItem.PlanningImageID, dbo.pPlanningItem.PlanningImageVersion, dbo.pPlanningItem.CUser, 
                      dbo.pPlanningItem.CDate, dbo.pPlanningItem.MUser, dbo.pPlanningItem.MDate, dbo.pPlanningItem.MChange, dbo.pStyleHeader.StyleID, 
                      dbo.pStyleHeader.DevelopmentNo + '*' + CAST(dbo.pStyleDevelopmentItem.Variation AS NVARCHAR(5)) AS ConceptNo, dbo.pStyleHeader.DevelopmentNo, 
                      dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField5 AS PatternRef, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.CustomField8 AS DMCStyleType, dbo.pStyleMaterials.F AS FabricYarnType, dbo.pStyleMaterials.MaterialName AS MainMaterial, 
                      dbo.pStyleMaterials.H AS [Content], dbo.pStyleMaterials.I AS FabricWeight, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.SizeClass, 
                      dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pPlanningItem.PlanningItemSort, 
                      dbo.pStyleHeader.StyleCategory AS StyleCategoryId, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.DueDate, 
                      dbo.pStyleHeader.RecDate, dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.IntroSeasonYearID, dbo.pPlanningItem.StyleSeasonYearID, 
                      dbo.pStyleSeasonYear.SeasonYearID AS ColorwaySeasonYearID, dbo.pStyleHeader.DivisionID, dbo.pStyleCategory.StyleCategory, c.TeamID, c.AccessRoleID, 
                      c.AccessModify, dbo.pStyleHeader.CustomField3, dbo.pStyleSeasonYear.SeasonYearID, dbo.pPlanningItem.StyleBOMDimensionID, 
                      dbo.pStyleHeader.SubCategoryId, '<img src="' + dbo.fnx_GetStreamingImagePathChangeLogReport(dbo.pStyleHeader.DesignSketchID, 
                      dbo.pStyleHeader.DesignSketchVersion, 50) + '" alt="" />' AS Image, dbo.iCustom1.Custom AS DivisionName, dbo.pStyleType.StyleTypeDescription, 
                      dbo.pStyleCategory.StyleCategory AS StyleCategoryName, ISNULL(dbo.pSeasonYear.Season, N'') + ' ' + ISNULL(dbo.pSeasonYear.Year, N'') AS IntroSeasonYear, 
                      '<a href="Planning_StyleProperty.aspx?SID=' + CAST(dbo.pStyleHeader.StyleID AS NVARCHAR(50)) 
                      + '&SYID=' + CAST(dbo.pStyleSeasonYear.SeasonYearID AS NVARCHAR(50)) + '&PIID=' + CAST(dbo.pPlanningItem.PlanningItemID AS NVARCHAR(50)) 
                      + '">' + dbo.pStyleHeader.StyleNo + '</a>' AS StylePropertyLink, dbo.pSubCategory.Custom AS SubCategoryName, dbo.pStyleHeader.DevelopmentID, 
                      dbo.pStyleHeader.Designer, dbo.pStyleHeader.TechnicalDesigner, dbo.pStyleHeader.ProductionManager, dbo.pStyleHeader.WashType, 
                      dbo.pStyleDevelopmentItem.Variation, dbo.pStyleHeader.DesignSketchBackID, dbo.pStyleHeader.DesignSketchBackVersion
FROM         dbo.pPlanningItem INNER JOIN
                      dbo.pStyleHeader ON dbo.pPlanningItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                      dbo.vwx_Permissions_ProductTypes AS c ON dbo.pStyleHeader.StyleType = c.IntProductTypeId AND c.PermissionFolderTypeId = 2 INNER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID INNER JOIN
                      dbo.pPlanning ON dbo.pPlanningItem.PlanningID = dbo.pPlanning.PlanningID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pPlanningItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleMaterials ON dbo.pStyleHeader.StyleID = dbo.pStyleMaterials.StyleID AND dbo.pStyleHeader.StyleSet = dbo.pStyleMaterials.StyleSet AND 
                      dbo.pStyleMaterials.MainMaterial = 1 LEFT OUTER JOIN
                      dbo.pSeasonYear ON dbo.pStyleHeader.IntroSeasonYearID = dbo.pSeasonYear.SeasonYearID LEFT OUTER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pStyleType ON dbo.pStyleHeader.StyleType = dbo.pStyleType.StyleTypeID LEFT OUTER JOIN
                      dbo.iCustom1 ON dbo.pStyleHeader.DivisionID = dbo.iCustom1.CustomID LEFT OUTER JOIN
                      dbo.pSubCategory ON dbo.pStyleHeader.SubCategoryId = CAST(dbo.pSubCategory.CustomID AS NVARCHAR(50))

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08914', GetDate())
GO

