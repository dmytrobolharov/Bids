IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmitSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmitSummary_SELECT]
GO

CREATE  PROCEDURE [dbo].[rpx_SampleRequestSubmitSummary_SELECT]
(
	@SampleRequestSubmitID nvarchar(50)
)
AS

-- DECLARE @SampleRequestSubmitID nnvarchar(50)
-- SET @SampleRequestSubmitID = '9BF592F9-CD7F-4D8D-9063-E90A54C5ECE3'

/*Variables*/
DECLARE @SampleRequestWorkflowID uniqueidentifier
DECLARE @StyleSet int 

/*Get some other variables needed.*/
SELECT
	@SampleRequestWorkflowID = SampleRequestWorkflowID
	,@StyleSet = StyleSet
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

/*Select the final information.*/
SELECT
	uTradePartner.TradePartnerName
	,uTradePartnerVendor.VendorName
	,pSampleWorkflow.GroupName
	,pSampleRequestSubmit.Submit
	,pSampleRequestSubmit.RecDate
	,pSampleRequestSubmit.VendorDate
	,pSampleRequestSubmit.DueDate
	,REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u') AS Comment
	,pSampleRequestSpecItem.POM
	,pSampleRequestSpecItem.PointMeasur
	,pSampleRequestSpecItem.Ask
	,pSampleRequestSpecItem.Spec
	,pSampleRequestSpecItem.[Var]
	,pSampleRequestSpecItem.Rev
FROM pSampleRequestSubmit
	INNER JOIN pSampleRequestSpecItem ON pSampleRequestSubmit.SampleRequestWorkflowID = pSampleRequestSpecItem.SampleRequestWorkflowID
										AND pSampleRequestSubmit.Submit = pSampleRequestSpecItem.Submit
	INNER JOIN pSampleWorkflow ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN uTradePartner ON pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID
	INNER JOIN uTradePartnerVendor ON pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE pSampleRequestSubmit.SampleRequestWorkflowID = @SampleRequestWorkflowID
	AND pSampleRequestSubmit.StyleSet = @StyleSet
ORDER BY
	pSampleRequestSubmit.Submit
	,pSampleRequestSpecItem.Sort
	,pSampleRequestSpecItem.POM


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08580', GetDate())
GO
