IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitItemSummary_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitItemSummary_SEL]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestSubmitItemSummary_SEL] (
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT, 
@TradePartnerVendorID UNIQUEIDENTIFIER,
@SampleRequestWorkflowID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(10),
@TeamID UNIQUEIDENTIFIER
)
AS


SELECT a.Status,
CASE a.Submit 
	WHEN 1 THEN '1st Submit (' + c.Status + ')'
	WHEN 2 THEN '2nd Submit (' + c.Status + ')'
	WHEN 3 THEN '3rd Submit (' + c.Status + ')'
	ELSE CAST(a.Submit AS NVARCHAR(10)) + 'th Submit (' + c.Status + ')'
END AS SubmitHeader,
a.DueDate,
a.RecDate,
a.VendorDate, 
a.EndDate, 
a.Submit, a.StyleID, a.StyleSet, a.TradePartnerVendorID, a.SampleWorkflowID, a.SampleRequestWorkflowID,
a.SampleRequestSubmitID, b.SummaryXML, b.EditXML
FROM pSampleRequestSubmit  a
INNER JOIN  pSampleRequestSubmitStatus c ON a.Status = c.StatusID
LEFT OUTER JOIN pSampleRequestWorkflowStatusSchema b ON (b.SampleWorkflowID = a.SampleWorkflowID AND b.StatusID =  a.Status)
WHERE a.StyleID = @StyleID 
AND a.StyleSet = @StyleSet 
AND a.TradePartnerVendorID  = @TradePartnerVendorID 
AND a.SampleRequestWorkflowID  = @SampleRequestWorkflowID 
AND a.SampleWorkflowID = @SampleWorkflowID 

GO