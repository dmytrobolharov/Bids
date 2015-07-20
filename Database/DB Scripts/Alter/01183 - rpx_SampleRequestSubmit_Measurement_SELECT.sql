IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_Measurement_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_Measurement_SELECT]
GO

CREATE PROCEDURE rpx_SampleRequestSubmit_Measurement_SELECT
(
	@SampleRequestSubmitId NVARCHAR(50)
)
AS


/*Declare variables.*/
DECLARE @IsMetric INT

DECLARE @SampleRequestTradeId NVARCHAR(50)
DECLARE @SampleRequestWorkflowId NVARCHAR(50)
DECLARE @Submit NVARCHAR(5)
DECLARE @StyleSet NVARCHAR(5)


/*Get some other variables needed.*/
SELECT
	@SampleRequestTradeID = SampleRequestTradeID
	,@SampleRequestWorkflowID = SampleRequestWorkflowID
	,@StyleSet = StyleSet
	,@Submit = Submit
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID


/*Determine measurement system.*/
SELECT @IsMetric = IsMetric
FROM pMSEvalHeader
WHERE SampleRequestTradeId = @SampleRequestTradeId
	AND SampleRequestWorkflowId = @SampleRequestWorkflowId
	AND StyleSet = @StyleSet
	

/*Select*/
IF(@IsMetric = 0)
	BEGIN
		SELECT
			pMSEvalPOM.RefCode AS POM
			,pMSEvalPOM.POMDescription AS [Description]
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalPOM.TolPlus) AS TolPlus
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalPOM.TolMinus) AS TolMinus
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.EvalMeasValue) AS EvalMeasValue
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.VdrMeasValue) AS VdrMeasValue
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.VdrDelta) AS VdrDelta
			,pMSEvalSampMeas.VdrOutTol
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.SampMeasValue) AS SampMeasValue
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.SampDelta) AS SampDelta
			,pMSEvalSampMeas.SampOutTol
			,dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.RevisedSpec) AS RevisedSpec
			
			,pMSEvalPOM.SortId
		FROM pMSEvalHeader
			INNER JOIN pMSEvalSampLbl ON	pMSEvalHeader.SampleRequestHeaderId = pMSEvalSampLbl.SampleRequestHeaderId
			INNER JOIN pMSEvalPOM ON	pMSEvalHeader.SampleRequestHeaderId = pMSEvalPOM.SampleRequestHeaderId
			INNER JOIN pMSEvalSampMeas ON	pMSEvalSampLbl.SampleLabelId = pMSEvalSampMeas.SampleLabelId
											AND pMSEvalPOM.POMRow = pMSEvalSampMeas.POMRow
		WHERE pMSEvalHeader.SampleRequestTradeId = @SampleRequestTradeId
			AND pMSEvalHeader.SampleRequestWorkflowId = @SampleRequestWorkflowId
			AND pMSEvalHeader.StyleSet = @StyleSet
			AND pMSEvalSampLbl.SampleIndex = @Submit
		ORDER BY
			pMSEvalPOM.SortId
			,pMSEvalPOM.RefCode
			,pMSEvalPOM.POMDescription
	END
ELSE
	BEGIN
		SELECT
			pMSEvalPOM.RefCode AS POM
			,pMSEvalPOM.POMDescription AS [Description]
			,pMSEvalPOM.TolPlus
			,pMSEvalPOM.TolMinus
			,pMSEvalSampMeas.EvalMeasValue
			,pMSEvalSampMeas.VdrMeasValue
			,pMSEvalSampMeas.VdrDelta
			,pMSEvalSampMeas.VdrOutTol
			,pMSEvalSampMeas.SampMeasValue
			,pMSEvalSampMeas.SampDelta
			,pMSEvalSampMeas.SampOutTol
			,pMSEvalSampMeas.RevisedSpec
			
			,pMSEvalPOM.SortId
		FROM pMSEvalHeader
			INNER JOIN pMSEvalSampLbl ON	pMSEvalHeader.SampleRequestHeaderId = pMSEvalSampLbl.SampleRequestHeaderId
			INNER JOIN pMSEvalPOM ON	pMSEvalHeader.SampleRequestHeaderId = pMSEvalPOM.SampleRequestHeaderId
			INNER JOIN pMSEvalSampMeas ON	pMSEvalSampLbl.SampleLabelId = pMSEvalSampMeas.SampleLabelId
											AND pMSEvalPOM.POMRow = pMSEvalSampMeas.POMRow
		WHERE pMSEvalHeader.SampleRequestTradeId = @SampleRequestTradeId
			AND pMSEvalHeader.SampleRequestWorkflowId = @SampleRequestWorkflowId
			AND pMSEvalHeader.StyleSet = @StyleSet
			AND pMSEvalSampLbl.SampleIndex = @Submit
		ORDER BY
			pMSEvalPOM.SortId
			,pMSEvalPOM.RefCode
			,pMSEvalPOM.POMDescription
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01183', GetDate())
GO