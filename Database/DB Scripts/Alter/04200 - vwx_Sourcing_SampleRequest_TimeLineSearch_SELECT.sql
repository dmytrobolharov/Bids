IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_SampleRequest_TimeLineSearch_SELECT]'))
DROP VIEW [dbo].[vwx_Sourcing_SampleRequest_TimeLineSearch_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_Sourcing_SampleRequest_TimeLineSearch_SELECT]
AS
SELECT     dbo.pSampleRequestWorkflow.TradePartnerID, dbo.pSampleRequestWorkflow.TradePartnerVendorID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleType, 
                      dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomerNo, dbo.pStyleHeader.DevelopmentNo, 
                      dbo.pStyleHeader.ConceptNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, 
                      dbo.pStyleHeader.StyleSet, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.Customer, dbo.pStyleHeader.Buyer, 
                      dbo.pStyleHeader.Designer, dbo.pStyleHeader.SampleMaker, dbo.pStyleHeader.PatternMaker, dbo.pStyleHeader.ProductionManager, 
                      dbo.pStyleHeader.TechnicalDesigner, dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.StyleLocation, dbo.pStyleHeader.WashType, dbo.pStyleHeader.Pitch, 
                      dbo.pStyleHeader.MaterialID, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.MaterialImageVersion, dbo.pStyleHeader.MaterialNo, 
                      dbo.pStyleHeader.MaterialName, dbo.pStyleHeader.StyleMaterialID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField9, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField11, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField13, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField15, dbo.pStyleHeader.CUser, dbo.pStyleHeader.CDate, dbo.pStyleHeader.MUser, 
                      dbo.pStyleHeader.MDate, dbo.pStyleHeader.Active, dbo.pSampleRequestWorkflow.SampleRequestTradeID, dbo.pSampleRequestWorkflow.Status, 
                      dbo.pStyleSeasonYear.SeasonYearID
FROM         dbo.pSourcingHeader INNER JOIN
                      dbo.pSourcingStyle ON dbo.pSourcingHeader.SourcingHeaderID = dbo.pSourcingStyle.SourcingHeaderID INNER JOIN
                      dbo.pStyleHeader INNER JOIN
                      dbo.pSampleRequestTrade ON dbo.pStyleHeader.StyleID = dbo.pSampleRequestTrade.StyleID INNER JOIN
                      dbo.pSampleRequestWorkflow ON dbo.pSampleRequestTrade.SampleRequestTradeID = dbo.pSampleRequestWorkflow.SampleRequestTradeID ON 
                      dbo.pSourcingStyle.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pSampleRequestTrade.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
WHERE     (dbo.pStyleHeader.Active = 1)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04200', GetDate())
GO
