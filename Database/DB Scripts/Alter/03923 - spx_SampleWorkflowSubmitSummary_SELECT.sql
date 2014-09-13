/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitSummary_SELECT]    Script Date: 09/17/2012 17:30:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummary_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitSummary_SELECT]    Script Date: 09/17/2012 17:30:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE  PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummary_SELECT]
(@SampleRequestTradeID uniqueidentifier)
AS 

SELECT a.SampleWorkflowID, GroupName, GroupID, SampleWorkflow, a.SampleRequestWorkflowID, a.TradePartnerVendorID, a.Submit
FROM  pSampleRequestWorkflow  a WITH (NOLOCK) 
INNER JOIN  pSampleWorkflow  b  WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE SampleRequestTradeID =  @SampleRequestTradeID
ORDER BY b.SampleWorkflowSort








GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03923', GetDate())
GO