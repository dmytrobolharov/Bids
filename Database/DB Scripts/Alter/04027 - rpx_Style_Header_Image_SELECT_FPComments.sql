/****** Object:  StoredProcedure [dbo].[rpx_Style_Header_Image_SELECT_FPComments]    Script Date: 09/28/2012 12:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_SELECT_FPComments]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Header_Image_SELECT_FPComments]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Style_Header_Image_SELECT_FPComments]    Script Date: 09/28/2012 12:25:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_Style_Header_Image_SELECT_FPComments]
(
	@SRSID varchar(255),
	@FDIM VARCHAR(1) = NULL
)
AS


--Comment #02
/*Declare variables.*/
DECLARE @SampleRequestTradeID nvarchar(50)
DECLARE @StyleID nvarchar(50)
DECLARE @StyleSet int
DECLARE @SampleRequestWorkflowID nvarchar(50)
DECLARE @SampleWorkflowID nvarchar(50)
DECLARE @Submit int
DECLARE @FitPhotoCommentId nvarchar(50)
DECLARE @CUser nvarchar(50)
DECLARE @MDate datetime
/*DECLARE @FitPhotoId nvarchar(50)*/

--Comment #02
/*Get 'Season' and 'Year'.*/
if @FDIM = '1'
	begin
		SELECT @SampleRequestTradeID = SampleRequestTradeID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
			,@SampleRequestWorkflowID = SampleRequestWorkflowID
			,@SampleWorkflowID = SampleWorkflowID
			,@Submit = Submit
		FROM pSampleRequestSubmitBOM
		WHERE SampleRequestSubmitID = @SRSID
	end
else
	begin
		SELECT @SampleRequestTradeID = SampleRequestTradeID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
			,@SampleRequestWorkflowID = SampleRequestWorkflowID
			,@SampleWorkflowID = SampleWorkflowID
			,@Submit = Submit
		FROM pSampleRequestSubmit
		WHERE SampleRequestSubmitID = @SRSID
	end

SELECT dbo.fnx_GetStreamingImagePath_FPComments(FitPhotoCommentId) AS FilePath
	,CUser
	,CDate
FROM pSampleRequestSubmitFitPhotosComments
WHERE FitPhotoId IN (
SELECT FitPhotoId
FROM pSampleRequestSubmitFitPhotos
WHERE SampleRequestTradeID = @SampleRequestTradeID
	AND StyleID = @StyleID
	AND StyleSet = @StyleSet
	AND SampleRequestWorkflowID = @SampleRequestWorkflowID
	AND SampleWorkflowID = @SampleWorkflowID
	AND Submit = @Submit
	)
	ORDER BY FitPhotoId, CDate

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04027', GetDate())
GO