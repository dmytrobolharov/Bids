
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  View [dbo].[vwx_SampleRequest_TimeLineSearchBOM_SELECT]    Script Date: 12/23/2011 00:10:02 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequest_TimeLineSearchBOM_SELECT]'))
DROP VIEW [dbo].[vwx_SampleRequest_TimeLineSearchBOM_SELECT]
GO



/****** Object:  View [dbo].[vwx_SampleRequest_TimeLineSearchBOM_SELECT]    Script Date: 12/23/2011 00:10:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_SampleRequest_TimeLineSearchBOM_SELECT]
AS
SELECT     dbo.pSampleRequestWorkflowBOM.TradePartnerID, dbo.pSampleRequestWorkflowBOM.TradePartnerVendorID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleType, 
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
                      dbo.pStyleHeader.MDate, dbo.pStyleHeader.Active, dbo.pSampleRequestWorkflowBOM.SampleRequestTradeID, dbo.pSampleRequestWorkflowBOM.Status, 
                      dbo.pStyleSeasonYear.SeasonYearID
FROM         dbo.pStyleHeader INNER JOIN
                      dbo.pSampleRequestBOMTrade ON dbo.pStyleHeader.StyleID = dbo.pSampleRequestBOMTrade.StyleID INNER JOIN
                      dbo.pSampleRequestWorkflowBOM ON dbo.pSampleRequestBOMTrade.SampleRequestTradeID = dbo.pSampleRequestWorkflowBOM.SampleRequestTradeID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pSampleRequestBOMTrade.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
WHERE     (dbo.pStyleHeader.Active = 1)




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02500'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02500', GetDate())
END

GO

