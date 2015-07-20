IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhotoDataSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhotoDataSet_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleFitPhotoDataSet_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @SampleRequestWorkflowID UNIQUEIDENTIFIER
	, @SampleWorkflowID NVARCHAR(5)
	, @SampleRequestTradeID UNIQUEIDENTIFIER
	, @Submit INT
	, @SelectedPhotos NVARCHAR(MAX) = ''
	)
AS
BEGIN
	DECLARE @tmpSelectedPhotos TABLE (FitPhotoID UNIQUEIDENTIFIER)
	INSERT INTO @tmpSelectedPhotos
	SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@SelectedPhotos,',')

	DECLARE @ImageServer NVARCHAR(1000)
	SELECT @ImageServer = AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Server.config' AND AppSettingKey = 'ImageServer'

	DECLARE @SampleRequestSubmitID UNIQUEIDENTIFIER
	SELECT @SampleRequestSubmitID = SampleRequestSubmitID 
	FROM (
		SELECT SampleRequestSubmitID, SampleRequestWorkflowID, Submit FROM pSampleRequestSubmit UNION
		SELECT SampleRequestSubmitID, SampleRequestWorkflowID, Submit FROM pSampleRequestSubmitBOM) srs
	WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND Submit = @Submit

	SELECT  
	'<img id="img_' + LOWER(CAST(a.FitPhotoId AS nVARCHAR(40))) + '" src="' + @ImageServer + '/ImageStream.ashx?IT=MAMAGI&ID=' + CAST(a.FitPhotoId AS nVARCHAR(40)) + '&s=150" />' AS sImage,
	a.FitPhotoID, a.FitPhotoDescription, a.MUser, a.FrameCount, a.Width, a.Height, a.CUser, a.CDate, a.MDate, a.Sort, 
	CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = a.CTeamID) THEN 0 ELSE 1 END as IsSrmOn,
	0 AS IsVideo
	FROM pSampleRequestSubmitFitPhotos a WITH(NOLOCK)
	LEFT JOIN @tmpSelectedPhotos tsp ON a.FitPhotoId = tsp.FitPhotoID
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit AND SampleRequestTradeID = @SampleRequestTradeID    
    AND (tsp.FitPhotoID IS NOT NULL OR @SelectedPhotos = '')
    
    UNION

	SELECT  
	'<img id="img_' + LOWER(CAST(a.FitVideoID AS nVARCHAR(40))) + '" src="' + @ImageServer + '/ImageStream.ashx?IT=MAMAGI&ID=' + CAST(a.FitVideoID AS nVARCHAR(40)) + '&s=150" />' AS sImage,
	a.FitVideoID AS FitPhotoID, FileName AS FitPhotoDescription, a.CUser AS MUser, 0 AS FrameCount, 0 AS Width, 0 AS Height, a.CUser, a.CDate, a.CDate as MDate, Sort, 
	CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = a.CTeamID) THEN 0 ELSE 1 END as IsSrmOn,
	1 AS IsVideo
	FROM pSampleRequestSubmitFitVideo a WITH(NOLOCK)
	LEFT JOIN @tmpSelectedPhotos tsp ON a.FitVideoID = tsp.FitPhotoID
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	AND (tsp.FitPhotoID IS NOT NULL OR @SelectedPhotos = '')
	ORDER BY Sort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08380', GetDate())
GO
