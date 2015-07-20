IF OBJECT_ID(N'[dbo].[vwx_SampleView_SampleRequest_TimeLineSearch_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SampleView_SampleRequest_TimeLineSearch_SELECT]
GO

CREATE VIEW [dbo].[vwx_SampleView_SampleRequest_TimeLineSearch_SELECT]
AS
SELECT srbt.SampleRequestTradeID, srbt.TradePartnerID, srbt.TradePartnerVendorID, sh.StyleID, sh.StyleType, 
       sh.WorkflowType, sh.RefNo, sh.StyleNo, sh.CustomerNo, sh.DevelopmentNo, sh.ConceptNo, sh.Description, 
	   sh.StyleCategory, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sh.StyleSet, sh.DueDate, sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, sh.PatternMaker, 
	   sh.ProductionManager, sh.TechnicalDesigner, sh.StyleStatus, sh.StyleLocation, sh.WashType, sh.Pitch, sh.MaterialID, 
	   sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialNo, sh.MaterialName, sh.StyleMaterialID, sh.DesignSketchID, 
	   sh.TechSketchID, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.CustomField5, sh.CustomField6, 
	   sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11, sh.CustomField12, sh.CustomField13, 
       sh.CustomField14, sh.CustomField15, sh.CUser, sh.CDate, sh.MUser, sh.MDate, sh.Active, srw.Status, ssy.SeasonYearID,
       tprl.AgentID, tprl.VendorID, tprl.FactoryID
FROM pStyleHeader sh
INNER JOIN pSampleRequestBOMTrade srbt ON sh.StyleID = srbt.StyleID 
INNER JOIN pSampleRequestWorkflow srw ON srbt.SampleRequestTradeID = srw.SampleRequestTradeID 
LEFT JOIN pStyleSeasonYear ssy ON srbt.StyleSeasonYearID = ssy.StyleSeasonYearID 
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srbt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (sh.Active = 1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09463', GetDate())
GO
