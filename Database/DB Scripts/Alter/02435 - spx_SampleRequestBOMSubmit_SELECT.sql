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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSubmit_SELECT]    Script Date: 12/18/2011 18:54:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSubmit_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSubmit_SELECT]    Script Date: 12/18/2011 18:54:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSubmit_SELECT]
(
@SampleRequestTradeID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@SampleWorkflowID varchar(10),
@StyleSet int,
@Submit int
)
AS 

SELECT pSampleRequestSubmit.SampleRequestSubmitID, pSampleRequestSubmit.SampleRequestTradeID, 
    pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleWorkflowID, pSampleRequestSubmit.StyleID, 
    pSampleRequestSubmit.ItemDim1Id,pSampleRequestSubmit.ItemDim2Id,pSampleRequestSubmit.ItemDim3Id, pSampleRequestSubmit.StyleSet, pSampleRequestSubmit.WorkflowID, 
    pSampleRequestSubmit.TradePartnerVendorID, pSampleRequestSubmit.TradePartnerID, pSampleRequestSubmit.Submit, 
    pSampleRequestSubmit.Status, pSampleRequestSubmit.AssignedTo, pSampleRequestSubmit.StartDate, pSampleRequestSubmit.RecDate, 
    pSampleRequestSubmit.RecBy, pSampleRequestSubmit.RecCarrier, pSampleRequestSubmit.RecTrackNo, pSampleRequestSubmit.RecWeight, 
    pSampleRequestSubmit.VendorWeight, pSampleRequestSubmit.VendorDate, pSampleRequestSubmit.VendorName, 
    pSampleRequestSubmit.SubmitDays, pSampleRequestSubmit.ResubmitDays, pSampleRequestSubmit.DueDate, pSampleRequestSubmit.RevDate, 
    pSampleRequestSubmit.RevBy, pSampleRequestSubmit.EndDate, pSampleRequestSubmit.EndBy, pSampleRequestSubmit.CUser, 
    pSampleRequestSubmit.CDate, pSampleRequestSubmit.MUser, pSampleRequestSubmit.MDate, pSampleRequestSubmit.TUser, 
    pSampleRequestSubmit.TDate, pSampleRequestSubmit.GradeRefresh, pSampleRequestSubmit.Comment, pSampleRequestSubmit.AgentView, 
    pSampleRequestSubmit.NoTolerance, pSampleRequestWorkflow.FinalDate , pSampleRequestWorkflow.SampleWorkflowFinalDate
FROM pSampleRequestSubmitBOM  pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
    pSampleRequestWorkflowBOM  pSampleRequestWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestWorkflowID = pSampleRequestWorkflow.SampleRequestWorkflowID
WHERE pSampleRequestSubmit.StyleID = @StyleID AND 
	pSampleRequestSubmit.StyleSet = @StyleSet AND 
	pSampleRequestSubmit.SampleRequestTradeID = @SampleRequestTradeID AND 
	pSampleRequestSubmit.SampleRequestWorkflowID = @SampleRequestWorkflowID AND 
	pSampleRequestSubmit.SampleWorkflowID = @SampleWorkflowID AND 
	pSampleRequestSubmit.Submit = @Submit     
    
    


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02435'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02435', GetDate())

END

GO
