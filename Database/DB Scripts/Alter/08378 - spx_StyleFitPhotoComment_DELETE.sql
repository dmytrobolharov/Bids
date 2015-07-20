IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhotoComment_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhotoComment_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleFitPhotoComment_DELETE]
(
	@FitPhotoCommentId UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM pSampleRequestSubmitFitPhotosComments WHERE FitPhotoCommentId = @FitPhotoCommentId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08378', GetDate())
GO
