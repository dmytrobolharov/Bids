/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkFlowList_SELECT_API]    Script Date: 02/12/2014 15:43:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkFlowList_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkFlowList_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkFlowList_SELECT_API]    Script Date: 02/12/2014 15:43:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_SampleRequestWorkFlowList_SELECT_API](
	@SampleRequestTradeID UNIQUEIDENTIFIER	
)
AS
SELECT sw.*, srw.*
FROM (
SELECT srw.SampleWorkflowID, srw.SampleRequestTradeID, srw.SampleRequestWorkflowID, srw.StyleSet, srw.Submit, srs.SampleRequestSubmitID, srs.DueDate
FROM pSampleRequestWorkflow srw
LEFT JOIN pSampleRequestSubmit srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID
AND srw.Submit = srs.Submit

UNION ALL

SELECT srw.SampleWorkflowID, srw.SampleRequestTradeID, srw.SampleRequestWorkflowID, srw.StyleSet, srw.Submit, srs.SampleRequestSubmitID, srs.DueDate
FROM pSampleRequestWorkflowBOM srw
LEFT JOIN pSampleRequestSubmitBOM srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID
AND srw.Submit = srs.Submit
) srw
LEFT JOIN pSampleWorkflow sw ON sw.SampleWorkflowID = srw.SampleWorkflowID
WHERE SampleRequestTradeID = @SampleRequestTradeID
ORDER by SampleWorkflowSort


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07113', GetDate())
GO