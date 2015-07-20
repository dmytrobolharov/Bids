IF OBJECT_ID(N'[dbo].[vwx_PlanningItem_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_PlanningItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_PlanningItem_SELECT]
AS
SELECT pi.PlanningID, pi.PlanningItemID, pi.PlanningItemDrop, pi.PlanningItemDropUser, pi.PlanningItemDropDate, pi.PlanningImageID, 
       pi.PlanningImageVersion, pi.CUser, pi.CDate, pi.MUser, pi.MDate, pi.MChange, sh.StyleID, 
	   sh.DevelopmentNo + '*' + CAST(sdi.Variation AS NVARCHAR(5)) AS ConceptNo, 
	   sh.DevelopmentNo, sh.StyleNo, sh.CustomField1, sh.CustomField5 AS PatternRef, sh.Description, sh.CustomField8 AS DMCStyleType, 
	   sm.F AS FabricYarnType, sm.MaterialName AS MainMaterial, sm.H AS [Content], sm.I AS FabricWeight, 
	   sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
       sh.DesignSketchID, sh.DesignSketchVersion, pi.PlanningItemSort, sh.StyleCategory AS StyleCategoryId, 
	   sh.StyleType, sh.WorkflowType, sh.DueDate, sh.RecDate, sh.TradePartnerID, sh.IntroSeasonYearID, 
	   pi.StyleSeasonYearID, ssy.SeasonYearID AS ColorwaySeasonYearID, sh.DivisionID, sc.StyleCategory, 
	   perm.TeamId, perm.AccessRoleId, perm.AccessModify, sh.CustomField3, ssy.SeasonYearID, pi.StyleBOMDimensionID, 
       sh.SubCategoryId, '<img src="' + dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, 
       sh.DesignSketchVersion, 50) + '" alt="" />' AS Image, d.Custom AS DivisionName, st.StyleTypeDescription, 
       sc.StyleCategory AS StyleCategoryName, ISNULL(sy.Season, N'') + ' ' + ISNULL(sy.Year, N'') AS IntroSeasonYear, 
       '<a href="Planning_StyleProperty.aspx?SID=' + CAST(sh.StyleID AS NVARCHAR(50)) 
       + '&SYID=' + CAST(ssy.SeasonYearID AS NVARCHAR(50)) + '&PIID=' + CAST(pi.PlanningItemID AS NVARCHAR(50)) 
       + '">' + sh.StyleNo + '</a>' AS StylePropertyLink, ssc.Custom AS SubCategoryName, sh.DevelopmentID, 
       sh.Designer, sh.TechnicalDesigner, sh.ProductionManager, sh.WashType, sdi.Variation,
       sh.DesignSketchBackID, sh.DesignSketchBackVersion
FROM pPlanningItem pi 
INNER JOIN pStyleHeader sh ON pi.StyleID = sh.StyleID 
INNER JOIN vwx_Permissions_ProductTypes AS perm ON sh.StyleType = perm.IntProductTypeId AND perm.PermissionFolderTypeId = 2 
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID 
INNER JOIN pPlanning pl ON pi.PlanningID = pl.PlanningID 
LEFT JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID 
LEFT JOIN pStyleMaterials sm ON sh.StyleID = sm.StyleID AND sh.StyleSet = sm.StyleSet AND sm.MainMaterial = 1 
LEFT JOIN pSeasonYear sy ON sh.IntroSeasonYearID = sy.SeasonYearID 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID 
LEFT JOIN iCustom1 d ON sh.DivisionID = d.CustomID 
LEFT JOIN pSubCategory ssc ON sh.SubCategoryId = CAST(ssc.CustomID AS NVARCHAR(50))
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09901', GetDate())
GO
