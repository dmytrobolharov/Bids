IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSchemaSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSchemaSubmit_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowSchemaSubmit_SELECT](
@SampleRequestTradeID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(5),
@Submit INT
)
AS

DECLARE @LastSubmit INT 

SELECT @LastSubmit = ISNULL(MAX(Submit),0) FROM pSampleRequestSubmit
WHERE SampleRequestTradeID  = @SampleRequestTradeID
AND SampleWorkflowID = @SampleWorkflowID


SELECT a.*, b.SummaryXML, b.EditXML, b.MaterialXML,
@LastSubmit AS LastSubmit
FROM pSampleRequestSubmit a
INNER JOIN pSampleRequestWorkflowStatusSchema b ON b.SampleWorkflowID = a.SampleWorkflowID AND b.StatusID = a.Status
WHERE a.SampleRequestTradeID  = @SampleRequestTradeID
AND a.SampleWorkflowID = @SampleWorkflowID
AND a.Submit = @Submit 




GO