IF OBJECT_ID(N'[dbo].[vwx_PlanningItem_MissingCalendar_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_PlanningItem_MissingCalendar_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningItem_MissingCalendar_SEL]
AS
SELECT pli.PlanningID, pli.PlanningItemID, pli.PlanningItemDrop, pli.PlanningItemDropUser, pli.PlanningItemDropDate, pli.PlanningImageID, 
       pli.PlanningImageVersion, pli.CUser, pli.CDate, pli.MUser, pli.MDate, pli.MChange, pli.StyleID, pli.ConceptNo, pli.DevelopmentNo, 
	   pli.StyleNo, pli.CustomField1, pli.PatternRef, pli.Description, pli.DMCStyleType, pli.FabricYarnType, pli.MainMaterial, pli.[Content], 
	   pli.FabricWeight, pli.SizeRangeId, pli.SizeRange, pli.SizeClassId, pli.SizeClass, pli.DesignSketchID, pli.DesignSketchVersion, 
	   pli.PlanningItemSort, pli.StyleCategoryId, pli.StyleType, pli.WorkflowType, pli.DueDate, pli.RecDate, pli.TradePartnerID, 
	   pli.IntroSeasonYearID, pli.StyleSeasonYearID, pli.ColorwaySeasonYearID, pli.DivisionID, pli.StyleCategory, pli.TeamId, pli.AccessRoleId, 
	   pli.AccessModify, pli.CustomField3, pli.SeasonYearID, pli.StyleBOMDimensionID, pli.SubCategoryId, pli.Image, pli.DivisionName, 
	   pli.StyleTypeDescription, pli.StyleCategoryName, pli.IntroSeasonYear, pli.StylePropertyLink, pli.SubCategoryName, pli.DevelopmentID, 
	   pli.Designer, pli.TechnicalDesigner, pli.ProductionManager, pli.WashType, pli.Variation, pli.DesignSketchBackID, pli.DesignSketchBackVersion, 
	   pcal.PlanningTACalendarID, pcal.TACalTemplateID
FROM dbo.vwx_PlanningItem_SELECT AS pli
INNER JOIN dbo.pPlanningTACalendar AS pcal ON pli.PlanningID = pcal.PlanningID
	AND pli.SeasonYearID = pcal.SeasonYearID
WHERE EXISTS (
		SELECT TACalTemplateDivisionID FROM dbo.pTACalTemplateDivision AS cd
		WHERE pcal.TACalTemplateID = TACalTemplateID AND pli.DivisionID = DivisionID) 
	AND NOT EXISTS(
		SELECT TACalReferenceId FROM dbo.pTACalReference AS cr 
		WHERE pli.StyleID = ReferenceId)



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09902', GetDate())
GO
