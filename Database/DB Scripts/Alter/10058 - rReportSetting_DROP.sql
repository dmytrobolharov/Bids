IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportsetting_ReportsettingId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportSetting] DROP CONSTRAINT [DF_rReportsetting_ReportsettingId]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportSetting]') AND type in (N'U'))
DROP TABLE [dbo].[rReportSetting]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10058', GetUTCDate())
GO