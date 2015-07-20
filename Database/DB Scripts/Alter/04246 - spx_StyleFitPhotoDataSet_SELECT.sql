IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFitPhotoDataSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFitPhotoDataSet_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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


	SELECT  
	'<img id="img_' + LOWER(CAST(a.FitPhotoId AS VARCHAR(40))) + '" src="../System/Control/ImageStream.ashx?IT=MAMAGI&ID=' + CAST(a.FitPhotoId AS VARCHAR(40)) + '&s=150" />' AS sImage,
	a.FitPhotoID, a.FitPhotoDescription, a.MUser, a.FrameCount, a.Width, a.Height, a.CUser, a.Sort, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = a.CTeamID) THEN 0 ELSE 1 END as IsSrmOn
	FROM pSampleRequestSubmitFitPhotos a WITH(NOLOCK)
    WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
    AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
    AND SampleWorkflowID = @SampleWorkflowID AND Submit = @Submit AND SampleRequestTradeID = @SampleRequestTradeID
    ORDER BY Sort

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04246', GetDate())
GO

