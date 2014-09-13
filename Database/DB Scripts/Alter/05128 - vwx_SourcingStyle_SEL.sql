/****** Object:  View [dbo].[vwx_SourcingStyle_SEL]    Script Date: 02/26/2013 15:31:57 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingStyle_SEL]'))
DROP VIEW [dbo].[vwx_SourcingStyle_SEL]
GO

/****** Object:  View [dbo].[vwx_SourcingStyle_SEL]    Script Date: 02/26/2013 15:31:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_SourcingStyle_SEL]
AS
SELECT     dbo.pSourcingStyle.SourcingStyleID, dbo.pSourcingStyle.SourcingHeaderID, dbo.pSourcingStyle.StyleID, dbo.pSourcingStyle.Styleset, dbo.pSourcingStyle.Progress, 
                      dbo.pSourcingStyle.Complexity, dbo.pSourcingStyle.Priority, dbo.pSourcingStyle.Active, dbo.pSourcingStyle.CUser, dbo.pSourcingStyle.CDate, 
                      dbo.pSourcingStyle.MUser, dbo.pSourcingStyle.MDate, dbo.pSourcingStyle.Custom1, dbo.pSourcingStyle.Custom2, dbo.pSourcingStyle.Custom4, 
                      dbo.pSourcingStyle.Custom5, dbo.pSourcingStyle.Custom3, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.StyleMasterID, dbo.pStyleHeader.StyleWorkflowID, 
                      dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.TempID, dbo.pStyleHeader.TempNo, 
                      dbo.pStyleHeader.CustomerNo, dbo.pStyleHeader.DevelopmentID, dbo.pStyleHeader.DevelopmentNo, dbo.pStyleHeader.ConceptID, dbo.pStyleHeader.ConceptNo, 
                      dbo.pStyleHeader.SpecNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeRange, 
                      dbo.pStyleHeader.TechPackId, dbo.pStyleHeader.TechPackDate, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.Customer, 
                      dbo.pStyleHeader.Buyer, dbo.pStyleHeader.Designer, dbo.pStyleHeader.SampleMaker, dbo.pStyleHeader.PatternMaker, dbo.pStyleHeader.ProductionManager, 
                      dbo.pStyleHeader.TechnicalDesigner, dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.StyleLocation, dbo.pStyleHeader.WashType, dbo.pStyleHeader.Pitch, 
                      dbo.pStyleHeader.MaterialID, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.MaterialImageVersion, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.POMTempGroupID1, dbo.pStyleHeader.POMTempGroupID2, dbo.pStyleHeader.POMTempGroupID3, 
                      dbo.pStyleHeader.POMTempGroupID4, dbo.pStyleHeader.POMTempVersion1, dbo.pStyleHeader.POMTempID1, dbo.pStyleHeader.POMTempSizeClass1, 
                      dbo.pStyleHeader.POMTempID2, dbo.pStyleHeader.POMTempVersion2, dbo.pStyleHeader.POMTempSizeClass2, dbo.pStyleHeader.POMTempID3, 
                      dbo.pStyleHeader.POMTempVersion3, dbo.pStyleHeader.POMTempID4, dbo.pStyleHeader.POMTempSizeClass3, dbo.pStyleHeader.POMTempVersion4, 
                      dbo.pStyleHeader.POMTempSizeClass4, dbo.pStyleHeader.StyleMaterialID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ConceptSketchID, dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ConceptSketchVersion, dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, 
                      dbo.pStyleHeader.DetailSketchID3, dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, 
                      dbo.pStyleHeader.SpecSketchVersion2, dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, 
                      dbo.pStyleHeader.SpecSketchID2, dbo.pStyleHeader.TargetPrice, dbo.pStyleHeader.SpecSketchVersion4, dbo.pStyleHeader.Markup, dbo.pStyleHeader.SellingPrice, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField9, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField11, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField13, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField15, dbo.pStyleHeader.Pc1, dbo.pStyleHeader.Pc3, dbo.pStyleHeader.Pc2, dbo.pStyleHeader.Pc4, 
                      dbo.pStyleHeader.StyleVersion, dbo.pStyleHeader.StyleDetail, dbo.pStyleHeader.StyleDetail1, dbo.pStyleHeader.StyleAttribute, dbo.pStyleHeader.StyleDetail2, 
                      dbo.pStyleHeader.LinePlanSketchID, dbo.pStyleHeader.LinePlanSketchVersion, dbo.pStyleHeader.LinePlanID, dbo.pStyleHeader.LinePlanNo, 
                      dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField18, dbo.pStyleHeader.CustomField19, 
                      dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField22, dbo.pStyleHeader.CustomField23, 
                      dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField26, dbo.pStyleHeader.CustomField27, 
                      dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField30, dbo.pStyleHeader.PackagingNo, 
                      dbo.pStyleHeader.StyleCopyID, dbo.pStyleHeader.LinePlanItemID, dbo.pStyleHeader.StyleStatusID, dbo.pStyleHeader.BodyID, dbo.pStyleHeader.TradePartnerID, 
                      dbo.pStyleHeader.TradePartnerVendorID, dbo.pStyleHeader.StyleLinkID, dbo.pStyleHeader.MaterialCoreID, dbo.pStyleHeader.ProdDev, 
                      dbo.pStyleHeader.HeaderLocked, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField34, 
                      dbo.pStyleHeader.CustomField33, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, 
                      dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40, dbo.pStyleHeader.Distribution, dbo.pStyleHeader.UserCID, 
                      dbo.pStyleHeader.IntroSeasonYearID, dbo.pStyleHeader.UserMID, dbo.pStyleHeader.DesignSketchBackID, dbo.pStyleHeader.DesignSketchBackVersion, 
                      dbo.pStyleHeader.OwnerGroup, dbo.pStyleHeader.StartDate, dbo.pStyleHeader.PlannedDueDate, dbo.pStyleHeader.PlannedStartDate, dbo.pStyleHeader.ScheduleBy, 
                      dbo.pStyleHeader.EnforceDependency, dbo.pStyleHeader.WorkflowTemplateID, dbo.pSeasonYear.SeasonYearID, dbo.pSeasonYear.Year, dbo.pSeasonYear.Season, 
                      ISNULL(dbo.pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(dbo.pStyleDevelopmentItem.Variation AS Varchar(2))) AS Variation
FROM         dbo.pSourcingStyle INNER JOIN
                      dbo.pStyleHeader ON dbo.pStyleHeader.StyleID = dbo.pSourcingStyle.StyleID LEFT OUTER JOIN
                      dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleHeader.IntroSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleHeader.StyleID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05128', GetDate())
GO