IF OBJECT_ID(N'[dbo].[vwx_MaterialGroupWhere_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialGroupWhere_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialGroupWhere_SEL]
AS
SELECT a.StyleID, a.StyleSeasonYearID, a.StyleSeason, a.StyleYear, FOO.MaterialCoreID, b.StyleID AS Expr1, b.StyleMasterID, b.StyleWorkflowID, b.StyleType, 
       b.WorkflowType, b.RefNo, b.StyleNo, b.TempID, b.TempNo, b.CustomerNo, b.DevelopmentID, b.DevelopmentNo, b.ConceptID, b.ConceptNo, b.SpecNo, b.Description, 
       b.StyleCategory, b.SizeClassId, COALESCE(sc.Custom, b.SizeClass) AS SizeClass, b.SizeRangeId, COALESCE(sr.SizeRangeCode, b.SizeRange) AS SizeRange, 
	   b.StyleSet, b.TechPackId, b.TechPackDate, b.DueDate, b.RecDate, b.Customer, b.Buyer, b.Designer, b.SampleMaker, b.PatternMaker, b.ProductionManager, 
	   b.TechnicalDesigner, b.StyleStatus, b.StyleLocation, b.WashType, b.Pitch, b.MaterialID, b.MaterialImageID, b.MaterialImageVersion, b.MaterialNo, 
	   b.MaterialName, b.POMTempGroupID1, b.POMTempGroupID2, b.POMTempGroupID3, b.POMTempGroupID4, b.POMTempID1, b.POMTempVersion1, b.POMTempSizeClass1, 
	   b.POMTempID2, b.POMTempVersion2, b.POMTempSizeClass2, b.POMTempID3, b.POMTempVersion3, b.POMTempSizeClass3, b.POMTempID4, b.POMTempVersion4, 
	   b.POMTempSizeClass4, b.StyleMaterialID, b.DesignSketchID, b.TechSketchID, b.ConceptSketchID, b.ColorSketchID, b.DesignSketchVersion, b.TechSketchVersion, 
	   b.ConceptSketchVersion, b.ColorSketchVersion, b.DetailSketchID1, b.DetailSketchID2, b.DetailSketchID3, b.DetailSketchID4, b.DetailSketchVersion1, 
	   b.DetailSketchVersion2, b.DetailSketchVersion3, b.DetailSketchVersion4, b.SpecSketchID1, b.SpecSketchID2, b.SpecSketchID3, b.SpecSketchID4, 
	   b.SpecSketchVersion1, b.SpecSketchVersion2, b.SpecSketchVersion3, b.SpecSketchVersion4, b.Markup, b.TargetPrice, b.SellingPrice, b.CustomField1, 
	   b.CustomField2, b.CustomField3, b.CustomField4, b.CustomField5, b.CustomField6, b.CustomField7, b.CustomField8, b.CustomField9, b.CustomField10, 
	   b.CustomField11, b.CustomField12, b.CustomField13, b.CustomField14, b.CustomField15, b.Pc1, b.Pc2, b.Pc3, b.Pc4, b.CUser, b.CDate, b.MUser, b.MDate, 
	   b.Active, b.Change, b.Action, b.NoColorCombo, b.StyleVersion, b.StyleDetail, b.StyleDetail1, b.StyleAttribute, b.StyleDetail2, b.LinePlanSketchID, 
	   b.LinePlanSketchVersion, b.LinePlanID, b.LinePlanNo, b.CustomField16, b.CustomField17, b.CustomField18, b.CustomField19, b.CustomField20, 
       b.CustomField21, b.CustomField22, b.CustomField23, b.CustomField24, b.CustomField25, b.CustomField26, b.CustomField27, b.CustomField28, b.CustomField29, 
       b.CustomField30, b.PackagingNo, b.StyleCopyID, b.LinePlanItemID, b.StyleStatusID, b.BodyID, b.TradePartnerID, b.TradePartnerVendorID, b.StyleLinkID, 
       b.MaterialCoreID AS Expr2, b.ProdDev, b.HeaderLocked, b.CustomField31, b.CustomField32, b.CustomField33, b.CustomField34, b.CustomField35, b.CustomField36, 
       b.CustomField37, b.CustomField38, b.CustomField39, b.CustomField40, b.Distribution, b.IntroSeasonYearID, b.UserCID, b.UserMID, b.DesignSketchBackID, 
       b.DesignSketchBackVersion, b.OwnerGroup, b.StartDate, b.PlannedDueDate, b.PlannedStartDate, b.ScheduleBy, b.EnforceDependency, b.WorkflowTemplateID, 
       b.DivisionID, b.StyleThemeID, b.SubCategoryId, a.StyleSeason AS Season, a.StyleYear AS Year, a.SeasonYearID
FROM (SELECT b.StyleID, a.MaterialCoreID
      FROM pMaterialCoreItem AS a 
	  INNER JOIN pStyleMaterials AS b ON a.MaterialCoreItemID = b.MaterialCoreItemID
      UNION
      SELECT b.StyleID, a.MaterialCoreID
      FROM pMaterialCoreItem AS a 
	  INNER JOIN pStyleMaterials AS b ON b.StyleMaterialLinkID = a.MaterialCoreItemID) AS FOO 
INNER JOIN pStyleHeader AS b ON FOO.StyleID = b.StyleID 
INNER JOIN pStyleSeasonYear AS a ON a.StyleID = b.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = b.SizeRangeId



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09896', GetDate())
GO
