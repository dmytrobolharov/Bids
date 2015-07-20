
/****** Object:  View [dbo].[vwx_SampleRequest_TimeLineSearch_SELECT]    Script Date: 01/26/2011 14:58:01 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[vwx_SampleRequest_TimeLineSearch_SELECT]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwx_SampleRequest_TimeLineSearch_SELECT]
GO

CREATE VIEW [dbo].[vwx_SampleRequest_TimeLineSearch_SELECT]
AS
SELECT pSampleRequestWorkflow.TradePartnerID, pSampleRequestWorkflow.TradePartnerVendorID, pStyleHeader.StyleID, pStyleHeader.StyleType, 
      pStyleHeader.WorkflowType, pStyleHeader.RefNo, pStyleHeader.StyleNo, pStyleHeader.CustomerNo, pStyleHeader.DevelopmentNo, 
      pStyleHeader.ConceptNo, pStyleHeader.Description, pStyleHeader.StyleCategory, pStyleHeader.SizeClass, pStyleHeader.SizeRange, 
      pStyleHeader.StyleSet, pStyleHeader.DueDate, pStyleHeader.RecDate, pStyleHeader.Customer, pStyleHeader.Buyer, 
      pStyleHeader.Designer, pStyleHeader.SampleMaker, pStyleHeader.PatternMaker, pStyleHeader.ProductionManager, 
      pStyleHeader.TechnicalDesigner, pStyleHeader.StyleStatus, pStyleHeader.StyleLocation, pStyleHeader.WashType, pStyleHeader.Pitch, 
      pStyleHeader.MaterialID, pStyleHeader.MaterialImageID, pStyleHeader.MaterialImageVersion, pStyleHeader.MaterialNo, 
      pStyleHeader.MaterialName, pStyleHeader.StyleMaterialID, pStyleHeader.DesignSketchID, pStyleHeader.TechSketchID, 
      pStyleHeader.CustomField1, pStyleHeader.CustomField2, pStyleHeader.CustomField3, pStyleHeader.CustomField4, pStyleHeader.CustomField5,
      pStyleHeader.CustomField6, pStyleHeader.CustomField7, pStyleHeader.CustomField8, pStyleHeader.CustomField9, 
      pStyleHeader.CustomField10, pStyleHeader.CustomField11, pStyleHeader.CustomField12, pStyleHeader.CustomField13, 
      pStyleHeader.CustomField14, pStyleHeader.CustomField15, pStyleHeader.CUser, pStyleHeader.CDate, pStyleHeader.MUser, 
      pStyleHeader.MDate, pStyleHeader.Active, pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.Status, 
      pStyleSeasonYear.SeasonYearID
FROM  pStyleHeader INNER JOIN
      pSampleRequestTrade ON pStyleHeader.StyleID = pSampleRequestTrade.StyleID INNER JOIN
      pSampleRequestWorkflow ON pSampleRequestTrade.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID INNER JOIN
      pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
WHERE (pStyleHeader.Active = 1)

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '1065', GetDate())
GO