IF OBJECT_ID(N'[dbo].[vwx_Planning_Style_SearchAdd_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Planning_Style_SearchAdd_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_Style_SearchAdd_SEL]
AS
SELECT sh.StyleID, sh.StyleMasterID, sh.StyleWorkflowID, sh.StyleType, sh.WorkflowType, sh.RefNo, sh.StyleNo, sh.TempID, 
	   sh.TempNo, sh.CustomerNo, sh.DevelopmentID, sh.DevelopmentNo, sh.ConceptID, sh.ConceptNo, sh.SpecNo, sh.Description, 
	   sh.StyleCategory, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   sh.StyleSet, sh.TechPackId, sh.TechPackDate, sh.DueDate, sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, 
	   sh.PatternMaker, sh.ProductionManager, sh.TechnicalDesigner, sh.StyleStatus, sh.StyleLocation, sh.WashType, sh.Pitch, 
       sh.MaterialID, sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialNo, sh.MaterialName, sh.POMTempGroupID1, 
	   sh.POMTempGroupID2, sh.POMTempGroupID3, sh.POMTempGroupID4, sh.POMTempID1, sh.POMTempVersion1, sh.POMTempSizeClass1, 
       sh.POMTempID2, sh.POMTempVersion2, sh.POMTempSizeClass2, sh.POMTempID3, sh.POMTempVersion3, sh.POMTempSizeClass3, 
	   sh.POMTempID4, sh.POMTempVersion4, sh.POMTempSizeClass4, sh.StyleMaterialID, sh.DesignSketchID, sh.TechSketchID, 
       sh.ConceptSketchID, sh.ColorSketchID, sh.DesignSketchVersion, sh.TechSketchVersion, sh.ConceptSketchVersion, 
	   sh.ColorSketchVersion, sh.DetailSketchID1, sh.DetailSketchID2, sh.DetailSketchID3, sh.DetailSketchID4, 
	   sh.DetailSketchVersion1, sh.DetailSketchVersion2, sh.DetailSketchVersion3, sh.DetailSketchVersion4, sh.SpecSketchID1, 
	   sh.SpecSketchID2, sh.SpecSketchID3, sh.SpecSketchID4, sh.SpecSketchVersion1, sh.SpecSketchVersion2, sh.SpecSketchVersion3, 
	   sh.SpecSketchVersion4, sh.Markup, sh.TargetPrice, sh.SellingPrice, sh.CustomField1, sh.CustomField2, sh.CustomField3, 
	   sh.CustomField4, sh.CustomField5, sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, 
	   sh.CustomField11, sh.CustomField12, sh.CustomField13, sh.CustomField14, sh.CustomField15, sh.Pc1, sh.Pc2, sh.Pc3, sh.Pc4, 
       sh.CUser, sh.CDate, sh.MUser, sh.MDate, sh.Active, sh.Change, sh.Action, sh.NoColorCombo, sh.StyleVersion, sh.StyleDetail, 
	   sh.StyleDetail1, sh.StyleAttribute, sh.StyleDetail2, sh.LinePlanSketchID, sh.LinePlanSketchVersion, sh.LinePlanID, sh.LinePlanNo, 
	   sh.CustomField16, sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, sh.CustomField21, sh.CustomField22, 
       sh.CustomField23, sh.CustomField24, sh.CustomField25, sh.CustomField26, sh.CustomField27, sh.CustomField28, sh.CustomField29, 
	   sh.CustomField30, sh.PackagingNo, sh.StyleCopyID, sh.LinePlanItemID, sh.StyleStatusID, sh.IntroSeasonYearID, sh.DivisionID, 
	   st.StyleTypeDescription, sc.StyleCategory AS Category, PlanningAttributes.PlanningID
					  --, bomCnt.BomCnt
FROM pStyleHeader sh
INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
INNER JOIN (
	SELECT vw.*, pd.PlanningID
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
	INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID
) AS PlanningAttributes ON sh.DivisionID = PlanningAttributes.DivisionID
	AND sh.StyleType = PlanningAttributes.StyleTypeID
	AND sh.StyleCategory = PlanningAttributes.StyleCategoryID
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId

--LEFT JOIN (
--	SELECT COUNT(wfi.WorkFlowItemID) as BomCnt, wfi.StyleID FROM pWorkFlowItem wfi
--	WHERE wfi.WorkflowID = '40000000-0000-0000-0000-000000000080'
--	GROUP BY wfi.StyleID
--) bomCnt ON sh.StyleID = bomCnt.StyleID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09450', GetDate())
GO
