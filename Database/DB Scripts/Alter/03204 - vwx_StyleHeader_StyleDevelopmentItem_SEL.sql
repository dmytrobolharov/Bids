
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwx_StyleHeader_StyleDevelopmentItem_SEL'))
DROP VIEW vwx_StyleHeader_StyleDevelopmentItem_SEL
GO


CREATE VIEW vwx_StyleHeader_StyleDevelopmentItem_SEL
AS
	SELECT pStyleHeader.StyleID, pStyleHeader.StyleMasterID, pStyleHeader.StyleWorkflowID, pStyleHeader.StyleType, pStyleHeader.WorkflowType, 
      pStyleHeader.RefNo, pStyleHeader.StyleNo, pStyleHeader.TempID, pStyleHeader.TempNo, pStyleHeader.CustomerNo, 
      pStyleHeader.DevelopmentID, pStyleHeader.DevelopmentNo, pStyleHeader.ConceptID, pStyleHeader.ConceptNo, pStyleHeader.SpecNo, 
      pStyleHeader.Description, pStyleHeader.StyleCategory, pStyleHeader.SizeClass, pStyleHeader.SizeRange, pStyleHeader.StyleSet, 
      pStyleHeader.TechPackId, pStyleHeader.TechPackDate, pStyleHeader.DueDate, pStyleHeader.RecDate, pStyleHeader.Customer, 
      pStyleHeader.Buyer, pStyleHeader.Designer, pStyleHeader.SampleMaker, pStyleHeader.PatternMaker, pStyleHeader.ProductionManager, 
      pStyleHeader.TechnicalDesigner, pStyleHeader.StyleStatus, pStyleHeader.StyleLocation, pStyleHeader.WashType, pStyleHeader.Pitch, 
      pStyleHeader.MaterialID, pStyleHeader.MaterialImageID, pStyleHeader.MaterialImageVersion, pStyleHeader.MaterialNo, 
      pStyleHeader.MaterialName, pStyleHeader.POMTempGroupID1, pStyleHeader.POMTempGroupID2, pStyleHeader.POMTempGroupID3, 
      pStyleHeader.POMTempGroupID4, pStyleHeader.POMTempID1, pStyleHeader.POMTempVersion1, pStyleHeader.POMTempSizeClass1, 
      pStyleHeader.POMTempID2, pStyleHeader.POMTempVersion2, pStyleHeader.POMTempSizeClass2, pStyleHeader.POMTempID3, 
      pStyleHeader.POMTempVersion3, pStyleHeader.POMTempSizeClass3, pStyleHeader.POMTempID4, pStyleHeader.POMTempVersion4, 
      pStyleHeader.POMTempSizeClass4, pStyleHeader.StyleMaterialID, pStyleHeader.DesignSketchID, pStyleHeader.TechSketchID, 
      pStyleHeader.ConceptSketchID, pStyleHeader.ColorSketchID, pStyleHeader.DesignSketchVersion, pStyleHeader.TechSketchVersion, 
      pStyleHeader.ConceptSketchVersion, pStyleHeader.ColorSketchVersion, pStyleHeader.DetailSketchID1, pStyleHeader.DetailSketchID2, 
      pStyleHeader.DetailSketchID3, pStyleHeader.DetailSketchID4, pStyleHeader.DetailSketchVersion1, pStyleHeader.DetailSketchVersion2, 
      pStyleHeader.DetailSketchVersion3, pStyleHeader.DetailSketchVersion4, pStyleHeader.SpecSketchID1, pStyleHeader.SpecSketchID2, 
      pStyleHeader.SpecSketchID3, pStyleHeader.SpecSketchID4, pStyleHeader.SpecSketchVersion1, pStyleHeader.SpecSketchVersion2, 
      pStyleHeader.SpecSketchVersion3, pStyleHeader.SpecSketchVersion4, pStyleHeader.Markup, pStyleHeader.TargetPrice, 
      pStyleHeader.SellingPrice, pStyleHeader.CustomField1, pStyleHeader.CustomField2, pStyleHeader.CustomField3, pStyleHeader.CustomField4, 
      pStyleHeader.CustomField5, pStyleHeader.CustomField6, pStyleHeader.CustomField7, pStyleHeader.CustomField8, pStyleHeader.CustomField9,
      pStyleHeader.CustomField10, pStyleHeader.CustomField11, pStyleHeader.CustomField12, pStyleHeader.CustomField13, 
      pStyleHeader.CustomField14, pStyleHeader.CustomField15, pStyleHeader.Pc1, pStyleHeader.Pc2, pStyleHeader.Pc3, pStyleHeader.Pc4, 
      pStyleHeader.CUser, pStyleHeader.CDate, pStyleHeader.MUser, pStyleHeader.MDate, pStyleHeader.Active, pStyleHeader.Change, 
      pStyleHeader.Action, pStyleHeader.NoColorCombo, pStyleHeader.StyleVersion, pStyleHeader.StyleDetail, pStyleHeader.StyleDetail1, 
      pStyleHeader.StyleAttribute, pStyleHeader.StyleDetail2, pStyleHeader.LinePlanSketchID, pStyleHeader.LinePlanSketchVersion, 
      pStyleHeader.LinePlanID, pStyleHeader.LinePlanNo, pStyleHeader.CustomField16, pStyleHeader.CustomField17, pStyleHeader.CustomField18, 
      pStyleHeader.CustomField19, pStyleHeader.CustomField20, pStyleHeader.CustomField21, pStyleHeader.CustomField22, 
      pStyleHeader.CustomField23, pStyleHeader.CustomField24, pStyleHeader.CustomField25, pStyleHeader.CustomField26, 
      pStyleHeader.CustomField27, pStyleHeader.CustomField28, pStyleHeader.CustomField29, pStyleHeader.CustomField30, 
      pStyleHeader.PackagingNo, pStyleHeader.StyleCopyID, pStyleHeader.LinePlanItemID, pStyleHeader.StyleStatusID, pStyleHeader.BodyID, 
      pStyleHeader.TradePartnerID, pStyleHeader.TradePartnerVendorID, pStyleHeader.StyleLinkID, pStyleHeader.MaterialCoreID, 
      pStyleHeader.ProdDev, pStyleHeader.HeaderLocked, pStyleHeader.CustomField31, pStyleHeader.CustomField32, pStyleHeader.CustomField33, 
      pStyleHeader.CustomField34, pStyleHeader.CustomField35, pStyleHeader.CustomField36, pStyleHeader.CustomField37, 
      pStyleHeader.CustomField38, pStyleHeader.CustomField39, pStyleHeader.CustomField40, pStyleHeader.Distribution, 
      pStyleHeader.IntroSeasonYearID, pStyleHeader.OwnerGroup 
FROM  pStyleHeader INNER JOIN
      pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID	 

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03204'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03204', GetDate())
END
GO	
