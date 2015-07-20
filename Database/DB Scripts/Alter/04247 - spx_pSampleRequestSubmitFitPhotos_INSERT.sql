IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pSampleRequestSubmitFitPhotos_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pSampleRequestSubmitFitPhotos_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_pSampleRequestSubmitFitPhotos_INSERT] 
	(@FitPhotoId   uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@SampleRequestWorkflowID  uniqueidentifier,
	@SampleWorkflowID nvarchar(50),
	@SampleRequestTradeID  uniqueidentifier,
	@Submit int,
	@FrameCount int,
	@Width int,
	@Height int,
	@Vendor nvarchar(200),
	@CDate datetime,
	@Active int,
	@CTeamID uniqueidentifier)
AS

DECLARE @nSort as int
DECLARE @vcCount as varchar (5)

BEGIN 
	
	SET @nSort = 1
	SET @vcCount =  RIGHT ( '00000' + cast ( @nSort as nvarchar (5) ) , 5 )
	print  'vccount 1 = '  + @vcCount
	
	UPDATE  pSampleRequestSubmitFitPhotos SET Sort = RIGHT ( '00000' + cast ( (Sort + 1) as nvarchar (5) ) , 5 )
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet 
	AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID
	AND Submit = @Submit
	AND SampleRequestTradeID = @SampleRequestTradeID

	INSERT INTO pSampleRequestSubmitFitPhotos
		(FitPhotoId, StyleID, StyleSet, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, Submit, FrameCount, Width, Height, CUser, CDate, Active, Sort, CTeamID)
	VALUES (@FitPhotoId, @StyleID, @StyleSet, @SampleRequestWorkflowID, @SampleWorkflowID, @SampleRequestTradeID, @Submit, @FrameCount, @Width, @Height, @Vendor, @CDate, @Active, @vcCount, @CTeamID)

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04247', GetDate())
GO
