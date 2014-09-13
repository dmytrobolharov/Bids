/****** Object:  StoredProcedure [dbo].[spx_StyleSpecImageDataSet_SELECT]    Script Date: 01/26/2011 10:45:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecImageDataSet_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSpecImageDataSet_SELECT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


Create PROCEDURE [dbo].[spx_StyleSpecImageDataSet_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SampleRequestTradeID UNIQUEIDENTIFIER,
@SampleRequestWorkflowID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(5),
@Submit INT
)
AS



	SELECT * FROM vwx_SampleRequestSubmitImage_Select 
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit 
	ORDER BY ImageNo 
     
     
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01063', GetDate())
GO 