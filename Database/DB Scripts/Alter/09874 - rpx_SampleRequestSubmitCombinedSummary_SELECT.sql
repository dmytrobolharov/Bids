IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmitCombinedSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmitCombinedSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmitCombinedSummary_SELECT]
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
		sw.GroupName + ' / ' + CAST(srs.Submit AS NVARCHAR(2))
			+ CASE srs.Submit WHEN 0 THEN 'th' WHEN 1 THEN 'st' WHEN 2 THEN 'nd' WHEN 3 THEN 'rd' ELSE 'th' END
			+ ' Submit' AS HeadingStr
		, srss.Status AS StatusDescription, tp.TradePartnerName AS TradePartnerName
		, tpv.VendorName AS VendorName, CONVERT(NVARCHAR(10), srs.DueDate, 103) AS DueDate
		, srs.RecBy AS ReceivedBy, CONVERT(NVARCHAR(10), srs.RecDate, 103) AS ReceivedDate
		, srs.EndBy AS ApprovedBy, CONVERT(NVARCHAR(10), srs.EndDate, 103) AS ApprovedDate
		, srs.VendorName AS VendorBy, CONVERT(NVARCHAR(10), srs.VendorDate, 103) AS VendorDate
		, srs.RevBy AS ReviewedBy, CONVERT(NVARCHAR(10), srs.RevDate, 103) AS ReviewedDate
		, srs.RecWeight AS ReceivedWeight, srs.VendorWeight AS VendorWeight, srs.RecCarrier AS ShipMethod, srs.RecTrackNo AS TrackingNo
		, srs.SampleRequestTradeID, srs.SampleRequestWorkflowId, srs.StyleSet, srs.Submit, srs.SampleRequestSubmitID
	INTO #tmpSRS
	FROM pSampleRequestSubmitBOM srs
		INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
		INNER JOIN pSampleRequestSubmitStatus srss ON srs.Status = srss.StatusID
		LEFT JOIN uTradePartner tp ON srs.TradePartnerID = tp.TradePartnerID
		LEFT JOIN uTradePartnerVendor tpv ON srs.TradePartnerVendorID = tpv.TradePartnerVendorID
	WHERE srs.SampleRequestTradeID = @SampleRequestTradeID
		AND srs.SampleRequestWorkflowID = @SampleRequestWorkflowID

	IF @IsMetric = 0
	BEGIN
		SELECT pMSEvalPOM.RefCode AS POM
			, pMSEvalPOM.POMDescription AS [Description]
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalPOM.TolPlus) AS TolPlus
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalPOM.TolMinus) AS TolMinus
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.EvalMeasValue) AS EvalMeasValue
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.VdrMeasValue) AS VdrMeasValue
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.VdrDelta) AS VdrDelta
			, pMSEvalSampMeas.VdrOutTol
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.SampMeasValue) AS SampMeasValue
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.SampDelta) AS SampDelta
			, pMSEvalSampMeas.SampOutTol
			, dbo.fnx_Num2Frac_KeepNegative(pMSEvalSampMeas.RevisedSpec) AS RevisedSpec
			, pMSEvalPOM.SortId
			, pMSEvalHeader.SampleSize
			, srs.*
		FROM #tmpSRS srs
			INNER JOIN pMSEvalHeader ON srs.SampleRequestTradeID = pMSEvalHeader.SampleRequestTradeID
				AND srs.SampleRequestWorkflowId = pMSEvalHeader.SampleRequestWorkflowId
				AND srs.StyleSet = pMSEvalHeader.StyleSet
			INNER JOIN pMSEvalSampLbl ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalSampLbl.SampleRequestHeaderId
				AND srs.Submit = pMSEvalSampLbl.SampleIndex
			INNER JOIN pMSEvalPOM ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalPOM.SampleRequestHeaderId
			INNER JOIN pMSEvalSampMeas ON pMSEvalSampLbl.SampleLabelId = pMSEvalSampMeas.SampleLabelId
				AND pMSEvalPOM.POMRow = pMSEvalSampMeas.POMRow
		ORDER BY
			srs.Submit
			, pMSEvalPOM.SortId
			, pMSEvalPOM.RefCode
			, pMSEvalPOM.POMDescription
	END
	ELSE
	BEGIN
		SELECT pMSEvalPOM.RefCode AS POM
			, pMSEvalPOM.POMDescription AS [Description]
			, pMSEvalPOM.TolPlus
			, pMSEvalPOM.TolMinus
			, pMSEvalSampMeas.EvalMeasValue
			, pMSEvalSampMeas.VdrMeasValue
			, pMSEvalSampMeas.VdrDelta
			, pMSEvalSampMeas.VdrOutTol
			, pMSEvalSampMeas.SampMeasValue
			, pMSEvalSampMeas.SampDelta
			, pMSEvalSampMeas.SampOutTol
			, pMSEvalSampMeas.RevisedSpec
			, pMSEvalPOM.SortId
			, pMSEvalHeader.SampleSize
			, srs.*
		FROM #tmpSRS srs
			INNER JOIN pMSEvalHeader ON srs.SampleRequestTradeID = pMSEvalHeader.SampleRequestTradeID
				AND srs.SampleRequestWorkflowId = pMSEvalHeader.SampleRequestWorkflowId
				AND srs.StyleSet = pMSEvalHeader.StyleSet
			INNER JOIN pMSEvalSampLbl ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalSampLbl.SampleRequestHeaderId
				AND srs.Submit = pMSEvalSampLbl.SampleIndex
			INNER JOIN pMSEvalPOM ON pMSEvalHeader.SampleRequestHeaderId = pMSEvalPOM.SampleRequestHeaderId
			INNER JOIN pMSEvalSampMeas ON pMSEvalSampLbl.SampleLabelId = pMSEvalSampMeas.SampleLabelId
				AND pMSEvalPOM.POMRow = pMSEvalSampMeas.POMRow
		ORDER BY
			srs.Submit
			, pMSEvalPOM.SortId
			, pMSEvalPOM.RefCode
			, pMSEvalPOM.POMDescription	
	END
	
	DROP TABLE #tmpSRS
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09874', GetDate())
GO
