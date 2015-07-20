
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

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]    Script Date: 12/23/2011 00:09:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]    Script Date: 12/23/2011 00:09:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




create  PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]
(@SampleRequestTradeID uniqueidentifier)
AS 

SELECT a.SampleWorkflowID, GroupName, GroupID, SampleWorkflow, a.SampleRequestWorkflowID, a.TradePartnerVendorID
FROM  pSampleRequestWorkflowBOM  a WITH (NOLOCK) 
INNER JOIN  pSampleWorkflow  b  WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE SampleRequestTradeID =  @SampleRequestTradeID
ORDER BY b.SampleWorkflowSort




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02509'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02509', GetDate())
END

GO
