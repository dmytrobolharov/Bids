IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhotoDataSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhotoDataSet_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleFitPhotoDataSet_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SampleRequestWorkflowID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(5),
@SampleRequestTradeID UNIQUEIDENTIFIER,
@Submit INT
)
AS

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
	a.FitPhotoID, a.FitPhotoDescription, a.MUser, a.FrameCount, a.Width, a.Height, a.CUser, a.Sort, 
	CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = a.CTeamID) THEN 0 ELSE 1 END as IsSrmOn,
	0 AS IsVideo
	FROM pSampleRequestSubmitFitPhotos a WITH(NOLOCK)
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit AND SampleRequestTradeID = @SampleRequestTradeID    
    
    UNION

	SELECT  
	'<img id="img_' + LOWER(CAST(a.FitVideoID AS nVARCHAR(40))) + '" src="' + @ImageServer + '/ImageStream.ashx?IT=MAMAGI&ID=' + CAST(a.FitVideoID AS nVARCHAR(40)) + '&s=150" />' AS sImage,
	a.FitVideoID AS FitPhotoID, '' AS FitPhotoDescription, a.CUser AS MUser, 0 AS FrameCount, 0 AS Width, 0 AS Height, a.CUser, Sort, 
	CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = a.CTeamID) THEN 0 ELSE 1 END as IsSrmOn,
	1 AS IsVideo
	FROM pSampleRequestSubmitFitVideo a WITH(NOLOCK)
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	ORDER BY Sort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07204', GetDate())
GO
