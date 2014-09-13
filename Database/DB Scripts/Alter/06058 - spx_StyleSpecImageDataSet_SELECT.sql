/****** Object:  StoredProcedure [dbo].[spx_StyleSpecImageDataSet_SELECT]    Script Date: 07/15/2013 16:20:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecImageDataSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSpecImageDataSet_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSpecImageDataSet_SELECT]    Script Date: 07/15/2013 16:20:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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


	SELECT * FROM vwx_SampleRequestSubmitImage_Select WITH(NOLOCK)
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit 
	ORDER BY ImageNo 


     

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06058', GetDate())
GO
