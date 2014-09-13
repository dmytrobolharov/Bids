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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitBOMItemSummary_SEL]    Script Date: 12/18/2011 18:04:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitBOMItemSummary_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitBOMItemSummary_SEL]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitBOMItemSummary_SEL]    Script Date: 12/18/2011 18:04:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_SampleRequestSubmitBOMItemSummary_SEL] (
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT, 
@TradePartnerVendorID UNIQUEIDENTIFIER,
@SampleRequestWorkflowID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(10),
@TeamID UNIQUEIDENTIFIER
)
AS


SELECT a.Status,
CASE a.Submit 
	WHEN 1 THEN '1st Submit (' + c.Status + ')'
	WHEN 2 THEN '2nd Submit (' + c.Status + ')'
	WHEN 3 THEN '3rd Submit (' + c.Status + ')'
	ELSE CAST(a.Submit AS NVARCHAR(10)) + 'th Submit (' + c.Status + ')'
END AS SubmitHeader,
a.DueDate,
a.RecDate,
a.VendorDate, 
a.EndDate, 
a.Submit, a.StyleID, a.StyleSet, a.TradePartnerVendorID, a.SampleWorkflowID, a.SampleRequestWorkflowID,
a.SampleRequestSubmitID, b.SummaryXML, b.EditXML
FROM pSampleRequestSubmitBOM  a
INNER JOIN  pSampleRequestSubmitStatus c ON a.Status = c.StatusID
LEFT OUTER JOIN pSampleRequestWorkflowStatusSchema b ON (b.SampleWorkflowID = a.SampleWorkflowID AND b.StatusID =  a.Status)
WHERE a.StyleID = @StyleID 
AND a.StyleSet = @StyleSet 
AND a.TradePartnerVendorID  = @TradePartnerVendorID 
AND a.SampleRequestWorkflowID  = @SampleRequestWorkflowID 
AND a.SampleWorkflowID = @SampleWorkflowID 


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02372'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02372', GetDate())

END

GO

