/****** Object:  StoredProcedure [dbo].[spx_NPMSampleBOMWorkflowSubmitMenu_SELECT]    Script Date: 01/15/2013 17:13:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleBOMWorkflowSubmitMenu_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleBOMWorkflowSubmitMenu_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleBOMWorkflowSubmitMenu_SELECT]    Script Date: 01/15/2013 17:13:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleBOMWorkflowSubmitMenu_SELECT]
(@StyleSet int,
@StyleID uniqueidentifier,
@TradePartnerID uniqueidentifier,
@StyleColorID uniqueidentifier = null,
@SampleRequestTradeID uniqueidentifier)
AS 


SELECT  DISTINCT   pSampleWorkflow.GroupName, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
                         pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.TradePartnerVendorID, pSampleRequestWorkflow.StyleID, 
                         pSampleRequestWorkflow.ItemDim1Id,pSampleRequestWorkflow.ItemDim2Id,pSampleRequestWorkflow.ItemDim3Id, pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.Status, pSampleRequestWorkflow.Submit, 
                         pSampleRequestWorkflow.TechPackID, pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, 
                         pSampleRequestWorkflow.EndDate, pSampleWorkflow.SampleWorkflowSort
   FROM         pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) 
   INNER JOIN   pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
   WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID) AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerID) AND 
			 (pSampleRequestWorkflow.StyleID = @StyleId) AND (pSampleRequestWorkflow.StyleSet = @StyleSet)
   ORDER BY pSampleWorkflow.SampleWorkflowSort





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04791', GetDate())
GO