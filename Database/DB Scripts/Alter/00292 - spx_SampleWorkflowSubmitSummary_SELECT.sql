IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummary_SELECT]
GO


CREATE  PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummary_SELECT]
(@SampleRequestTradeID uniqueidentifier)
AS 

SELECT a.SampleWorkflowID, GroupName, GroupID, SampleWorkflow, a.SampleRequestWorkflowID, a.TradePartnerVendorID
FROM  pSampleRequestWorkflow  a WITH (NOLOCK) 
INNER JOIN  pSampleWorkflow  b  WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE SampleRequestTradeID =  @SampleRequestTradeID
ORDER BY b.SampleWorkflowSort








GO