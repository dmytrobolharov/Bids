IF OBJECT_ID(N'[dbo].[vwx_SourcingStyle_StyleHeader_QuickQuote_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SourcingStyle_StyleHeader_QuickQuote_SEL]
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_StyleHeader_QuickQuote_SEL]
AS
SELECT sh.StyleID, sh.StyleMasterID, sh.StyleWorkflowID, sh.StyleType, sh.WorkflowType, sh.RefNo, sh.StyleNo, 
       sh.WorkflowTemplateID, sh.EnforceDependency, sh.ScheduleBy, sh.PlannedStartDate, sh.PlannedDueDate, sh.StartDate, 
	   sh.OwnerGroup, sh.DesignSketchBackVersion, sh.DesignSketchBackID, sh.UserMID, sh.UserCID, sh.Distribution, 
	   sh.CustomField40, sh.CustomField39, sh.CustomField38, sh.CustomField37, sh.CustomField36, sh.CustomField35, 
	   sh.CustomField34, sh.CustomField33, sh.CustomField32, sh.CustomField31, sh.HeaderLocked, sh.ProdDev, sh.MaterialCoreID, 
	   sh.StyleLinkID, sh.TradePartnerVendorID, sh.TradePartnerID, sh.BodyID, sh.StyleStatusID, sh.LinePlanItemID, sh.StyleCopyID, 
	   sh.PackagingNo, sh.CustomField30, sh.CustomField29, sh.CustomField28, sh.CustomField27, sh.CustomField26, sh.CustomField25, 
	   sh.CustomField24, sh.CustomField23, sh.CustomField22, sh.CustomField21, sh.CustomField20, sh.CustomField19, sh.CustomField18, 
	   sh.CustomField17, sh.CustomField16, sh.LinePlanNo, sh.LinePlanID, sh.LinePlanSketchVersion, sh.LinePlanSketchID, sh.StyleDetail2, 
	   sh.StyleAttribute, sh.StyleDetail1, sh.StyleDetail, sh.StyleVersion, sh.NoColorCombo, sh.Action, sh.Change, sh.Active, sh.MDate, 
	   sh.MUser, sh.CDate, sh.CUser, sh.Pc4, sh.Pc3, sh.Pc2, sh.Pc1, sh.CustomField15, sh.CustomField14, sh.CustomField13, 
	   sh.CustomField12, sh.CustomField11, sh.CustomField10, sh.CustomField9, sh.CustomField8, sh.CustomField7, sh.CustomField6, 
	   sh.CustomField5, sh.CustomField4, sh.CustomField3, sh.CustomField2, sh.CustomField1, sh.SellingPrice, sh.TargetPrice, sh.Markup, 
	   sh.SpecSketchVersion4, sh.SpecSketchVersion3, sh.SpecSketchVersion2, sh.SpecSketchVersion1, sh.SpecSketchID4, sh.SpecSketchID3, 
       sh.SpecSketchID2, sh.SpecSketchID1, sh.DetailSketchVersion4, sh.DetailSketchVersion3, sh.DetailSketchVersion2, sh.DetailSketchVersion1, 
	   sh.DetailSketchID4, sh.DetailSketchID3, sh.DetailSketchID2, sh.DetailSketchID1, sh.ColorSketchVersion, sh.ConceptSketchVersion, 
       sh.TechSketchVersion, sh.DesignSketchVersion, sh.ColorSketchID, sh.ConceptSketchID, sh.TechSketchID, sh.DesignSketchID, sh.StyleMaterialID, 
	   sh.POMTempSizeClass4, sh.POMTempVersion4, sh.POMTempID4, sh.POMTempSizeClass3, sh.POMTempVersion3, sh.POMTempID3, sh.POMTempSizeClass2, 
	   sh.POMTempVersion2, sh.POMTempID2, sh.POMTempSizeClass1, sh.POMTempVersion1, sh.POMTempID1, sh.POMTempGroupID4, sh.POMTempGroupID3, 
	   sh.POMTempGroupID2, sh.POMTempGroupID1, sh.MaterialName, sh.MaterialNo, sh.MaterialImageVersion, sh.MaterialImageID, sh.MaterialID, 
	   sh.Pitch, sh.WashType, sh.StyleLocation, sh.StyleStatus, sh.TechnicalDesigner, sh.ProductionManager, sh.PatternMaker, sh.SampleMaker, 
	   sh.Designer, sh.Buyer, sh.Customer, sh.RecDate, sh.DueDate, sh.TechPackDate, sh.TechPackId, sh.StyleSet, 
       sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
	   sh.StyleCategory, sh.Description, sh.SpecNo, sh.ConceptNo, sh.ConceptID, sh.DevelopmentNo, sh.DevelopmentID, sh.CustomerNo, sh.TempNo, 
	   sh.TempID, ssy.SeasonYearID, sy.Season, sy.Year, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVarchar(2))) AS Variation, 
	   sh.IntroSeasonYearID, ISNULL(sh.DivisionID, '00000000-0000-0000-0000-000000000000') AS DivisionID, sc.StyleCategory as StyleCategoryName,
       /* fields for Quick quote grid columns */
       NULL as StyleQuoteItemId, NULL as StyleCostingType, NULL as StyleCostingScenarioItemID, NULL as StyleColorID, NULL as TechPack,
       NULL as StyleQuoteItemCustomField16, ISNULL(TaCal.TACalTemplateId, '00000000-0000-0000-0000-000000000000') AS CalendarID
FROM pStyleHeader sh
LEFT JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID 
LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID 
LEFT JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = sh.StyleID 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
LEFT JOIN (SELECT ct.TACalTemplateId, cr.ReferenceId, ct.SeasonYearId 
		   FROM pTACalTemplate ct 
		   INNER JOIN pTACalReference cr ON ct.TACalTemplateId = cr.TACalTemplateId AND cr.TACalReferenceTypeId = 2
		  ) AS TaCal ON TaCal.SeasonYearId = sy.SeasonYearID AND TACal.ReferenceId = sh.StyleID




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09906', GetDate())
GO
