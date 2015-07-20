IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitApproved_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitApproved_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSubmitApproved_SELECT](
	@Submit INT,
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@TradePartnerVendorID UNIQUEIDENTIFIER,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@FlagBOM INT
)
AS

IF @FlagBOM = 1
BEGIN
	SELECT a.SampleRequestSubmitID, ISNULL(b.ApprovedType,0) AS ApprovedType
	FROM pSampleRequestSubmitBOM a WITH(NOLOCK)
		LEFT OUTER JOIN  dbo.pSampleRequestSubmitStatus b ON a.Status =  b.StatusID
	WHERE a.Submit =  @Submit 
		AND SampleRequestWorkflowID = @SampleRequestWorkflowID
		AND TradePartnerVendorId = @TradePartnerVendorID
		AND SampleRequestTradeId = @SampleRequestTradeID 
		AND SampleWorkflowId = @SampleWorkflowID
END
ELSE
BEGIN
	SELECT a.SampleRequestSubmitID, ISNULL(b.ApprovedType,0) AS ApprovedType
	FROM pSampleRequestSubmit a WITH(NOLOCK)
		LEFT OUTER JOIN  dbo.pSampleRequestSubmitStatus b ON a.Status =  b.StatusID
	WHERE a.Submit =  @Submit 
		AND SampleRequestWorkflowID = @SampleRequestWorkflowID
		AND TradePartnerVendorId = @TradePartnerVendorID
		AND SampleRequestTradeId = @SampleRequestTradeID 
		AND SampleWorkflowId = @SampleWorkflowID
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03678', GetDate())
GO