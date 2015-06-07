IF OBJECT_ID(N'[dbo].[vwx_Sourcing_SampleRequest_TimeLineSearch_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Sourcing_SampleRequest_TimeLineSearch_SELECT]
GO

CREATE VIEW [dbo].[vwx_Sourcing_SampleRequest_TimeLineSearch_SELECT]
AS
SELECT srw.TradePartnerID, srw.TradePartnerVendorID, sh.StyleID, sh.StyleType, sh.WorkflowType, sh.RefNo, 
	   sh.StyleNo, sh.CustomerNo, sh.DevelopmentNo, sh.ConceptNo, sh.Description, sh.StyleCategory, 
	   COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sh.StyleSet, sh.DueDate, sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, sh.PatternMaker, 
	   sh.ProductionManager, sh.TechnicalDesigner, sh.StyleStatus, sh.StyleLocation, sh.WashType, sh.Pitch, 
       sh.MaterialID, sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialNo, sh.MaterialName, sh.StyleMaterialID, 
	   sh.DesignSketchID, sh.TechSketchID, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, 
	   sh.CustomField5, sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, 
	   sh.CustomField11, sh.CustomField12, sh.CustomField13, sh.CustomField14, sh.CustomField15, sh.CUser, sh.CDate, 
	   sh.MUser, sh.MDate, sh.Active, srw.SampleRequestTradeID, srw.Status, ssy.SeasonYearID
FROM pSourcingHeader srh
INNER JOIN pSourcingStyle ss ON srh.SourcingHeaderID = ss.SourcingHeaderID 
INNER JOIN pStyleHeader sh
 INNER JOIN dbo.pSampleRequestTrade srt ON sh.StyleID = srt.StyleID 
 INNER JOIN pSampleRequestWorkflow srw ON srt.SampleRequestTradeID = srw.SampleRequestTradeID 
ON ss.StyleID = sh.StyleID 
LEFT JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (sh.Active = 1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09464', GetDate())
GO
