

/****** Object:  Table [dbo].[rReportStyleTemp]    Script Date: 12/02/2011 18:43:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportStyleTemp]') AND type in (N'U'))
DROP TABLE [dbo].[rReportStyleTemp]
GO

/****** Object:  Table [dbo].[rReportStyleTemp]    Script Date: 12/02/2011 18:43:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[rReportStyleTemp](
	[ReportStyleId] [int] IDENTITY(1,1) NOT NULL,
	[DataXmlId] [uniqueidentifier] NOT NULL,
	[StyleId] [uniqueidentifier] NULL,
	[StyleDevelopmentId] [uniqueidentifier] NULL,
	[DataSort] [varchar](5) NULL,
	[CUser] [varchar](200) NULL,
	[CDate] [datetime] NULL,
	[StyleColorwaySeasonYearID] [uniqueidentifier] NULL,
	[SystemCultureId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_rReportStyleTemp] PRIMARY KEY CLUSTERED 
(
	[ReportStyleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02565'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02565', GetDate())
END
GO