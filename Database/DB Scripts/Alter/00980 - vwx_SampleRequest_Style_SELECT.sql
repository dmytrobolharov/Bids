


/****** Object:  View [dbo].[vwx_SampleRequest_Style_SELECT]    Script Date: 01/13/2011 18:06:58 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[vwx_SampleRequest_Style_SELECT]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwx_SampleRequest_Style_SELECT]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[vwx_SampleRequest_Style_SELECT]') AND OBJECTPROPERTY(id, N'IsView') = 1)
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwx_SampleRequest_Style_SELECT]
AS
SELECT     TOP (100) PERCENT a.StyleID, a.StyleMasterID, a.StyleWorkflowID, a.StyleType, a.WorkflowType, a.RefNo, a.StyleNo, a.TempID, a.TempNo, a.CustomerNo, 
                      a.DevelopmentID, a.DevelopmentNo, a.ConceptID, a.ConceptNo, a.SpecNo, a.Description, a.StyleCategory, a.SizeClass, a.SizeRange, a.StyleSet, a.TechPackId, 
                      a.TechPackDate, a.DueDate, a.RecDate, a.Customer, a.Buyer, a.Designer, a.SampleMaker, a.PatternMaker, a.ProductionManager, a.TechnicalDesigner, a.StyleStatus, 
                      a.StyleLocation, a.WashType, a.Pitch, a.MaterialID, a.MaterialImageID, a.MaterialImageVersion, a.MaterialNo, a.MaterialName, a.POMTempGroupID1, 
                      a.POMTempGroupID2, a.POMTempGroupID3, a.POMTempGroupID4, a.POMTempID1, a.POMTempVersion1, a.POMTempSizeClass1, a.POMTempID2, 
                      a.POMTempVersion2, a.POMTempSizeClass2, a.POMTempID3, a.POMTempVersion3, a.POMTempSizeClass3, a.POMTempID4, a.POMTempVersion4, 
                      a.POMTempSizeClass4, a.StyleMaterialID, a.DesignSketchID, a.TechSketchID, a.ConceptSketchID, a.ColorSketchID, a.DesignSketchVersion, a.TechSketchVersion, 
                      a.ConceptSketchVersion, a.ColorSketchVersion, a.DetailSketchID1, a.DetailSketchID2, a.DetailSketchID3, a.DetailSketchID4, a.DetailSketchVersion1, 
                      a.DetailSketchVersion2, a.DetailSketchVersion3, a.DetailSketchVersion4, a.SpecSketchID1, a.SpecSketchID2, a.SpecSketchID3, a.SpecSketchID4, 
                      a.SpecSketchVersion1, a.SpecSketchVersion2, a.SpecSketchVersion3, a.SpecSketchVersion4, a.Markup, a.TargetPrice, a.SellingPrice, a.CustomField1, 
                      a.CustomField2, a.CustomField3, a.CustomField4, a.CustomField5, a.CustomField6, a.CustomField7, a.CustomField8, a.CustomField9, a.CustomField10, 
                      a.CustomField11, a.CustomField12, a.CustomField13, a.CustomField14, a.CustomField15, a.Pc1, a.Pc2, a.Pc3, a.Pc4, a.CUser, a.CDate, a.MUser, a.MDate, a.Active, 
                      a.Change, a.Action, a.NoColorCombo, a.StyleVersion, a.StyleDetail, a.StyleDetail1, a.StyleAttribute, a.StyleDetail2, a.LinePlanSketchID, a.LinePlanSketchVersion, 
                      a.LinePlanID, a.LinePlanNo, a.CustomField16, a.CustomField17, a.CustomField18, a.CustomField19, a.CustomField20, a.CustomField21, a.CustomField22, 
                      a.CustomField23, a.CustomField24, a.CustomField25, a.CustomField26, a.CustomField27, a.CustomField28, a.CustomField29, a.CustomField30, a.PackagingNo, 
                      a.StyleCopyID, a.LinePlanItemID, a.StyleStatusID, a.BodyID, a.TradePartnerID, a.TradePartnerVendorID, a.HeaderLocked
                      -- , a.ReportingGroup
                      , a.StyleLinkID, 
                      a.MaterialCoreID, b.StyleSeasonYearID, c.Season, c.Year, b.SeasonYearID, ISNULL(dbo.pStyleDevelopmentItem.StyleDevelopmentName, 
                      dbo.pStyleDevelopmentItem.Variation) AS Variation
FROM         dbo.pStyleHeader AS a INNER JOIN
                      dbo.pStyleSeasonYear AS b ON b.StyleID = a.StyleID INNER JOIN
                      dbo.pSeasonYear AS c ON c.SeasonYearID = b.SeasonYearID INNER JOIN
                      dbo.pStyleDevelopmentItem ON a.StyleID = dbo.pStyleDevelopmentItem.StyleID
ORDER BY c.Year DESC, c.Season, Variation
' 
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '00980', GetDate())
GO