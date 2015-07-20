IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhotoCommentDataSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhotoCommentDataSet_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleFitPhotoCommentDataSet_SELECT]
(
	@FitPhotoID UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @ImageServer NVARCHAR(1000)
	SELECT @ImageServer = AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Server.config' AND AppSettingKey = 'ImageServer'

	SELECT *
		, '<img id="img_' + LOWER(CAST(c.FitPhotoCommentId AS nVARCHAR(40))) + '" src="' + @ImageServer + '/ImageStream.ashx?IT=MAMAGIC&ID=' + CAST(c.FitPhotoCommentId AS nVARCHAR(40)) + '&s=150" />' AS sImage
	FROM pSampleRequestSubmitFitPhotosComments c
	WHERE FitPhotoId = @FitPhotoID
	ORDER BY CDATE ASC

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08379', GetDate())
GO
