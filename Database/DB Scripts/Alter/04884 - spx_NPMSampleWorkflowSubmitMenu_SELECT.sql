IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleWorkflowSubmitMenu_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitMenu_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitMenu_SELECT]
(@StyleSet int,
@StyleID uniqueidentifier,
@TradePartnerID uniqueidentifier,
@StyleColorID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier)
AS 


SELECT  DISTINCT   pSampleWorkflow.GroupName, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
                         pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.TradePartnerVendorID, pSampleRequestWorkflow.StyleID, 
                         pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.Status, pSampleRequestWorkflow.Submit, 
                         pSampleRequestWorkflow.TechPackID, pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, 
                         pSampleRequestWorkflow.EndDate, pSampleWorkflow.SampleWorkflowSort, 
                         pSampleRequestWorkflow.SampleWorkflowPartnerTypeID, uTradePartnerType.Custom AS PartnerType, ISNULL(uTradePartnerType.CustomKey, '1') AS PartnerOwner
   FROM         pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID LEFT JOIN
                         uTradePartnerType WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowPartnerTypeID = uTradePartnerType.CustomId
   WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID) AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerID) AND 
			 (pSampleRequestWorkflow.StyleID = @StyleId) AND (pSampleRequestWorkflow.StyleSet = @StyleSet)
   ORDER BY pSampleWorkflow.SampleWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04884', GetDate())
GO
