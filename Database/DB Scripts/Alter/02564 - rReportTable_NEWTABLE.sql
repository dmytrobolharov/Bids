
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportTable_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportTable] DROP CONSTRAINT [DF_rReportTable_CDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportTable_ReportTableRepId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportTable] DROP CONSTRAINT [DF_rReportTable_ReportTableRepId]
END

GO

/****** Object:  Table [dbo].[rReportTable]    Script Date: 11/27/2011 18:32:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportTable]') AND type in (N'U'))
DROP TABLE [dbo].[rReportTable]
GO

/****** Object:  Table [dbo].[rReportTable]    Script Date: 11/27/2011 18:32:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[rReportTable](
	[ReportTableId] [int] IDENTITY(1,1) NOT NULL,
	[ReportTableRepId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleID] [uniqueidentifier] NOT NULL,	
	[DataXmlId] [uniqueidentifier] NOT NULL,
	[DataColumnNumber] [int] NULL,
	[DataColumnName] [nvarchar](200) NULL,
	[DataHeader] [nvarchar](200) NULL,
	[DataValue] [nvarchar](4000) NULL,
	[DataSort] [varchar](5) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_rReportTable] PRIMARY KEY CLUSTERED 
(
	[ReportTableId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportTable_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportTable] ADD  CONSTRAINT [DF_rReportTable_CDate]  DEFAULT (getdate()) FOR [CDate]
END

GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportTable_ReportTableRepId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportTable] ADD  CONSTRAINT [DF_rReportTable_ReportTableRepId]  DEFAULT (newid()) FOR [ReportTableRepId]
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02564'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02564', GetDate())
END
GO