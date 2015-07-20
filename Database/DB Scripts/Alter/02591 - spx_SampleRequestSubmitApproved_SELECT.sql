IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitApproved_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestSubmitApproved_SELECT]
GO


CREATE PROCEDURE dbo.spx_SampleRequestSubmitApproved_SELECT(
	@Submit INT,
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@TradePartnerVendorID UNIQUEIDENTIFIER,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@SampleWorkflowID UNIQUEIDENTIFIER
)
AS

SELECT a.SampleRequestSubmitID, ISNULL(b.ApprovedType,0) AS ApprovedType
FROM pSampleRequestSubmit a WITH(NOLOCK)
	LEFT OUTER JOIN  dbo.pSampleRequestSubmitStatus b ON a.Status =  b.StatusID
WHERE a.Submit =  @Submit 
	AND SampleRequestWorkflowID = @SampleRequestWorkflowID
	AND TradePartnerVendorId = @TradePartnerVendorID
	AND SampleRequestTradeId = @SampleRequestTradeID 
	AND SampleWorkflowId = @SampleWorkflowID


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02591'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02591', GetDate())
END

GO