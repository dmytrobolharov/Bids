IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleReportName_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleReportName_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_SampleReportName_SELECT]
	@RPID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT ReportPageDescription FROM rReportSampleRequestSubmitItem 
	WHERE ReportSampleRequestSubmitPageID = @RPID

END
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04962', GetDate())
GO
