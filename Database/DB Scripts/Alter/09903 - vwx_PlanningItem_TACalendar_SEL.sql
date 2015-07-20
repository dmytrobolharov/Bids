IF OBJECT_ID(N'[dbo].[vwx_PlanningItem_TACalendar_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_PlanningItem_TACalendar_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningItem_TACalendar_SEL]
AS
SELECT pli.PlanningID, pli.PlanningItemID, pli.PlanningItemDrop, pli.PlanningItemDropUser, pli.PlanningItemDropDate, pli.PlanningImageID, 
       pli.PlanningImageVersion, pli.CUser, pli.CDate, pli.MUser, pli.MDate, pli.MChange, pli.StyleID, pli.ConceptNo, pli.DevelopmentNo, 
	   pli.StyleNo, pli.CustomField1, pli.PatternRef, pli.Description, pli.DMCStyleType, pli.FabricYarnType, pli.MainMaterial, pli.[Content], 
	   pli.FabricWeight, pli.SizeRangeId, pli.SizeRange, pli.SizeClassId, pli.SizeClass, pli.DesignSketchID, pli.DesignSketchVersion, 
       pli.PlanningItemSort, pli.StyleCategoryId, pli.StyleType, pli.WorkflowType, pli.DueDate, pli.RecDate, pli.TradePartnerID, pli.IntroSeasonYearID, 
	   pli.StyleSeasonYearID, pli.ColorwaySeasonYearID, pli.DivisionID, pli.StyleCategory, pli.TeamId, pli.AccessRoleId, pli.AccessModify, 
	   pli.CustomField3, pli.SeasonYearID, pli.StyleBOMDimensionID, pli.SubCategoryId, pli.Image, pli.DivisionName, pli.StyleTypeDescription, 
	   pli.StyleCategoryName, pli.IntroSeasonYear, pli.StylePropertyLink, pli.SubCategoryName, pli.DevelopmentID, pli.Designer, pli.TechnicalDesigner, 
	   pli.ProductionManager, pli.WashType, pli.Variation, pli.DesignSketchBackID, pli.DesignSketchBackVersion, pcal.PlanningTACalendarID
FROM dbo.vwx_PlanningItem_SELECT AS pli
INNER JOIN dbo.pTACalReference AS cr ON pli.StyleID = cr.ReferenceId
INNER JOIN dbo.pPlanningTACalendar AS pcal ON cr.TACalTemplateId = pcal.TACalTemplateID
	AND pli.PlanningID = pcal.PlanningID
	AND pli.SeasonYearID = pcal.SeasonYearID




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09903', GetDate())
GO
