IF OBJECT_ID(N'[dbo].[vwx_Planning_DroppedStyles_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Planning_DroppedStyles_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_DroppedStyles_SEL]
AS
SELECT lf.LineFolderID, lfi.LineFolderItemID, lf.LineFolderDescription, lf.SeasonYearID, lfi.StyleSeasonYearID, lfi.StyleBOMDimensionID, 
	   lfi.LineFolderItemDrop, pli.PlanningItemDrop, CASE lfi.LineFolderItemDrop WHEN 'Yes' THEN 'No' ELSE 'Yes' END AS LineFolderItemActive, 
	   p.PlanningID, p.PlanningName, sh.StyleID, sh.StyleMasterID, sh.StyleWorkflowID, sh.StyleType, sh.WorkflowType, sh.RefNo, sh.StyleNo, sh.TempID, 
	   sh.TempNo, sh.CustomerNo, sh.DevelopmentID, sh.DevelopmentNo, sh.ConceptID, sh.ConceptNo, sh.SpecNo, sh.Description, sh.StyleCategory, 
	   sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   sh.StyleSet, sh.TechPackId, sh.TechPackDate, 
	   sh.DueDate, sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, sh.PatternMaker, sh.ProductionManager, sh.TechnicalDesigner, sh.StyleStatus, 
	   sh.StyleLocation, sh.WashType, sh.Pitch, sh.MaterialID, sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialNo, sh.MaterialName, sh.POMTempGroupID1, 
	   sh.POMTempGroupID2, sh.POMTempGroupID3, sh.POMTempGroupID4, sh.POMTempID1, sh.POMTempVersion1, sh.POMTempSizeClass1, sh.POMTempID2, sh.POMTempVersion2, 
	   sh.POMTempSizeClass2, sh.POMTempID3, sh.POMTempVersion3, sh.POMTempSizeClass3, sh.POMTempID4, sh.POMTempVersion4, sh.POMTempSizeClass4, sh.StyleMaterialID, 
	   sh.DesignSketchID, sh.TechSketchID, sh.ConceptSketchID, sh.ColorSketchID, sh.DesignSketchVersion, sh.TechSketchVersion, sh.ConceptSketchVersion, 
	   sh.ColorSketchVersion, sh.DetailSketchID1, sh.DetailSketchID2, sh.DetailSketchID3, sh.DetailSketchID4, sh.DetailSketchVersion1, sh.DetailSketchVersion2, 
	   sh.DetailSketchVersion3, sh.DetailSketchVersion4, sh.SpecSketchID1, sh.SpecSketchID2, sh.SpecSketchID3, sh.SpecSketchID4, sh.SpecSketchVersion1, 
	   sh.SpecSketchVersion2, sh.SpecSketchVersion3, sh.SpecSketchVersion4, sh.Markup, sh.TargetPrice, sh.SellingPrice, sh.CustomField1, sh.CustomField2, 
	   sh.CustomField3, sh.CustomField4, sh.CustomField5, sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11, 
	   sh.CustomField12, sh.CustomField13, sh.CustomField14, sh.CustomField15, sh.Pc1, sh.Pc2, sh.Pc3, sh.Pc4, sh.CUser, sh.CDate, sh.MUser, sh.MDate, sh.Active, 
	   sh.Change, sh.Action, sh.NoColorCombo, sh.StyleVersion, sh.StyleDetail, sh.StyleDetail1, sh.StyleAttribute, sh.StyleDetail2, sh.LinePlanSketchID, 
	   sh.LinePlanSketchVersion, sh.LinePlanID, sh.LinePlanNo, sh.CustomField16, sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, sh.CustomField21, 
	   sh.CustomField22, sh.CustomField23, sh.CustomField24, sh.CustomField25, sh.CustomField26, sh.CustomField27, sh.CustomField28, sh.CustomField29, sh.CustomField30, 
	   sh.PackagingNo, sh.StyleCopyID, sh.LinePlanItemID, sh.StyleStatusID, sh.BodyID, sh.TradePartnerID, sh.TradePartnerVendorID, sh.StyleLinkID, sh.MaterialCoreID, 
	   sh.ProdDev, sh.HeaderLocked, sh.CustomField31, sh.CustomField32, sh.CustomField33, sh.CustomField34, sh.CustomField35, sh.CustomField36, sh.CustomField37, 
	   sh.CustomField38, sh.CustomField39, sh.CustomField40, sh.Distribution, sh.IntroSeasonYearID, sh.UserCID, sh.UserMID, sh.DesignSketchBackID, 
	   sh.DesignSketchBackVersion, sh.OwnerGroup, sh.StartDate, sh.PlannedDueDate, sh.PlannedStartDate, sh.ScheduleBy, sh.EnforceDependency, sh.WorkflowTemplateID, 
	   sh.DivisionID, sh.StyleThemeID, sh.SubCategoryId, d.Custom AS Division, st.StyleTypeDescription, sc.StyleCategory AS Category, asf.TeamId
FROM dbo.pLineFolderItem AS lfi 
INNER JOIN dbo.pStyleHeader AS sh ON lfi.StyleID = sh.StyleID 
INNER JOIN dbo.iCustom1 AS d ON sh.DivisionID = d.CustomID 
INNER JOIN dbo.pStyleType AS st ON sh.StyleType = st.StyleTypeID 
INNER JOIN dbo.pStyleCategory AS sc ON sh.StyleCategory = sc.StyleCategoryId 
INNER JOIN dbo.pLineFolder AS lf ON lfi.LineFolderID = lf.LineFolderID 
INNER JOIN dbo.pPlanning AS p ON lf.PlanningID = p.PlanningID 
INNER JOIN dbo.pPlanningItem AS pli 
	INNER JOIN dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID 
ON p.PlanningID = pli.PlanningID AND 
	lf.SeasonYearID = ssy.SeasonYearID AND 
	lfi.StyleID = pli.StyleID AND 
	lfi.LineFolderItemDrop <> pli.PlanningItemDrop 
INNER JOIN vwx_Permissions_ProductTypes asf ON asf.IntProductTypeId = sh.StyleType AND asf.PermissionFolderTypeId = 2
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (asf.AccessRoleId = 3) OR (asf.AccessView = 1)



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09897', GetDate())
GO
