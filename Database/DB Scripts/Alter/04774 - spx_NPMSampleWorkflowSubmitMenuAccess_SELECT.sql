/****** Object:  StoredProcedure [dbo].[spx_NPMSampleWorkflowSubmitMenuAccess_SELECT]    Script Date: 01/14/2013 11:55:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleWorkflowSubmitMenuAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitMenuAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleWorkflowSubmitMenuAccess_SELECT]    Script Date: 01/14/2013 11:55:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitMenuAccess_SELECT]
(@StyleSet int,
@StyleID uniqueidentifier,
@TradePartnerID uniqueidentifier,
@StyleColorID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@TeamId uniqueidentifier  
)
AS 


SELECT  DISTINCT   pSampleWorkflow.GroupName, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
                         pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.TradePartnerID, pSampleRequestWorkflow.StyleID, 
                         pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.Status, pSampleRequestWorkflow.Submit, 
                         pSampleRequestWorkflow.TechPackID, pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, 
                         pSampleRequestWorkflow.EndDate,  pSampleWorkflow.SampleWorkflowSort
   FROM         pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
   WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID) AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerID) AND 
			 (pSampleRequestWorkflow.StyleID = @StyleId) AND (pSampleRequestWorkflow.StyleSet = @StyleSet)

--		AND pSampleWorkflow.SampleWorkflowID in  (  SELECT  SampleTypeId from sAccessSampleFolder WITH (NOLOCK) where TeamId = @TeamId  AND ( AccessRoleId =  3 OR AccessView = 1) ) 

   ORDER BY pSampleWorkflow.SampleWorkflowSort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04774', GetDate())
GO
