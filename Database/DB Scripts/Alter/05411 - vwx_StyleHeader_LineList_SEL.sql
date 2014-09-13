IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleHeader_LineList_SEL]'))
DROP VIEW [dbo].[vwx_StyleHeader_LineList_SEL]
GO


CREATE VIEW [dbo].[vwx_StyleHeader_LineList_SEL]
AS
SELECT     dbo.pStyleHeader.StyleID, dbo.pStyleHeader.WorkflowTemplateID, dbo.pStyleHeader.PlannedDueDate, dbo.pStyleHeader.EnforceDependency, 
                      dbo.pStyleHeader.ScheduleBy, dbo.pStyleHeader.PlannedStartDate, dbo.pStyleHeader.StartDate, dbo.pStyleHeader.OwnerGroup, 
                      dbo.pStyleHeader.DesignSketchBackVersion, dbo.pStyleHeader.DesignSketchBackID, dbo.pStyleHeader.UserMID, dbo.pStyleHeader.UserCID, 
                      dbo.pStyleHeader.Distribution, dbo.pStyleHeader.CustomField40, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField38, 
                      dbo.pStyleHeader.CustomField37, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField34, 
                      dbo.pStyleHeader.CustomField33, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.HeaderLocked, dbo.pStyleHeader.ProdDev, 
                      dbo.pStyleHeader.MaterialCoreID, dbo.pStyleHeader.StyleLinkID, dbo.pStyleHeader.TradePartnerVendorID, dbo.pStyleHeader.TradePartnerID, 
                      dbo.pStyleHeader.BodyID, dbo.pStyleHeader.StyleStatusID, dbo.pStyleHeader.LinePlanItemID, dbo.pStyleHeader.StyleCopyID, dbo.pStyleHeader.PackagingNo, 
                      dbo.pStyleHeader.CustomField30, dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, 
                      dbo.pStyleHeader.CustomField26, dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, 
                      dbo.pStyleHeader.CustomField22, dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, 
                      dbo.pStyleHeader.CustomField18, dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.LinePlanNo, dbo.pStyleHeader.LinePlanID, 
                      dbo.pStyleHeader.LinePlanSketchVersion, dbo.pStyleHeader.LinePlanSketchID, dbo.pStyleHeader.StyleDetail2, dbo.pStyleHeader.StyleAttribute, 
                      dbo.pStyleHeader.StyleDetail1, dbo.pStyleHeader.StyleDetail, dbo.pStyleHeader.StyleVersion, dbo.pStyleHeader.NoColorCombo, dbo.pStyleHeader.Action, 
                      dbo.pStyleHeader.Change, dbo.pStyleHeader.Active, dbo.pStyleHeader.MDate, dbo.pStyleHeader.MUser, dbo.pStyleHeader.CDate, dbo.pStyleHeader.CUser, 
                      dbo.pStyleHeader.Pc4, dbo.pStyleHeader.Pc3, dbo.pStyleHeader.Pc2, dbo.pStyleHeader.Pc1, dbo.pStyleHeader.CustomField15, dbo.pStyleHeader.CustomField14, 
                      dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField11, dbo.pStyleHeader.CustomField10, 
                      dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.SellingPrice, 
                      dbo.pStyleHeader.TargetPrice, dbo.pStyleHeader.Markup, dbo.pStyleHeader.SpecSketchVersion4, dbo.pStyleHeader.SpecSketchVersion3, 
                      dbo.pStyleHeader.SpecSketchVersion2, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchID3, 
                      dbo.pStyleHeader.SpecSketchID2, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.DetailSketchVersion3, 
                      dbo.pStyleHeader.DetailSketchVersion2, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchID3, 
                      dbo.pStyleHeader.DetailSketchID2, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.ConceptSketchVersion, 
                      dbo.pStyleHeader.TechSketchVersion, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.ConceptSketchID, 
                      dbo.pStyleHeader.TechSketchID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.StyleMaterialID, dbo.pStyleHeader.POMTempSizeClass4, 
                      dbo.pStyleHeader.POMTempVersion4, dbo.pStyleHeader.POMTempID4, dbo.pStyleHeader.POMTempSizeClass3, dbo.pStyleHeader.POMTempVersion3, 
                      dbo.pStyleHeader.POMTempID3, dbo.pStyleHeader.POMTempSizeClass2, dbo.pStyleHeader.POMTempVersion2, dbo.pStyleHeader.POMTempID2, 
                      dbo.pStyleHeader.POMTempSizeClass1, dbo.pStyleHeader.POMTempVersion1, dbo.pStyleHeader.POMTempID1, dbo.pStyleHeader.POMTempGroupID4, 
                      dbo.pStyleHeader.POMTempGroupID3, dbo.pStyleHeader.POMTempGroupID2, dbo.pStyleHeader.POMTempGroupID1, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.MaterialImageVersion, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.MaterialID, dbo.pStyleHeader.Pitch, 
                      dbo.pStyleHeader.WashType, dbo.pStyleHeader.StyleLocation, dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.TechnicalDesigner, 
                      dbo.pStyleHeader.ProductionManager, dbo.pStyleHeader.PatternMaker, dbo.pStyleHeader.SampleMaker, dbo.pStyleHeader.Designer, dbo.pStyleHeader.Buyer, 
                      dbo.pStyleHeader.Customer, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.TechPackDate, dbo.pStyleHeader.TechPackId, 
                      dbo.pStyleHeader.StyleSet, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.Description, dbo.pStyleHeader.SpecNo, dbo.pStyleHeader.ConceptNo, 
                      dbo.pStyleHeader.ConceptID, dbo.pStyleHeader.DevelopmentNo, dbo.pStyleHeader.DevelopmentID, dbo.pStyleHeader.CustomerNo, dbo.pStyleHeader.TempNo, 
                      dbo.pStyleHeader.TempID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.StyleWorkflowID, 
                      dbo.pStyleHeader.StyleMasterID, dbo.pStyleCategory.StyleCategory AS StyleCategoryName, dbo.pStyleType.StyleTypeDescription, 
                      dbo.vwx_SeasonYear_SEL.SeasonYear AS IntroSeasonYear, dbo.pSizeClass.Custom AS SizeClassName, dbo.pStyleHeader.IntroSeasonYearID, 
                      dbo.pStyleHeader.StyleType, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.DivisionID, dbo.pStyleHeader.StyleThemeID, 
                      dbo.pLineFolderItem.LineFolderID, dbo.pLineFolderItem.LineFolderItemID
FROM         dbo.pStyleHeader LEFT OUTER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pStyleType ON dbo.pStyleHeader.StyleType = dbo.pStyleType.StyleTypeID LEFT OUTER JOIN
                      dbo.pSizeClass ON dbo.pStyleHeader.SizeClass = dbo.pSizeClass.Custom LEFT OUTER JOIN
                      dbo.vwx_SeasonYear_SEL ON dbo.pStyleHeader.IntroSeasonYearID = dbo.vwx_SeasonYear_SEL.SeasonYearID LEFT OUTER JOIN
                      dbo.pLineFolderItem ON dbo.pStyleHeader.StyleID = dbo.pLineFolderItem.StyleID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05411', GetDate())
GO
