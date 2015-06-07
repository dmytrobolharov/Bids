IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmitCombinedComments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmitCombinedComments_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmitCombinedComments_SELECT]
(
	@SampleRequestTradeID UNIQUEIDENTIFIER
	, @SampleRequestWorkflowID UNIQUEIDENTIFIER
)
AS
BEGIN

	DECLARE @FitComments TABLE (SampleRequestSubmitID UNIQUEIDENTIFIER, RowNum INT, FitComments NVARCHAR(MAX), isFullComment BIT)
	
	INSERT INTO @FitComments (SampleRequestSubmitID, FitComments, isFullComment, RowNum)
	SELECT SampleRequestSubmitID, Comment, 1, ROW_NUMBER() OVER (ORDER BY srs.Submit) FROM pSampleRequestSubmitBOM srs
	WHERE srs.SampleRequestTradeID = @SampleRequestTradeID
		AND srs.SampleRequestWorkflowID = @SampleRequestWorkflowID
		AND srs.Comment IS NOT NULL
	
	DECLARE @ROW INT = 1
	DECLARE @TOTAL INT = (SELECT COUNT(*) FROM @FitComments WHERE isFullComment = 1)
	
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @SampleRequestSubmitID UNIQUEIDENTIFIER
		DECLARE @FitComment NVARCHAR(MAX)
		SELECT
			@SampleRequestSubmitID = SampleRequestSubmitID
			, @FitComment = FitComments
		FROM @FitComments
		WHERE isFullComment = 1 AND RowNum = @ROW
		
		INSERT INTO @FitComments (SampleRequestSubmitID, isFullComment, RowNum, FitComments)
		SELECT @SampleRequestSubmitID, 0, position, value
		FROM fnx_Split(ISNULL(REPLACE(REPLACE(CAST(@FitComment AS NVARCHAR(MAX)), 'span', 'u'), '<br />', '|'), ''), '|')
		
		SET @ROW = @ROW + 1
	END

	SELECT
		sw.GroupName + ' / ' + CAST(srs.Submit AS NVARCHAR(2))
			+ CASE srs.Submit WHEN 0 THEN 'th' WHEN 1 THEN 'st' WHEN 2 THEN 'nd' WHEN 3 THEN 'rd' ELSE 'th' END
			+ ' Submit' AS HeadingStr
		, srss.Status AS StatusDescription, tp.TradePartnerName AS TradePartnerName, pMSEvalHeader.SampleSize
		, tpv.VendorName AS VendorName, CONVERT(NVARCHAR(10), srs.DueDate, 103) AS DueDate
		, srs.RecBy AS ReceivedBy, CONVERT(NVARCHAR(10), srs.RecDate, 103) AS ReceivedDate
		, srs.EndBy AS ApprovedBy, CONVERT(NVARCHAR(10), srs.EndDate, 103) AS ApprovedDate
		, srs.VendorName AS VendorBy, CONVERT(NVARCHAR(10), srs.VendorDate, 103) AS VendorDate
		, srs.RevBy AS ReviewedBy, CONVERT(NVARCHAR(10), srs.RevDate, 103) AS ReviewedDate
		, srs.RecWeight AS ReceivedWeight, srs.VendorWeight AS VendorWeight, srs.RecCarrier AS ShipMethod, srs.RecTrackNo AS TrackingNo
		, srs.SampleRequestTradeID, srs.SampleRequestWorkflowId, srs.StyleSet, srs.Submit, srs.SampleRequestSubmitID
		, fc.FitComments, fc.RowNum
	FROM pSampleRequestSubmitBOM srs
		INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
		INNER JOIN pSampleRequestSubmitStatus srss ON srs.Status = srss.StatusID
		INNER JOIN @FitComments fc ON srs.SampleRequestSubmitID = fc.SampleRequestSubmitID
			AND fc.isFullComment = 0
		LEFT JOIN uTradePartner tp ON srs.TradePartnerID = tp.TradePartnerID
		LEFT JOIN uTradePartnerVendor tpv ON srs.TradePartnerVendorID = tpv.TradePartnerVendorID
		LEFT JOIN pMSEvalHeader ON srs.SampleRequestTradeID = pMSEvalHeader.SampleRequestTradeID
			AND srs.SampleRequestWorkflowId = pMSEvalHeader.SampleRequestWorkflowId
			AND srs.StyleSet = pMSEvalHeader.StyleSet		
	WHERE srs.SampleRequestTradeID = @SampleRequestTradeID
		AND srs.SampleRequestWorkflowID = @SampleRequestWorkflowID
	ORDER BY srs.Submit
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10012', GetUTCDate())
GO
