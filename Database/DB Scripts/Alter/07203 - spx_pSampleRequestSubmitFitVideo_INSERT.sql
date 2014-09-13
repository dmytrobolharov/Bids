IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pSampleRequestSubmitFitVideo_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pSampleRequestSubmitFitVideo_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pSampleRequestSubmitFitVideo_INSERT](
	@FitVideoID   uniqueidentifier,
	@SampleRequestSubmitID uniqueidentifier,	
	@CUser nvarchar(200),
	@CDate datetime,	
	@CTeamID uniqueidentifier)
AS

INSERT INTO pSampleRequestSubmitFitVideo
	(FitVideoID, SampleRequestSubmitID, CUser, CDate, CTeamID)
VALUES (@FitVideoID, @SampleRequestSubmitID, @CUser, @CDate, @CTeamID)



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07203', GetDate())
GO
