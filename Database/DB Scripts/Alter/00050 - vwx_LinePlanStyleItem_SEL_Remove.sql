
CREATE VIEW [dbo].[vwx_LinePlanStyleItem_SEL_Remove]
AS
SELECT     a.LinePlanItemID, a.LinePlanRangeID, a.LinePlanRangeTypeID, a.LinePlanID, a.CUser, a.CDate, a.MUser, a.MDate, a.StyleTypeID, b.StyleID, 
                      b.StyleType, b.StyleNo, b.TempID, b.TempNo, b.ConceptNo, b.SpecNo, b.Description, b.SizeClass, b.SizeRange, b.StyleSet, b.MaterialID, 
                      b.MaterialImageID, b.MaterialImageVersion, b.MaterialNo, b.MaterialName, b.DesignSketchID, b.DesignSketchVersion, b.CustomField1, 
                      b.CustomField2, b.CustomField3, b.CustomField4, b.CustomField5, b.CustomField6, b.CustomField7, b.CustomField8, b.CustomField9, 
                      b.CustomField10, b.CustomField11, b.CustomField12, b.CustomField13, b.CustomField14, b.CustomField15, d.StyleCostingTypeID, d.StyleQuotaDutyID,
                       d.StyleCostingDate, d.StyleCostingStatus, CASE WHEN d .StyleCostingCustomField1 IS NULL 
                      THEN 0 ELSE d .StyleCostingCustomField1 END AS StyleCostingCustomField1, d.StyleCostingCustomField2, d.StyleCostingCustomField3, 
                      d.StyleCostingCustomField4, d.StyleCostingCustomField5, d.StyleCostingCustomField6, d.StyleCostingCustomField7, d.StyleCostingCustomField8, 
                      d.StyleCostingCustomField9, d.StyleCostingCustomField10, d.StyleCostingCustomField11, d.StyleCostingCustomField12, 
                      d.StyleCostingCustomField13, d.StyleCostingCustomField14, d.StyleCostingCustomField15, d.StyleCostingCustomField16, 
                      d.StyleCostingCustomField17, d.StyleCostingCustomField18, d.StyleCostingCustomField19, d.StyleCostingCustomField20, 
                      d.StyleCostingCustomField21, d.StyleCostingCustomField22, d.StyleCostingCustomField23, d.StyleCostingCustomField24, 
                      d.StyleCostingCustomField25, d.StyleCostingCustomField26, d.StyleCostingCustomField27, d.StyleCostingCustomField28, 
                      d.StyleCostingCustomField29, d.StyleCostingCustomField30, d.Active, d.StyleCostingCustomField31, d.StyleCostingCustomField32, 
                      d.StyleCostingCustomField33, d.StyleCostingCustomField34, d.StyleCostingCustomField35, c.SeasonYearID, e.AttributeName,c.StyleSeasonYearID
FROM         dbo.pLinePlanItem AS a LEFT OUTER JOIN
dbo.pStyleHeader AS b ON a.StyleID = b.StyleID LEFT OUTER JOIN
dbo.pStyleSeasonYear AS c ON a.StyleID = c.StyleID AND a.LinePlanItemID = c.LinePlanItemID LEFT OUTER JOIN
dbo.pStyleCostingHeader AS d ON d.StyleSeasonYearID = c.StyleSeasonYearID 
LEFT OUTER JOIN pLinePlanStyleAttributeItem e ON e.LinePlanStyleAttributeItemID = a.LinePlanStyleAttributeItemID 
WHERE a.StyleID != '00000000-0000-0000-0000-000000000000'

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '050', GetDate())
GO