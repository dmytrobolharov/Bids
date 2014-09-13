

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportStylePageItem_Temp_Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportStylePageItemTemp] DROP CONSTRAINT [DF_rReportStylePageItem_Temp_Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rReportStylePageItemTemp_ReportStylePageItemTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rReportStylePageItemTemp] DROP CONSTRAINT [DF_rReportStylePageItemTemp_ReportStylePageItemTempID]
END

GO


/****** Object:  Table [dbo].[rReportStylePageItemTemp]    Script Date: 12/02/2011 12:56:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportStylePageItemTemp]') AND type in (N'U'))
DROP TABLE [dbo].[rReportStylePageItemTemp]
GO


/****** Object:  Table [dbo].[rReportStylePageItemTemp]    Script Date: 12/02/2011 12:56:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[rReportStylePageItemTemp](
	[ReportStylePageItemTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,	
	[ReportStylePageItemID] [uniqueidentifier] NOT NULL,
	[ReportPageID] [uniqueidentifier] NOT NULL,
	[ReportTechpackID] [uniqueidentifier] NOT NULL,
	[ReportMapID] [uniqueidentifier] NULL,
	[ReportPageTypeID] [uniqueidentifier] NULL,
	[WorkflowItemID] [uniqueidentifier] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[ReportTemplateName] [nvarchar](200) NULL,
	[ReportPageName] [nvarchar](200) NULL,
	[ReportPageDescription] [nvarchar](4000) NULL,
	[ReportServerType] [varchar](5) NULL,
	[ReportFormName] [varchar](250) NULL,
	[ReportPageURL] [varchar](250) NULL,
	[ReportPKIField] [varchar](200) NULL,
	[ReportPageActive] [int] NULL,
	[ReportPageFormat] [varchar](7) NULL,
	[ReportSrmOn] [int] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[StyleDevelopmentID] [uniqueidentifier] NULL,
	[StyleHeaderID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [varchar] (5) NULL,
	[TechPackName] [nvarchar](100) NULL,
	[TechPackFinal] [int] NULL,
	[Variation] [int] NULL,
	[StyleColorwaySeasonYearID] [uniqueidentifier] NULL,

 CONSTRAINT [PK_rReportStylePageItemTemp] PRIMARY KEY CLUSTERED 
(
	[ReportStylePageItemTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[rReportStylePageItemTemp] ADD  CONSTRAINT [DF_rReportStylePageItem_Temp_Sort]  DEFAULT ((0)) FOR [Sort]
GO

ALTER TABLE [dbo].[rReportStylePageItemTemp] ADD  CONSTRAINT [DF_rReportStylePageItemTemp_ReportStylePageItemTempID]  DEFAULT (newsequentialid()) FOR [ReportStylePageItemTempID]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02566'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02566', GetDate())
END
GO