/****** Object:  StoredProcedure [dbo].[spx_StyleFitPhotoComment_SELECT]    Script Date: 09/28/2012 15:21:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhotoComment_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhotoComment_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleFitPhotoComment_SELECT]    Script Date: 09/28/2012 15:21:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleFitPhotoComment_SELECT](
@FitPhotoId UNIQUEIDENTIFIER
)
AS

	SELECT dbo.fnx_GetStreamingImagePathFitPhotos(CAST(a.FitPhotoCommentId AS VARCHAR(40)), 150, 'MAMAGIC') AS ImagePath,
	a.FitPhotoCommentId, a.CUser, a.MUser  
	FROM pSampleRequestSubmitFitPhotosComments a WITH(NOLOCK)
    WHERE FitPhotoId = @FitPhotoId 
    ORDER BY CDATE ASC




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04028', GetDate())
GO