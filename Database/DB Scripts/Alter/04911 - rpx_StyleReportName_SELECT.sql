IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleReportName_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleReportName_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_StyleReportName_SELECT]
	@RPID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT ISNULL(
		(SELECT ReportPageDescription FROM rReportStylePageItem WHERE ReportPageID = @RPID), 
		(SELECT TOP 1 ReportPageDescription FROM rReportStylePageItemTemp WHERE ReportPageID = @RPID)) 
		as ReportPageDescription

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04911', GetDate())
GO
