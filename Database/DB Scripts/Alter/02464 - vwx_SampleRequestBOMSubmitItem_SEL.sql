-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  View [dbo].[vwx_SampleRequestSubmitItem_SEL]    Script Date: 12/18/2011 17:55:43 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestBOMSubmitItem_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]
GO



/****** Object:  View [dbo].[vwx_SampleRequestSubmitItem_SEL]    Script Date: 12/18/2011 17:55:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]
AS
SELECT     a.SampleRequestSubmitID, a.SampleRequestTradeID, a.SampleRequestWorkflowID, a.SampleWorkflowID, a.StyleID, a.ItemDim1Id, a.ItemDim2Id, a.ItemDim3Id, 
                      a.StyleSet, a.WorkflowID, a.TradePartnerVendorID, a.TradePartnerID, a.Submit, a.Status, a.AssignedTo, a.StartDate, a.RecDate, a.RecBy, a.RecCarrier, a.RecTrackNo, 
                      a.RecWeight, a.VendorWeight, a.VendorDate, a.VendorName, a.SubmitDays, a.ResubmitDays, a.DueDate, a.RevDate, a.RevBy, a.EndDate, a.EndBy, a.CUser, 
                      a.CDate, a.MUser, a.MDate, a.TUser, a.TDate, a.GradeRefresh, a.Comment, a.AgentView, a.VendorComment, a.InternalComment, a.NoTolerance, 
                      b.Status AS StatusName
FROM         dbo.pSampleRequestSubmitBOM AS a INNER JOIN
                      dbo.pSampleRequestSubmitStatus AS b ON a.Status = b.StatusID

GO


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02464'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02464', GetDate())

END

GO