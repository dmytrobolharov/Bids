IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestGCCWorkflow_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SampleRequestGCCWorkflow_SEL]
GO


CREATE VIEW [dbo].[vwx_SampleRequestGCCWorkflow_SEL] 
AS 

	SELECT a.SampleRequestGCCWorkflowID, a.SampleRequestSubmitID, a.Custom1, a.Custom2, a.Custom3, a.Custom4, ISNULL(a.Custom5,0) AS Custom5,
		a.Custom6, a.Sort, a.MDate, a.MUser, a.CUser, a.CDate, a.SampleRequestSubmitVendorID,
		c.TradePartnerVendorID, b.Submit, b.SampleWorkflowID, b.SampleRequestTradeID
	FROM pSampleRequestGCCWorkflow a	
	INNER JOIN  pSampleRequestSubmitBOM b ON a.SampleRequestSubmitID =  b.SampleRequestSubmitID
	INNER JOIN dbo.pSampleRequestBOMTrade c ON c.SampleRequestTradeID =  b.SampleRequestTradeID

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02574'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02574', GetDate())

END
GO