/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasSample_UPDATE]    Script Date: 07/02/2013 15:46:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasSample_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasSample_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasSample_UPDATE]    Script Date: 07/02/2013 15:46:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasSample_UPDATE]
(
	@SampleRequestMeasHdrId UNIQUEIDENTIFIER,
	@Submit INT,
	@PostRev int,
	@CopySpec int,
	@CopyRev int,
	@CopyFromSpec int,
	@CopyFromRev int
)
AS 

SET NOCOUNT ON



IF @CopySpec = 1   
BEGIN

	update pSampleRequestAMLMeasPOM set SampMeasValue=(SELECT TOP 1 igc.Incr from pSampleRequestAMLMeasIGC igc INNER JOIN pSampleRequestAMLMeasLbl lbl on lbl.SizeCol = igc.SizeCol and lbl.IsSample=1 and lbl.SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId and igc.SampleRequestAMLMeasPOMId = pSampleRequestAMLMeasPOM.SampleRequestAMLMeasPOMId) where SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId

END

IF @CopyRev = 1 
BEGIN

	If @CopyFromRev = 1
	BEGIN
		update pSampleRequestAMLMeasPOM set RevisedSpec=(SELECT TOP 1 igc.Incr from pSampleRequestAMLMeasIGC igc INNER JOIN pSampleRequestAMLMeasLbl lbl on lbl.SizeCol = igc.SizeCol and lbl.IsSample=1 and lbl.SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId and igc.SampleRequestAMLMeasPOMId = pSampleRequestAMLMeasPOM.SampleRequestAMLMeasPOMId) where SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId
	END

	If @CopyFromRev = 2
	BEGIN
		update pSampleRequestAMLMeasPOM set RevisedSpec=SampMeasValue where SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId
	END
	
END

	update pSampleRequestAMLMeasPOM set SampDelta=SampMeasValue - (SELECT TOP 1 igc.Incr from pSampleRequestAMLMeasIGC igc INNER JOIN pSampleRequestAMLMeasLbl lbl on lbl.SizeCol = igc.SizeCol and lbl.IsSample=1 and lbl.SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId and igc.SampleRequestAMLMeasPOMId = pSampleRequestAMLMeasPOM.SampleRequestAMLMeasPOMId) where SampleRequestAMLMeasHdrId=@SampleRequestMeasHdrId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05979', GetDate())
GO