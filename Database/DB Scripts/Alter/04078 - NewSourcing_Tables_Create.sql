IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingHeader_SourcingHeaderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingHeader] DROP CONSTRAINT [DF_pSourcingHeader_SourcingHeaderID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHeader]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingHeader]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingHeader](
	[SourcingHeaderID] [uniqueidentifier] NOT NULL,
	[SourcingName] [nvarchar](100) NULL,
	[SourcingType] [nvarchar](50) NULL,
	[StyleCategoryID] [uniqueidentifier] NULL,
	[SourcingWorkflowTemplateID] [uniqueidentifier] NULL,
	[Division] [nvarchar](50) NULL,
	[Season] [nvarchar](50) NULL,
	[Year] [nvarchar](50) NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
	[Custom6] [nvarchar](200) NULL,
	[Custom7] [nvarchar](200) NULL,
	[Custom8] [nvarchar](200) NULL,
	[Custom9] [nvarchar](200) NULL,
	[Custom10] [nvarchar](200) NULL,
 CONSTRAINT [PK_pSourcingHeader] PRIMARY KEY CLUSTERED 
(
	[SourcingHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingHeader] ADD  CONSTRAINT [DF_pSourcingHeader_SourcingHeaderID]  DEFAULT (newsequentialid()) FOR [SourcingHeaderID]
GO

----------------------------------------------------------------
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyle_SourcingStyleID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyle] DROP CONSTRAINT [DF_pSourcingStyle_SourcingStyleID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingStyle]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingStyle]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingStyle](
	[SourcingStyleID] [uniqueidentifier] NOT NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[Styleset] [int] NULL,
	[Progress] [decimal](18, 4) NULL,
	[Complexity] [nvarchar](50) NULL,
	[Priority] [nvarchar](50) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
 CONSTRAINT [PK_pSourcingStyle] PRIMARY KEY CLUSTERED 
(
	[SourcingStyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingStyle] ADD  CONSTRAINT [DF_pSourcingStyle_SourcingStyleID]  DEFAULT (newsequentialid()) FOR [SourcingStyleID]
GO
---------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingTradePartner_SourcingTradePartnerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingTradePartner] DROP CONSTRAINT [DF_pSourcingTradePartner_SourcingTradePartnerID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingTradePartner]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingTradePartner]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingTradePartner](
	[SourcingTradePartnerID] [uniqueidentifier] NOT NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerLevelID] [uniqueidentifier] NULL,
	[TradePartnerTypeID] [uniqueidentifier] NULL,
	[ProductTypes] [nvarchar](400) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
 CONSTRAINT [PK_pSourcingTradePartner] PRIMARY KEY CLUSTERED 
(
	[SourcingTradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingTradePartner] ADD  CONSTRAINT [DF_pSourcingTradePartner_SourcingTradePartnerID]  DEFAULT (newsequentialid()) FOR [SourcingTradePartnerID]
GO

--------------------------------------------------------------------
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingWorkflow_SourcingWorkflowID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingWorkflow] DROP CONSTRAINT [DF_pSourcingWorkflow_SourcingWorkflowID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingWorkflow_WorkflowType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingWorkflow] DROP CONSTRAINT [DF_pSourcingWorkflow_WorkflowType]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingWorkflow]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingWorkflow]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingWorkflow](
	[SourcingWorkflowID] [uniqueidentifier] NOT NULL,
	[WorkflowName] [nvarchar](100) NULL,
	[WorkflowType] [nvarchar](50) NOT NULL,
	[WorkDays] [int] NULL,
	[WorkAlert] [int] NULL,
	[Active] [bit] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingWorkflow] PRIMARY KEY CLUSTERED 
(
	[SourcingWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingWorkflow] ADD  CONSTRAINT [DF_pSourcingWorkflow_SourcingWorkflowID]  DEFAULT (newsequentialid()) FOR [SourcingWorkflowID]
GO

ALTER TABLE [dbo].[pSourcingWorkflow] ADD  CONSTRAINT [DF_pSourcingWorkflow_WorkflowType]  DEFAULT ('D') FOR [WorkflowType]
GO

--------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingWorkflowTemplate_SourcingWorkflowTemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingWorkflowTemplate] DROP CONSTRAINT [DF_pSourcingWorkflowTemplate_SourcingWorkflowTemplateID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingWorkflowTemplate_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingWorkflowTemplate] DROP CONSTRAINT [DF_pSourcingWorkflowTemplate_Active]
END

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingWorkflowTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingWorkflowTemplate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingWorkflowTemplate](
	[SourcingWorkflowTemplateID] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](100) NULL,
	[TemplateDescription] [nvarchar](250) NULL,
	[Active] [nvarchar](5) NULL,
	[EnforceDependency] [int] NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ScheduleBy] [nvarchar](50) NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingWorkflowTemplate] PRIMARY KEY CLUSTERED 
(
	[SourcingWorkflowTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingWorkflowTemplate] ADD  CONSTRAINT [DF_pSourcingWorkflowTemplate_SourcingWorkflowTemplateID]  DEFAULT (newsequentialid()) FOR [SourcingWorkflowTemplateID]
GO

ALTER TABLE [dbo].[pSourcingWorkflowTemplate] ADD  CONSTRAINT [DF_pSourcingWorkflowTemplate_Active]  DEFAULT ((1)) FOR [Active]
GO

---------------------------------------------------------------------
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_WorkflowTemplateItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingWorkflowTemplateItem] DROP CONSTRAINT [DF_Table_1_WorkflowTemplateItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_WorkflowSort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingWorkflowTemplateItem] DROP CONSTRAINT [DF_Table_1_WorkflowSort]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingWorkflowTemplateItem]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingWorkflowTemplateItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingWorkflowTemplateItem](
	[SourcingWorkflowTemplateItemID] [uniqueidentifier] NOT NULL,
	[SourcingWorkflowTemplateID] [uniqueidentifier] NULL,
	[SourcingWorkflowID] [uniqueidentifier] NULL,
	[WorkflowAssignedTo] [int] NULL,
	[WorkflowDays] [int] NULL,
	[WorkflowAlerts] [int] NULL,
	[WorkflowTemplateItemStatusItemID] [uniqueidentifier] NULL,
	[DueDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[WorkflowAccessTypeID] [int] NULL,
	[WorkflowEscalateTo] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingWorkflowTemplateItem] PRIMARY KEY CLUSTERED 
(
	[SourcingWorkflowTemplateItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingWorkflowTemplateItem] ADD  CONSTRAINT [DF_Table_1_WorkflowTemplateItemID]  DEFAULT (newsequentialid()) FOR [SourcingWorkflowTemplateItemID]
GO

ALTER TABLE [dbo].[pSourcingWorkflowTemplateItem] ADD  CONSTRAINT [DF_Table_1_WorkflowSort]  DEFAULT ((0)) FOR [Sort]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04078', GetDate())

GO
