ALTER TABLE [dbo].[rReportTechPackPageItem] ALTER COLUMN [ReportTechPackFolderID] UNIQUEIDENTIFIER NOT NULL
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[rReportTechPackPageItem]') AND name = N'PK_rReportTechPackPageItem')
ALTER TABLE [dbo].[rReportTechPackPageItem] DROP CONSTRAINT [PK_rReportTechPackPageItem]
GO

ALTER TABLE [dbo].[rReportTechPackPageItem] ADD  CONSTRAINT [PK_rReportTechPackPageItem] PRIMARY KEY CLUSTERED 
(
	[ReportTechPackPageID] ASC
	, [ReportTechPackFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08956', GetDate())
GO
