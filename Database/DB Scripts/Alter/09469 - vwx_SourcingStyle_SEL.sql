IF OBJECT_ID(N'[dbo].[vwx_SourcingStyle_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SourcingStyle_SEL]
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_SEL]
AS
SELECT ss.SourcingStyleID, ss.SourcingHeaderID, ss.StyleID, ss.Styleset, ss.Progress, ss.Complexity, ss.Priority, ss.Active, 
	   ss.CUser, ss.CDate, ss.MUser, ss.MDate, ss.Custom1, ss.Custom2, ss.Custom4, ss.Custom5, ss.Custom3, sh.StyleType, 
	   sh.StyleMasterID, sh.StyleWorkflowID, sh.WorkflowType, sh.RefNo, sh.StyleNo, sh.TempID, sh.TempNo, sh.CustomerNo, 
	   sh.DevelopmentID, sh.DevelopmentNo, sh.ConceptID, sh.ConceptNo, sh.SpecNo, sh.Description,
	   COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sh.StyleCategory, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sh.TechPackId, sh.TechPackDate, sh.DueDate, sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, sh.PatternMaker, 
	   sh.ProductionManager, sh.TechnicalDesigner, sh.StyleStatus, sh.StyleLocation, sh.WashType, sh.Pitch, sh.MaterialID, 
	   sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialName, sh.MaterialNo, sh.POMTempGroupID1, sh.POMTempGroupID2, 
	   sh.POMTempGroupID3, sh.POMTempGroupID4, sh.POMTempVersion1, sh.POMTempID1, sh.POMTempSizeClass1, sh.POMTempID2, 
	   sh.POMTempVersion2, sh.POMTempSizeClass2, sh.POMTempID3, sh.POMTempVersion3, sh.POMTempID4, sh.POMTempSizeClass3, 
	   sh.POMTempVersion4, sh.POMTempSizeClass4, sh.StyleMaterialID, sh.DesignSketchID, sh.TechSketchID, sh.ConceptSketchID, 
	   sh.ColorSketchID, sh.DesignSketchVersion, sh.TechSketchVersion, sh.ConceptSketchVersion, sh.ColorSketchVersion, 
	   sh.DetailSketchID1, sh.DetailSketchID2, sh.DetailSketchID3, sh.DetailSketchID4, sh.DetailSketchVersion1, 
	   sh.DetailSketchVersion2, sh.DetailSketchVersion3, sh.SpecSketchID3, sh.SpecSketchID4, sh.SpecSketchVersion1, 
       sh.SpecSketchVersion2, sh.SpecSketchVersion3, sh.DetailSketchVersion4, sh.SpecSketchID1, sh.SpecSketchID2, sh.TargetPrice, 
	   sh.SpecSketchVersion4, sh.Markup, sh.SellingPrice, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, 
	   sh.CustomField5, sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11, 
	   sh.CustomField12, sh.CustomField13, sh.CustomField14, sh.CustomField15, sh.Pc1, sh.Pc3, sh.Pc2, sh.Pc4, sh.StyleVersion, 
	   sh.StyleDetail, sh.StyleDetail1, sh.StyleAttribute, sh.StyleDetail2, sh.LinePlanSketchID, sh.LinePlanSketchVersion, 
	   sh.LinePlanID, sh.LinePlanNo, sh.CustomField16, sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, 
	   sh.CustomField21, sh.CustomField22, sh.CustomField23, sh.CustomField25, sh.CustomField24, sh.CustomField26, sh.CustomField27,
	   sh.CustomField28, sh.CustomField29, sh.CustomField30, sh.PackagingNo, sh.StyleCopyID, sh.LinePlanItemID, sh.StyleStatusID, 
	   sh.BodyID, sh.TradePartnerID, sh.TradePartnerVendorID, sh.StyleLinkID, sh.MaterialCoreID, sh.ProdDev, sh.HeaderLocked, 
	   sh.CustomField31, sh.CustomField32, sh.CustomField34, sh.CustomField33, sh.CustomField35, sh.CustomField36, sh.CustomField37,
	   sh.CustomField38, sh.CustomField39, sh.CustomField40, sh.Distribution, sh.UserCID, sh.IntroSeasonYearID, sh.UserMID, 
	   sh.DesignSketchBackID, sh.DesignSketchBackVersion, sh.OwnerGroup, sh.StartDate, sh.PlannedDueDate, sh.PlannedStartDate, 
	   sh.ScheduleBy, sh.EnforceDependency, sh.WorkflowTemplateID, sy.SeasonYearID, sy.Year, sy.Season, 
	   ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVarchar(2))) AS Variation, 
       sh.DivisionID, srh.Season as SourcingSeason, srh.Year as SourcingYear, 
       (SELECT COUNT(*) AS Expr1
        FROM pSampleRequestBOMTrade AS samples 
		INNER JOIN pStyleSeasonYear AS ssy ON samples.StyleSeasonYearID = ssy.StyleSeasonYearID 
		INNER JOIN pSourcingHeader AS sourcing ON sourcing.seasonYearId = ssy.SeasonYearID AND 
                                                  sourcing.SourcingHeaderID = ss.SourcingHeaderID
        WHERE (samples.StyleID = ss.StyleID)) AS SampleRequestsCount, 
	   CASE WHEN EXISTS(SELECT * 
					    FROM pSampleRequestBOMTrade AS samples 
						INNER JOIN pStyleSeasonYear AS ssy ON samples.StyleSeasonYearID = ssy.StyleSeasonYearID 
						INNER JOIN pSourcingHeader AS sourcing ON sourcing.seasonYearId = ssy.SeasonYearID AND 
                                                                  sourcing.SourcingHeaderID = ss.SourcingHeaderID
                        WHERE samples.StyleID = ss.StyleID) THEN 1 ELSE 0 END AS HasSampleRequests,
       (SELECT COUNT(*) AS Expr1
        FROM pStyleQuoteItem AS quote
        WHERE (StyleID = ss.StyleID) AND (SourcingHeaderID = ss.SourcingHeaderID)) AS QuoteCount, 
	   CASE WHEN EXISTS(SELECT *
                        FROM pStyleQuoteItem AS quote
                        WHERE StyleID = ss.StyleID AND SourcingHeaderID = ss.SourcingHeaderID) THEN 1 ELSE 0 END AS HasQuotes,
       '<img src="' + REPLACE(dbo.fnx_GetStreamingImageSmallPath(sh.DesignSketchID, sh.DesignSketchVersion), 'S=500', 'S=50') + '" alt="" />' AS [Image], 
       d.Custom AS DivisionName, st.StyleTypeDescription, sc.StyleCategory AS StyleCategoryName
FROM pSourcingStyle ss
INNER JOIN pStyleHeader sh ON sh.StyleID = ss.StyleID 
INNER JOIN pSourcingHeader srh ON ss.SourcingHeaderID = srh.SourcingHeaderID 
LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = sh.IntroSeasonYearID 
LEFT JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = sh.StyleID 
LEFT JOIN iCustom1 d ON sh.DivisionID = d.CustomID 
LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID 
LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09469', GetDate())
GO
