IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_FitPhotos_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_FitPhotos_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmit_FitPhotos_SELECT]
(
	@SRSID UNIQUEIDENTIFIER
)
AS
BEGIN
	;WITH fpc AS(SELECT *, 'MAMAGIC' AS ImageType FROM pSampleRequestSubmitFitPhotosComments)
		, fp AS (SELECT *, 'MAMAGI' AS ImageType FROM pSampleRequestSubmitFitPhotos)
	SELECT
		dbo.fnx_GetStreamingImagePathFitPhotos (COALESCE(fpc.FitPhotoCommentId, fp.FitPhotoId), 600, COALESCE(fpc.ImageType, fp.ImageType)) AS FilePath
		, COALESCE(fpc.CUser, fp.CUser) AS CUser
		, COALESCE(fpc.CDate, fp.CDate) AS CDate
	FROM  fp
		LEFT JOIN  fpc ON fp.FitPhotoId = fpc.FitPhotoId
		LEFT JOIN pSampleRequestSubmitBOM srsb ON fp.SampleRequestTradeID = srsb.SampleRequestTradeID
			AND fp.StyleID = srsb.StyleID
			AND fp.StyleSet = srsb.StyleSet
			AND fp.SampleRequestWorkflowID = srsb.SampleRequestWorkflowID
			AND fp.SampleWorkflowID = srsb.SampleWorkflowID
			AND fp.Submit = srsb.Submit
		LEFT JOIN pSampleRequestSubmit srs ON fp.SampleRequestTradeID = srs.SampleRequestTradeID
			AND fp.StyleID = srs.StyleID
			AND fp.StyleSet = srs.StyleSet
			AND fp.SampleRequestWorkflowID = srs.SampleRequestWorkflowID
			AND fp.SampleWorkflowID = srs.SampleWorkflowID
			AND fp.Submit = srs.Submit
	WHERE srsb.SampleRequestSubmitID = @SRSID
	ORDER BY CDate

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10047', GetUTCDate())
GO