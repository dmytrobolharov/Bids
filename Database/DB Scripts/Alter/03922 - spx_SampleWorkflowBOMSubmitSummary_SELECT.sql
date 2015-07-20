/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]    Script Date: 09/17/2012 17:33:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]    Script Date: 09/17/2012 17:33:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO






create  PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitSummary_SELECT]
(@SampleRequestTradeID uniqueidentifier)
AS 

SELECT a.SampleWorkflowID, GroupName, GroupID, SampleWorkflow, a.SampleRequestWorkflowID, a.TradePartnerVendorID, a.Submit
FROM  pSampleRequestWorkflowBOM  a WITH (NOLOCK) 
INNER JOIN  pSampleWorkflow  b  WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE SampleRequestTradeID =  @SampleRequestTradeID
ORDER BY b.SampleWorkflowSort






GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03922', GetDate())
GO