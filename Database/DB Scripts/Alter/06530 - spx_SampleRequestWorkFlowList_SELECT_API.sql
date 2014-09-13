/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkFlowList_SELECT_API]    Script Date: 11/06/2013 14:39:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkFlowList_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkFlowList_SELECT_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkFlowList_SELECT_API]    Script Date: 11/06/2013 14:39:27 ******/
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
SELECT srw.SampleWorkflowID, srw.SampleRequestTradeID, srw.SampleRequestWorkflowID, srw.StyleSet, srw.Submit, srs.SampleRequestSubmitID
FROM pSampleRequestWorkflow srw
LEFT JOIN pSampleRequestSubmit srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID
AND srw.Submit = srs.Submit

UNION ALL

SELECT srw.SampleWorkflowID, srw.SampleRequestTradeID, srw.SampleRequestWorkflowID, srw.StyleSet, srw.Submit, srs.SampleRequestSubmitID
FROM pSampleRequestWorkflowBOM srw
LEFT JOIN pSampleRequestSubmitBOM srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID
AND srw.Submit = srs.Submit
) srw
LEFT JOIN pSampleWorkflow sw ON sw.SampleWorkflowID = srw.SampleWorkflowID
WHERE SampleRequestTradeID = @SampleRequestTradeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06530', GetDate())
GO