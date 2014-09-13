/****** Object:  Table [dbo].[rReportSamplePageItemTemp]    Script Date: 01/26/2012 20:29:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[rReportSamplePageItemTemp](
	[ReportSamplePageItemTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ReportSamplePageItemID] [uniqueidentifier] NOT NULL,
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
	[Sort] [varchar](5) NULL,
	[TechPackName] [nvarchar](100) NULL,
	[TechPackFinal] [int] NULL,
	[Variation] [int] NULL,
	[StyleColorwaySeasonYearID] [uniqueidentifier] NULL,
	 [SampleRequestSubmitId] [uniqueidentifier] NULL, 
	 [SampleRequestWorkflowId] [uniqueidentifier] NULL, 
	 [TradePartnerVendorId] [uniqueidentifier] NULL, 
	 [SampleRequestTradeId] [uniqueidentifier] NULL,  
	 [TeamID] [uniqueidentifier] NULL,  
	 [SampleWorkflowId] [nvarchar](40) NULL, 
	 [SizeIndex] [nvarchar](40) NULL, 
	 [Submit] [nvarchar](5) NULL, 
 CONSTRAINT [PK_rReportSamplePageItemTemp] PRIMARY KEY CLUSTERED 
(
	[ReportSamplePageItemTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[rReportSamplePageItemTemp] ADD  CONSTRAINT [DF_rReportSamplePageItemTemp_ReportSamplePageItemTempID]  DEFAULT (newsequentialid()) FOR [ReportSamplePageItemTempID]
GO

ALTER TABLE [dbo].[rReportSamplePageItemTemp] ADD  CONSTRAINT [DF_rReportSamplePageItem_Temp_Sort]  DEFAULT ((0)) FOR [Sort]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03048'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03048', GetDate())

END

GO 
