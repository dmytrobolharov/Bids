IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleHeader_SEL]'))
DROP VIEW [dbo].[vwx_StyleHeader_SEL]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vwx_StyleHeader_SEL]
AS
SELECT sh.StyleID, sh.StyleMasterID, sh.StyleWorkflowID, sh.StyleType, sh.WorkflowType, sh.RefNo, sh.StyleNo, sh.TempID, 
       sh.TempNo, sh.CustomerNo, sh.DevelopmentID, sh.DevelopmentNo, sh.ConceptID, sh.ConceptNo, sh.SpecNo, sh.Description, 
	   sh.StyleCategory, sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sh.SizeRangeId, 
	   COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.StyleSet, sh.TechPackId, sh.TechPackDate, sh.DueDate, 
	   sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, sh.PatternMaker, sh.ProductionManager, sh.TechnicalDesigner, 
	   sh.StyleStatus, sh.StyleLocation, sh.WashType, sh.Pitch, sh.MaterialID, sh.MaterialImageID, sh.MaterialImageVersion, 
	   sh.MaterialNo, sh.MaterialName, sh.POMTempGroupID1, sh.POMTempGroupID2, sh.POMTempGroupID3, sh.POMTempGroupID4, 
	   sh.POMTempID1, sh.POMTempVersion1, sh.POMTempSizeClass1, sh.POMTempID2, sh.POMTempVersion2, sh.POMTempSizeClass2, 
	   sh.POMTempID3, sh.POMTempVersion3, sh.POMTempSizeClass3, sh.POMTempID4, sh.POMTempVersion4, sh.POMTempSizeClass4, 
	   sh.StyleMaterialID, sh.DesignSketchID, sh.DesignSketchBackID, sh.TechSketchID, sh.ConceptSketchID, sh.ColorSketchID, 
	   sh.DesignSketchVersion, sh.DesignSketchBackVersion, sh.TechSketchVersion, sh.ConceptSketchVersion, sh.ColorSketchVersion, 
	   sh.DetailSketchID1, sh.DetailSketchID2, sh.DetailSketchID3, sh.DetailSketchID4, sh.DetailSketchVersion1, 
	   sh.DetailSketchVersion2, sh.DetailSketchVersion3, sh.DetailSketchVersion4, sh.SpecSketchID1, sh.SpecSketchID2, 
	   sh.SpecSketchID3, sh.SpecSketchID4, sh.SpecSketchVersion1, sh.SpecSketchVersion2, sh.SpecSketchVersion3, sh.SpecSketchVersion4, 
	   sh.Markup, sh.TargetPrice, sh.SellingPrice, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.CustomField5, 
	   sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11, sh.CustomField12, 
	   sh.CustomField13, sh.CustomField14, sh.CustomField15, sh.Pc1, sh.Pc2, sh.Pc3, sh.Pc4, sh.CUser, sh.CDate, sh.MUser, sh.MDate, 
	   sh.Active, sh.Change, sh.Action, sh.NoColorCombo, sh.StyleVersion, sh.StyleDetail, sh.StyleDetail1, sh.StyleDetail2, 
	   sh.StyleAttribute, sh.LinePlanID, sh.LinePlanNo, sh.LinePlanSketchID, sh.LinePlanSketchVersion, sh.CustomField16, 
	   sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, sh.CustomField21, sh.CustomField22, sh.CustomField23, 
	   sh.CustomField24, sh.CustomField25, sh.CustomField26, sh.CustomField27, sh.CustomField28, sh.CustomField29, sh.CustomField30, 
	   sh.PackagingNo, sh.StyleCopyID, sh.LinePlanItemID, sh.StyleStatusID, sh.BodyID, sh.TradePartnerID, sh.TradePartnerVendorID, 
	   sy.Year, sy.Season, sh.HeaderLocked, ssy.StyleSeasonYearID, ssy.SeasonYearID, sh.IntroSeasonYearID, sh.StyleLinkID, sh.OwnerGroup, 
	   sh.UserCID, sh.UserMID, sh.DivisionID, sh.StyleThemeID, stt.IsSilhouette, isy.Season AS IntroSeason, isy.Year AS IntroYear, 
	   sh.SubCategoryId, st.StyleTypeDescription, d.Custom AS DivisionName,  sc.StyleCategory AS StyleCategoryName, 
	   ssc.Custom AS SubCategoryName, ISNULL(isy.Season, N'') + ' ' + ISNULL(isy.Year, N'') AS IntroSeasonYearName, 
	   '<img src="' + dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion, 50) + '" alt="" />' AS Image, 
	   sy.Season + ' ' + sy.Year AS StyleSeasonYear
FROM pStyleHeader sh
LEFT JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID 
LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID 
LEFT JOIN pSeasonYear isy ON isy.SeasonYearID = sh.IntroSeasonYearID 
LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID 
LEFT JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID 
LEFT JOIN iCustom1 d ON sh.DivisionID = d.CustomID 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN pSubCategory ssc ON sh.SubCategoryId = CAST(ssc.CustomID AS NVARCHAR(50))
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10082', GetUTCDate())
GO