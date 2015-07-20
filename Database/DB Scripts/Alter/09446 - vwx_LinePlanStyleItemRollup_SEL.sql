IF OBJECT_ID(N'[dbo].[vwx_LinePlanStyleItemRollup_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanStyleItemRollup_SEL]
GO

CREATE VIEW [dbo].[vwx_LinePlanStyleItemRollup_SEL]
AS
SELECT lpi.LinePlanItemID, lpi.LinePlanRangeID, lpi.LinePlanRangeTypeID, lpi.LinePlanID, sh.StyleID, 
	   sh.StyleType, sh.StyleNo, sh.TempID, sh.TempNo, sh.ConceptNo, sh.SpecNo, sh.Description, 
	   COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sh.StyleSet, sh.MaterialID, sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialNo, sh.MaterialName, 
	   sh.DesignSketchID, sh.DesignSketchVersion, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, 
       sh.CustomField5, sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, 
	   sh.CustomField11, sh.CustomField12, sh.CustomField13, sh.CustomField14, sh.CustomField15, lpi.CUser, 
       lpi.CDate, lpi.MUser, lpi.MDate, lpi.StyleTypeID, lpr.LinePlanAttributeItemID1, lpr.LinePlanAttributeItemID2, 
	   lpr.LinePlanAttributeItemID3, lpr.LinePlanAttributeItemID4, lpr.LinePlanFinancialID, sch.StyleCostingCustomField1
FROM pLinePlanItem lpi
INNER JOIN pLinePlanRange lpr ON lpi.LinePlanRangeID = lpr.LinePlanRangeID 
LEFT JOIN pStyleSeasonYear ssy ON lpi.LinePlanItemID = ssy.LinePlanItemID AND 
								  lpi.StyleID = ssy.StyleID 
LEFT JOIN pStyleCostingHeader sch ON ssy.StyleSeasonYearID = sch.StyleSeasonYearID AND 
									 lpi.StyleID = sch.StyleID 
LEFT JOIN pStyleHeader sh ON lpi.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09446', GetDate())
GO
