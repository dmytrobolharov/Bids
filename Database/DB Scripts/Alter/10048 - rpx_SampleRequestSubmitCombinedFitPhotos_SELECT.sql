IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmitCombinedFitPhotos_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmitCombinedFitPhotos_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmitCombinedFitPhotos_SELECT]
(
	@SampleRequestTradeID UNIQUEIDENTIFIER
	, @SampleRequestWorkflowID UNIQUEIDENTIFIER
)
AS
BEGIN
	;WITH fpc AS(SELECT *, 'MAMAGIC' AS ImageType FROM pSampleRequestSubmitFitPhotosComments)
		, srfp AS (SELECT *, 'MAMAGI' AS ImageType FROM pSampleRequestSubmitFitPhotos)
	SELECT
		(ROW_NUMBER() OVER(ORDER BY srs.Submit, srfp.CDate) - 1) / 2 AS RowNum
		, (ROW_NUMBER() OVER(ORDER BY srs.Submit, srfp.CDate) - 1) % 2 AS ColNum
		, sw.GroupName + ' / ' + CAST(srs.Submit AS NVARCHAR(2))
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
		, dbo.fnx_GetStreamingImagePathFitPhotos (COALESCE(fpc.FitPhotoCommentId, srfp.FitPhotoId), 600, COALESCE(fpc.ImageType, srfp.ImageType)) AS FilePath
		, CONVERT(NVARCHAR(10),COALESCE(fpc.CDate, srfp.CDate), 103) AS CDate, COALESCE(fpc.CUser, srfp.CUser) AS CUser
	FROM pSampleRequestSubmitBOM srs
		INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
		INNER JOIN pSampleRequestSubmitStatus srss ON srs.Status = srss.StatusID
		LEFT JOIN uTradePartner tp ON srs.TradePartnerID = tp.TradePartnerID
		LEFT JOIN uTradePartnerVendor tpv ON srs.TradePartnerVendorID = tpv.TradePartnerVendorID
		INNER JOIN srfp ON srs.SampleRequestTradeID = srfp.SampleRequestTradeID
			AND srs.SampleRequestWorkflowID = srfp.SampleRequestWorkflowID
			AND srs.Submit = srfp.Submit
			AND srs.StyleSet = srfp.StyleSet
		LEFT JOIN fpc ON srfp.FitPhotoId = fpc.FitPhotoId
		LEFT JOIN pMSEvalHeader ON srs.SampleRequestTradeID = pMSEvalHeader.SampleRequestTradeID
			AND srs.SampleRequestWorkflowId = pMSEvalHeader.SampleRequestWorkflowId
			AND srs.StyleSet = pMSEvalHeader.StyleSet		
	WHERE srs.SampleRequestTradeID = @SampleRequestTradeID
		AND srs.SampleRequestWorkflowID = @SampleRequestWorkflowID
	ORDER BY srs.Submit, srfp.CDate
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10048', GetUTCDate())
GO