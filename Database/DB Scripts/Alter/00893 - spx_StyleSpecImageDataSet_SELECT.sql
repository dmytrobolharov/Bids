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



	SELECT * FROM pSampleRequestSubmitImage 
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit 
	ORDER BY ImageNo 
     
     

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '893', GetDate())

GO

