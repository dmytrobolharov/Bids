/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitMenuAccess_SELECT]    Script Date: 06/04/2014 17:13:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitMenuAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitMenuAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitMenuAccess_SELECT]    Script Date: 06/04/2014 17:13:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_SampleWorkflowSubmitMenuAccess_SELECT]
(@StyleSet int,
@StyleID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier,
@StyleColorID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@TeamId uniqueidentifier  
)
AS 


SELECT  DISTINCT   pSampleWorkflow.GroupName, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
                         pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.TradePartnerVendorID, pSampleRequestWorkflow.StyleID, 
                         pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.Status, pSampleRequestWorkflow.Submit, 
                         pSampleRequestWorkflow.TechPackID, pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, 
                         pSampleRequestWorkflow.EndDate,  pSampleWorkflow.SampleWorkflowSort
   FROM         pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
   WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID) AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorID) AND 
			 (pSampleRequestWorkflow.StyleID = @StyleId) AND (pSampleRequestWorkflow.StyleSet = @StyleSet)
   ORDER BY pSampleWorkflow.SampleWorkflowSort

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07884', GetDate())
GO