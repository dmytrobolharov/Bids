IF OBJECT_ID(N'[dbo].[vwx_BatchQPage_DimensionalBOM_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQPage_DimensionalBOM_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQPage_DimensionalBOM_SEL]
AS
SELECT sbd.StyleBOMDimensionID, wfi.WorkFlowItemID, wfi.StyleID, wfi.WorkFlowItemName, sh.StyleType, sh.Description, sh.StyleCategory, 
       sh.SizeClassId, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sh.StyleSet, sh.TechPackId, sh.TechPackDate, sh.DueDate, sh.RecDate, sh.MaterialID, sh.MaterialImageID, 
       sh.MaterialImageVersion, sh.MaterialNo, sh.MaterialName, sh.StyleMaterialID, sh.DesignSketchID, sh.TechSketchID, 
       sh.ConceptSketchID, sh.ColorSketchID, sh.TradePartnerID, sh.TradePartnerVendorID, sh.IntroSeasonYearID, sh.PlannedDueDate, 
       sh.PlannedStartDate, sh.StartDate, sh.CustomField31, sh.CustomField32, sh.CustomField33, sh.CustomField34, sh.CustomField35, 
       sh.CustomField36, sh.CustomField37, sh.CustomField38, sh.CustomField39, sh.CustomField40, sh.CustomField30, sh.CustomField29, 
       sh.CustomField28, sh.CustomField27, sh.CustomField26, sh.CustomField25, sh.CustomField24, sh.CustomField23, sh.CustomField22, 
       sh.CustomField21, sh.CustomField20, sh.CustomField19, sh.CustomField18, sh.CustomField17, sh.CustomField16, sh.Active, 
       sh.CUser, sh.CDate, sh.MDate, sh.MUser, sh.CustomField15, sh.CustomField14, sh.CustomField13, sh.CustomField12, sh.CustomField11, 
       sh.CustomField10, sh.CustomField9, sh.CustomField8, sh.CustomField7, sh.CustomField6, sh.CustomField5, sh.CustomField4, 
       sh.CustomField3, sh.CustomField2, sh.CustomField1, sh.StyleNo
FROM pStyleBOMDimension sbd
LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID 
LEFT JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09417', GetDate())
GO
