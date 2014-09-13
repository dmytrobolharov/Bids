IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestGCCWorkflow_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestGCCWorkflow_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_SampleRequestGCCWorkflow_SEL]
AS
SELECT     a.SampleRequestGCCWorkflowID, a.SampleRequestSubmitID, a.Custom1, a.Custom2, a.Custom3, a.Custom4, ISNULL(a.Custom5, 0) AS Custom5, a.Custom6, a.Sort, 
                      a.MDate, a.MUser, a.CUser, a.CDate, a.SampleRequestSubmitVendorID, c.TradePartnerVendorID, b.SampleWorkflowID, b.SampleRequestTradeID, a.Submit
FROM         dbo.pSampleRequestGCCWorkflow AS a INNER JOIN
                      dbo.pSampleRequestSubmit AS b ON a.SampleRequestSubmitID = b.SampleRequestSubmitID INNER JOIN
                      dbo.pSampleRequestTrade AS c ON c.SampleRequestTradeID = b.SampleRequestTradeID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03037'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03037', GetDate())

END

GO
