IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestMultiSubmitSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestMultiSubmitSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestMultiSubmitSummary_SELECT]
(
	@SampleRequestTradeID UNIQUEIDENTIFIER
	, @SampleRequestWorkflowID UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @IsMetric INT

	SELECT @IsMetric = IsMetric
	FROM pMSEvalHeader
	WHERE SampleRequestTradeId = @SampleRequestTradeId
		AND SampleRequestWorkflowId = @SampleRequestWorkflowId

	SELECT
		CAST(srs.Submit AS NVARCHAR(2))
			+ CASE srs.Submit WHEN 0 THEN 'th' WHEN 1 THEN 'st' WHEN 2 THEN 'nd' WHEN 3 THEN 'rd' ELSE 'th' END
			+ ' Submit Status' AS HeadingStr
		, srss.Status AS StatusDescription, sw.GroupName
		, srs.SampleRequestTradeID, srs.SampleRequestWorkflowId, srs.StyleSet, srs.Submit, srs.SampleRequestSubmitID
	INTO #tmpSRS
	FROM pSampleRequestSubmitBOM srs
		INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
		INNER JOIN pSampleRequestSubmitStatus srss ON srs.Status = srss.StatusID
	WHERE srs.SampleRequestTradeID = @SampleRequestTradeID
		AND srs.SampleRequestWorkflowID = @SampleRequestWorkflowID

	IF @IsMetric = 0
	BEGIN
		SELECT
			pMSEvalPOM.SortId
			, pMSEvalPOM.RefCode AS POM
			, pMSEvalPOM.POMDescription AS [Description]
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.EvalMeasValue) AS EvalMeasValue
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.RevisedSpec) AS RevisedSpec
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.SampMeasValue) AS SampMeasValue
			, pMSEvalHeader.SampleSize
			, srs.*
		FROM #tmpSRS srs
			LEFT JOIN pMSEvalHeader ON srs.SampleRequestTradeID = pMSEvalHeader.SampleRequestTradeID
				AND srs.SampleRequestWorkflowId = pMSEvalHeader.SampleRequestWorkflowId
				AND srs.StyleSet = pMSEvalHeader.StyleSet
			INNER JOIN pMSEvalSampLbl ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalSampLbl.SampleRequestHeaderId
				AND srs.Submit = pMSEvalSampLbl.SampleIndex
			INNER JOIN pMSEvalPOM ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalPOM.SampleRequestHeaderId
			INNER JOIN pMSEvalSampMeas ON pMSEvalSampLbl.SampleLabelId = pMSEvalSampMeas.SampleLabelId
				AND pMSEvalPOM.POMRow = pMSEvalSampMeas.POMRow
	END
	ELSE
	BEGIN
		SELECT
			pMSEvalPOM.SortId
			, pMSEvalPOM.RefCode AS POM
			, pMSEvalPOM.POMDescription AS [Description]
			, pMSEvalSampMeas.EvalMeasValue
			, pMSEvalSampMeas.RevisedSpec
			, pMSEvalSampMeas.SampMeasValue
			, pMSEvalHeader.SampleSize
			, srs.*
		FROM #tmpSRS srs
			LEFT JOIN pMSEvalHeader ON srs.SampleRequestTradeID = pMSEvalHeader.SampleRequestTradeID
				AND srs.SampleRequestWorkflowId = pMSEvalHeader.SampleRequestWorkflowId
				AND srs.StyleSet = pMSEvalHeader.StyleSet
			INNER JOIN pMSEvalSampLbl ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalSampLbl.SampleRequestHeaderId
				AND srs.Submit = pMSEvalSampLbl.SampleIndex
			INNER JOIN pMSEvalPOM ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalPOM.SampleRequestHeaderId
			INNER JOIN pMSEvalSampMeas ON pMSEvalSampLbl.SampleLabelId = pMSEvalSampMeas.SampleLabelId
				AND pMSEvalPOM.POMRow = pMSEvalSampMeas.POMRow
	END
	
	DROP TABLE #tmpSRS
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09995', GetUTCDate())
GO
