
/****** Object:  ForeignKey [FK_pTACalTask_pTACalTemplateTask]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTask]'))
ALTER TABLE [dbo].[pTACalTask] DROP CONSTRAINT [FK_pTACalTask_pTACalTemplateTask]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTask_pTACalTemplate]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTACalTemplate]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTask_pTATaskType]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTATaskType]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTask_pTATaskWorkflow]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskWorkflow]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTATaskWorkflow]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTaskDep_pTACalTemplateTask]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep] DROP CONSTRAINT [FK_pTACalTemplateTaskDep_pTACalTemplateTask]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTaskDep_pTATaskDepType]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTATaskDepType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep] DROP CONSTRAINT [FK_pTACalTemplateTaskDep_pTATaskDepType]
GO
/****** Object:  Table [dbo].[pTACalTask]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTask]'))
ALTER TABLE [dbo].[pTACalTask] DROP CONSTRAINT [FK_pTACalTask_pTACalTemplateTask]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalTask_TACalTaskId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalTask] DROP CONSTRAINT [DF_pTACalTask_TACalTaskId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTask]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalTask]
GO
/****** Object:  Table [dbo].[pTACalTemplateTaskDep]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep] DROP CONSTRAINT [FK_pTACalTemplateTaskDep_pTACalTemplateTask]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTATaskDepType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep] DROP CONSTRAINT [FK_pTACalTemplateTaskDep_pTATaskDepType]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalTemplateTaskDep_TACalTemplateTaskDep]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalTemplateTaskDep] DROP CONSTRAINT [DF_pTACalTemplateTaskDep_TACalTemplateTaskDep]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalTemplateTaskDep]
GO
/****** Object:  Table [dbo].[pTACalTemplateTask]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTACalTemplate]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTATaskType]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskWorkflow]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTATaskWorkflow]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalTemplateTask_TACalTemplateTaskId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [DF_pTACalTemplateTask_TACalTemplateTaskId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalTemplateTask]
GO
/****** Object:  Table [dbo].[pTACalTemplate]    Script Date: 05/15/2014 11:23:01 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalTemplate_CalTemplateId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalTemplate] DROP CONSTRAINT [DF_pTACalTemplate_CalTemplateId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalTemplate]
GO
/****** Object:  Table [dbo].[pTATaskDepType]    Script Date: 05/15/2014 11:23:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTATaskDepType]') AND type in (N'U'))
DROP TABLE [dbo].[pTATaskDepType]
GO
/****** Object:  Table [dbo].[pTATaskType]    Script Date: 05/15/2014 11:23:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTATaskType]') AND type in (N'U'))
DROP TABLE [dbo].[pTATaskType]
GO
/****** Object:  Table [dbo].[pTATaskWorkflow]    Script Date: 05/15/2014 11:23:02 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTATaskWorkflow_TATaskWorkflowId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTATaskWorkflow] DROP CONSTRAINT [DF_pTATaskWorkflow_TATaskWorkflowId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTATaskWorkflow]') AND type in (N'U'))
DROP TABLE [dbo].[pTATaskWorkflow]
GO
/****** Object:  Table [dbo].[pTATaskWorkflow]    Script Date: 05/15/2014 11:23:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTATaskWorkflow]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTATaskWorkflow](
	[TATaskWorkflowId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTATaskWorkflow_TATaskWorkflowId]  DEFAULT (newsequentialid()),
	[WorkflowId] [uniqueidentifier] NULL,
	[WorkflowName] [nvarchar](200) NULL,
	[WorkflowFolder] [nvarchar](200) NULL,
 CONSTRAINT [PK_pTATaskWorkflow] PRIMARY KEY CLUSTERED 
(
	[TATaskWorkflowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTATaskType]    Script Date: 05/15/2014 11:23:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTATaskType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTATaskType](
	[TATaskTypeId] [int] NOT NULL,
	[TATaskTypeName] [nvarchar](200) NULL,
 CONSTRAINT [PK_pTATaskType] PRIMARY KEY CLUSTERED 
(
	[TATaskTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTATaskDepType]    Script Date: 05/15/2014 11:23:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTATaskDepType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTATaskDepType](
	[TATaskDepTypeId] [int] NOT NULL,
	[TATaskDepTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_pTADepType] PRIMARY KEY CLUSTERED 
(
	[TATaskDepTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTACalTemplate]    Script Date: 05/15/2014 11:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalTemplate](
	[TACalTemplateId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTACalTemplate_CalTemplateId]  DEFAULT (newsequentialid()),
	[TACalTemplateName] [nvarchar](100) NOT NULL,
	[TACalTemplateDescription] [nvarchar](4000) NULL,
	[SeasonYearId] [uniqueidentifier] NULL,
	[TACalTemplatePlanStart] [date] NULL,
	[TACalTemplatePlanEnd] [date] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pTACalTemplate] PRIMARY KEY CLUSTERED 
(
	[TACalTemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTACalTemplateTask]    Script Date: 05/15/2014 11:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalTemplateTask](
	[TACalTemplateTaskId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTACalTemplateTask_TACalTemplateTaskId]  DEFAULT (newsequentialid()),
	[TACalTemplateId] [uniqueidentifier] NULL,
	[TaskId] [int] NULL,
	[TaskDepId] [int] NULL,
	[TaskDepTypeId] [int] NULL,
	[TaskPlanStart] [date] NULL,
	[TaskPlanEnd] [date] NULL,
	[TaskTypeId] [int] NULL,
	[TaskWorkflowId] [uniqueidentifier] NULL,
	[TaskName] [nvarchar](100) NULL,
	[TaskDuration] [int] NULL,
	[TaskAssignedToId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NOT NULL,
 CONSTRAINT [PK_pTACalTemplateTask] PRIMARY KEY CLUSTERED 
(
	[TACalTemplateTaskId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTACalTemplateTaskDep]    Script Date: 05/15/2014 11:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalTemplateTaskDep](
	[TACalTemplateTaskDep] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTACalTemplateTaskDep_TACalTemplateTaskDep]  DEFAULT (newid()),
	[TACalTemplateTaskParentId] [uniqueidentifier] NULL,
	[TACalTemplateTaskChildId] [uniqueidentifier] NOT NULL,
	[TATaskDepTypeId] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pTACalTemplateTaskDep] PRIMARY KEY CLUSTERED 
(
	[TACalTemplateTaskDep] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTACalTask]    Script Date: 05/15/2014 11:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalTask](
	[TACalTaskId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTACalTask_TACalTaskId]  DEFAULT (newid()),
	[TACalTemplateTaskId] [uniqueidentifier] NULL,
	[TaskReferenceId] [uniqueidentifier] NULL,
	[TaskActualStart] [date] NULL,
	[TaskActualEnd] [date] NULL,
	[TaskAssignedToId] [uniqueidentifier] NULL,
	[TaskStatusId] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pTACalTask] PRIMARY KEY CLUSTERED 
(
	[TACalTaskId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  ForeignKey [FK_pTACalTask_pTACalTemplateTask]    Script Date: 05/15/2014 11:23:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTask]'))
ALTER TABLE [dbo].[pTACalTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTask_pTACalTemplateTask] FOREIGN KEY([TACalTemplateTaskId])
REFERENCES [dbo].[pTACalTemplateTask] ([TACalTemplateTaskId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTask]'))
ALTER TABLE [dbo].[pTACalTask] CHECK CONSTRAINT [FK_pTACalTask_pTACalTemplateTask]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTask_pTACalTemplate]    Script Date: 05/15/2014 11:23:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTemplateTask_pTACalTemplate] FOREIGN KEY([TACalTemplateId])
REFERENCES [dbo].[pTACalTemplate] ([TACalTemplateId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] CHECK CONSTRAINT [FK_pTACalTemplateTask_pTACalTemplate]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTask_pTATaskType]    Script Date: 05/15/2014 11:23:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTemplateTask_pTATaskType] FOREIGN KEY([TaskTypeId])
REFERENCES [dbo].[pTATaskType] ([TATaskTypeId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] CHECK CONSTRAINT [FK_pTACalTemplateTask_pTATaskType]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTask_pTATaskWorkflow]    Script Date: 05/15/2014 11:23:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskWorkflow]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTemplateTask_pTATaskWorkflow] FOREIGN KEY([TaskWorkflowId])
REFERENCES [dbo].[pTATaskWorkflow] ([TATaskWorkflowId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTATaskWorkflow]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] CHECK CONSTRAINT [FK_pTACalTemplateTask_pTATaskWorkflow]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTaskDep_pTACalTemplateTask]    Script Date: 05/15/2014 11:23:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTemplateTaskDep_pTACalTemplateTask] FOREIGN KEY([TACalTemplateTaskParentId])
REFERENCES [dbo].[pTACalTemplateTask] ([TACalTemplateTaskId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep] CHECK CONSTRAINT [FK_pTACalTemplateTaskDep_pTACalTemplateTask]
GO
/****** Object:  ForeignKey [FK_pTACalTemplateTaskDep_pTATaskDepType]    Script Date: 05/15/2014 11:23:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTATaskDepType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTemplateTaskDep_pTATaskDepType] FOREIGN KEY([TATaskDepTypeId])
REFERENCES [dbo].[pTATaskDepType] ([TATaskDepTypeId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTaskDep_pTATaskDepType]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]'))
ALTER TABLE [dbo].[pTACalTemplateTaskDep] CHECK CONSTRAINT [FK_pTACalTemplateTaskDep_pTATaskDepType]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07612', GetDate())
GO