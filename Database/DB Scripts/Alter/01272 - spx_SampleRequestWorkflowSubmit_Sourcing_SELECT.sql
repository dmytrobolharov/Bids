IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSubmit_Sourcing_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSubmit_Sourcing_SELECT]
GO


CREATE PROCEDURE dbo.spx_SampleRequestWorkflowSubmit_Sourcing_SELECT(
	@StyleID UNIQUEIDENTIFIER, 
	@StyleSet INT,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@Submit INT
)
AS 

	SELECT b.StyleSourcingID, a.SampleRequestTradeID, a.MaterialName, a.SampleRequestMaterialID,
	a.StyleColorID,a.StyleMaterialID
	FROM pSampleRequestMaterial a WITH(NOLOCK)
		INNER JOIN pSampleRequestTrade b WITH(NOLOCK) ON a.SampleRequestTradeID = b.SampleRequestTradeID
	WHERE a.StyleID = @StyleID 
		AND a.StyleSet = @StyleSet 
		AND a.SampleRequestTradeID = @SampleRequestTradeID 
		AND a.SampleRequestWorkflowID = @SampleRequestWorkflowID 
		AND a.SampleWorkflowID = @SampleWorkflowID AND a.Submit = @Submit 
	ORDER BY a.MainMaterial DESC, a.MaterialNo, a.MaterialName 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01272', GetDate())
GO