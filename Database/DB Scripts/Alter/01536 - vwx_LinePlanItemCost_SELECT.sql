
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanItemCost_SELECT]'))
DROP VIEW [dbo].[vwx_LinePlanItemCost_SELECT]
GO


CREATE VIEW [dbo].[vwx_LinePlanItemCost_SELECT]
AS
SELECT     a.StyleID, a.StyleCostingTypeID, a.StyleQuotaDutyID, a.StyleCostingDate, a.StyleCostingStatus, a.StyleCostingCustomField1, a.StyleCostingCustomField2, 
                      a.StyleCostingCustomField3, a.StyleCostingCustomField4, a.StyleCostingCustomField5, a.StyleCostingCustomField6, a.StyleCostingCustomField7, 
                      a.StyleCostingCustomField8, a.StyleCostingCustomField9, a.StyleCostingCustomField10, a.StyleCostingCustomField11, a.StyleCostingCustomField12, 
                      a.StyleCostingCustomField13, a.StyleCostingCustomField14, a.StyleCostingCustomField15, a.StyleCostingCustomField16, a.StyleCostingCustomField17, 
                      a.StyleCostingCustomField18, a.StyleCostingCustomField19, a.StyleCostingCustomField20, a.StyleCostingCustomField21, a.StyleCostingCustomField22, 
                      a.StyleCostingCustomField23, a.StyleCostingCustomField24, a.StyleCostingCustomField25, a.StyleCostingCustomField26, a.StyleCostingCustomField27, 
                      a.StyleCostingCustomField28, a.StyleCostingCustomField29, a.StyleCostingCustomField30, a.CUser, a.CDate, a.MUser, a.MDate, a.Active, b.StyleNo, b.Description, 
                      b.StyleType, b.StyleCategory, c.LinePlanID, c.LinePlanItemID, d.LinePlanRangeID, b.MaterialNo, b.MaterialName, b.CustomField1, b.CustomField2, b.CustomField3, 
                      b.CustomField4, b.CustomField5, b.CustomField6, b.CustomField7, b.CustomField8, b.CustomField9, b.CustomField10, b.CustomField11, b.CustomField12, 
                      b.CustomField13, b.CustomField14, b.CustomField15, b.CustomField16, b.CustomField17, b.CustomField18, b.CustomField19, b.CustomField20, b.CustomField21, 
                      b.CustomField22, b.CustomField23, b.CustomField24, b.CustomField25, b.CustomField26, b.CustomField27, b.CustomField28, b.CustomField29, b.CustomField30, 
                      b.SizeClass, b.SizeRange, f.AttributeName, g.LinePlanAttributeText2 AS Brand, g.LinePlanAttributeText3 AS Category, c.SeasonYearID, a.StyleCostingCustomField35, 
                      a.StyleCostingHeaderID
FROM         dbo.pStyleCostingHeader AS a INNER JOIN
                      dbo.pStyleHeader AS b ON b.StyleID = a.StyleID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear AS c ON c.StyleSeasonYearID = a.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pLinePlanItem AS d ON c.LinePlanItemID = d.LinePlanItemID LEFT OUTER JOIN
                      dbo.pLinePlanStyleAttributeItem AS e ON e.LinePlanStyleAttributeItemID = d.LinePlanStyleAttributeItemID LEFT OUTER JOIN
                      dbo.pLinePlanStyleAttribute AS f ON f.LinePlanStyleAttributeID = e.LineplanStyleAttributeID INNER JOIN
                      dbo.pLinePlanRange AS g ON d.LinePlanRangeID = g.LinePlanRangeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01536', GetDate())
GO