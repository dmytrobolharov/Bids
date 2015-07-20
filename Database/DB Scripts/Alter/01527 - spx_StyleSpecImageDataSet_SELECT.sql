IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecImageDataSet_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSpecImageDataSet_SELECT]
GO 

CREATE PROCEDURE [dbo].[spx_StyleSpecImageDataSet_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SampleRequestTradeID UNIQUEIDENTIFIER,
@SampleRequestWorkflowID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(5),
@Submit INT
)
AS


	SELECT 
	'<img src="../System/Control/ImageStream.ashx?IT=S&SRTID=' +  CAST(a.SampleRequestTradeID AS VARCHAR(40)) +
	'&TPVID=' +  CAST(a.TradePartnerVendorID AS VARCHAR(40)) + 
	'&L=0&Comp=100&S=100&SRSID=' + CAST(a.SampleRequestSubmitImageID AS VARCHAR(40)) +
	'&IID=' +   CAST(a.ImageID AS VARCHAR(40))+  '&V='  +  CAST(a.Version AS NVARCHAR(5)) +  '" />' AS sImage,
	a.SampleRequestSubmitImageID, a.ImageDescription, a.MUser
	FROM pSampleRequestSubmitImage a WITH(NOLOCK)
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit 
	ORDER BY ImageNo 


     
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01527', GetDate())
GO
