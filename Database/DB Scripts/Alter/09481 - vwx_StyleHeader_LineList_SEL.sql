IF OBJECT_ID(N'[dbo].[vwx_StyleHeader_LineList_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_StyleHeader_LineList_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleHeader_LineList_SEL]
AS
SELECT sh.StyleID, sh.WorkflowTemplateID, sh.PlannedDueDate, sh.EnforceDependency, sh.ScheduleBy, sh.PlannedStartDate, 
	   sh.StartDate, sh.OwnerGroup, sh.DesignSketchBackVersion, sh.DesignSketchBackID, sh.UserMID, sh.UserCID, sh.Distribution, 
	   sh.CustomField40, sh.CustomField39, sh.CustomField38, sh.CustomField37, sh.CustomField36, sh.CustomField35, sh.CustomField34, 
       sh.CustomField33, sh.CustomField32, sh.CustomField31, sh.HeaderLocked, sh.ProdDev, sh.MaterialCoreID, sh.StyleLinkID, 
	   sh.TradePartnerVendorID, sh.TradePartnerID, sh.BodyID, sh.StyleStatusID, sh.LinePlanItemID, sh.StyleCopyID, sh.PackagingNo, 
       sh.CustomField30, sh.CustomField29, sh.CustomField28, sh.CustomField27, sh.CustomField26, sh.CustomField25, sh.CustomField24, 
	   sh.CustomField23, sh.CustomField22, sh.CustomField21, sh.CustomField20, sh.CustomField19, sh.CustomField18, sh.CustomField17, 
	   sh.CustomField16, sh.LinePlanNo, sh.LinePlanID, sh.LinePlanSketchVersion, sh.LinePlanSketchID, sh.StyleDetail2, sh.StyleAttribute, 
       sh.StyleDetail1, sh.StyleDetail, sh.StyleVersion, sh.NoColorCombo, sh.Action, sh.Change, sh.Active, sh.MDate, sh.MUser, sh.CDate, 
	   sh.CUser, sh.Pc4, sh.Pc3, sh.Pc2, sh.Pc1, sh.CustomField15, sh.CustomField14, sh.CustomField13, sh.CustomField12, sh.CustomField11, 
	   sh.CustomField10, sh.CustomField9, sh.CustomField8, sh.CustomField7, sh.CustomField6, sh.CustomField5, sh.CustomField4, 
	   sh.CustomField3, sh.CustomField2, sh.CustomField1, sh.SellingPrice, sh.TargetPrice, sh.Markup, sh.SpecSketchVersion4, 
	   sh.SpecSketchVersion3, sh.SpecSketchVersion2, sh.SpecSketchVersion1, sh.SpecSketchID4, sh.SpecSketchID3, sh.SpecSketchID2, 
	   sh.SpecSketchID1, sh.DetailSketchVersion4, sh.DetailSketchVersion3, sh.DetailSketchVersion2, sh.DetailSketchVersion1, 
	   sh.DetailSketchID4, sh.DetailSketchID3, sh.DetailSketchID2, sh.DetailSketchID1, sh.ColorSketchVersion, sh.ConceptSketchVersion, 
       sh.TechSketchVersion, sh.DesignSketchVersion, sh.ColorSketchID, sh.ConceptSketchID, sh.TechSketchID, sh.DesignSketchID, 
	   sh.StyleMaterialID, sh.POMTempSizeClass4, sh.POMTempVersion4, sh.POMTempID4, sh.POMTempSizeClass3, sh.POMTempVersion3, 
       sh.POMTempID3, sh.POMTempSizeClass2, sh.POMTempVersion2, sh.POMTempID2, sh.POMTempSizeClass1, sh.POMTempVersion1, sh.POMTempID1, 
	   sh.POMTempGroupID4, sh.POMTempGroupID3, sh.POMTempGroupID2, sh.POMTempGroupID1, sh.MaterialName, sh.MaterialNo, 
	   sh.MaterialImageVersion, sh.MaterialImageID, sh.MaterialID, sh.Pitch, sh.WashType, sh.StyleLocation, sh.StyleStatus, 
	   sh.TechnicalDesigner, sh.ProductionManager, sh.PatternMaker, sh.SampleMaker, sh.Designer, sh.Buyer, sh.Customer, sh.RecDate, 
	   sh.DueDate, sh.TechPackDate, sh.TechPackId, sh.StyleSet, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   sh.Description, sh.SpecNo, sh.ConceptNo, sh.ConceptID, sh.DevelopmentNo, sh.DevelopmentID, sh.CustomerNo, sh.TempNo, 
       sh.TempID, sh.StyleNo, sh.RefNo, sh.WorkflowType, sh.StyleWorkflowID, sh.StyleMasterID, sc.StyleCategory AS StyleCategoryName, 
	   st.StyleTypeDescription, sy.SeasonYear AS IntroSeasonYear, scc.Custom AS SizeClassName, sh.IntroSeasonYearID, sh.StyleType, 
	   sh.StyleCategory, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sh.DivisionID, sh.StyleThemeID, lfi.LineFolderID, 
	   lfi.LineFolderItemID
FROM pStyleHeader sh 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID 
LEFT JOIN pSizeClass scc ON (sh.SizeClassId IS NOT NULL AND scc.CustomID = sh.SizeClassId) OR 
                            (sh.SizeClassId IS NULL AND scc.Custom = sh.SizeClass)
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
LEFT JOIN vwx_SeasonYear_SEL sy ON sh.IntroSeasonYearID = sy.SeasonYearID 
LEFT JOIN pLineFolderItem lfi ON sh.StyleID = lfi.StyleID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09481', GetDate())
GO
