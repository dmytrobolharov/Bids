IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhoto_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhoto_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleFitPhoto_DELETE]
(
	@FitPhotoID UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM pSampleRequestSubmitFitPhotos WHERE FitPhotoId = @FitPhotoID
	DELETE FROM pSampleRequestSubmitFitVideo WHERE FitVideoId = @FitPhotoID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08377', GetDate())
GO
