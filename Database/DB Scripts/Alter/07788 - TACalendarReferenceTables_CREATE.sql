/****** Object:  ForeignKey [FK_pTACalReference_pTACalTemplate]    Script Date: 05/31/2014 23:50:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReference_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReference]'))
ALTER TABLE [dbo].[pTACalReference] DROP CONSTRAINT [FK_pTACalReference_pTACalTemplate]
GO
/****** Object:  ForeignKey [FK_pTACalReferenceTask_pTACalReference]    Script Date: 05/31/2014 23:50:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalReference]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask] DROP CONSTRAINT [FK_pTACalReferenceTask_pTACalReference]
GO
/****** Object:  ForeignKey [FK_pTACalReferenceTask_pTACalTemplateTask]    Script Date: 05/31/2014 23:50:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask] DROP CONSTRAINT [FK_pTACalReferenceTask_pTACalTemplateTask]
GO
/****** Object:  Table [dbo].[pTACalReferenceTask]    Script Date: 05/31/2014 23:50:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalReference]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask] DROP CONSTRAINT [FK_pTACalReferenceTask_pTACalReference]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask] DROP CONSTRAINT [FK_pTACalReferenceTask_pTACalTemplateTask]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalReferenceTask_TACalRefTaskId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalReferenceTask] DROP CONSTRAINT [DF_pTACalReferenceTask_TACalRefTaskId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalReferenceTask]
GO
/****** Object:  Table [dbo].[pTACalReference]    Script Date: 05/31/2014 23:50:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReference_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReference]'))
ALTER TABLE [dbo].[pTACalReference] DROP CONSTRAINT [FK_pTACalReference_pTACalTemplate]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalReference_TACalReferenceId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalReference] DROP CONSTRAINT [DF_pTACalReference_TACalReferenceId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReference]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalReference]
GO
/****** Object:  Table [dbo].[pTACalStatus]    Script Date: 05/31/2014 23:50:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalStatus]
GO
/****** Object:  Table [dbo].[pTACalStatus]    Script Date: 05/31/2014 23:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalStatus](
	[StatusID] [int] NOT NULL,
	[StatusName] [nvarchar](256) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTACalReference]    Script Date: 05/31/2014 23:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReference]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalReference](
	[TACalReferenceId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTACalReference_TACalReferenceId]  DEFAULT (newsequentialid()),
	[TACalTemplateId] [uniqueidentifier] NULL,
	[TACalReferenceTypeId] [int] NULL,
	[ReferenceId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pTACalReference] PRIMARY KEY CLUSTERED 
(
	[TACalReferenceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pTACalReferenceTask]    Script Date: 05/31/2014 23:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pTACalReferenceTask](
	[TACalRefTaskId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pTACalReferenceTask_TACalRefTaskId]  DEFAULT (newsequentialid()),
	[TACalTemplateTaskId] [uniqueidentifier] NULL,
	[TACalReferenceId] [uniqueidentifier] NULL,
	[TaskRevisedlStart] [date] NULL,
	[TaskRevisedEnd] [date] NULL,
	[TaskActualStart] [date] NULL,
	[TaskActualEnd] [date] NULL,
	[TaskAssignedToId] [uniqueidentifier] NULL,
	[TaskStatusId] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pTACalReferenceTask] PRIMARY KEY CLUSTERED 
(
	[TACalRefTaskId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  ForeignKey [FK_pTACalReference_pTACalTemplate]    Script Date: 05/31/2014 23:50:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReference_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReference]'))
ALTER TABLE [dbo].[pTACalReference]  WITH CHECK ADD  CONSTRAINT [FK_pTACalReference_pTACalTemplate] FOREIGN KEY([TACalTemplateId])
REFERENCES [dbo].[pTACalTemplate] ([TACalTemplateId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReference_pTACalTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReference]'))
ALTER TABLE [dbo].[pTACalReference] CHECK CONSTRAINT [FK_pTACalReference_pTACalTemplate]
GO
/****** Object:  ForeignKey [FK_pTACalReferenceTask_pTACalReference]    Script Date: 05/31/2014 23:50:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalReference]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalReferenceTask_pTACalReference] FOREIGN KEY([TACalReferenceId])
REFERENCES [dbo].[pTACalReference] ([TACalReferenceId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalReference]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask] CHECK CONSTRAINT [FK_pTACalReferenceTask_pTACalReference]
GO
/****** Object:  ForeignKey [FK_pTACalReferenceTask_pTACalTemplateTask]    Script Date: 05/31/2014 23:50:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalReferenceTask_pTACalTemplateTask] FOREIGN KEY([TACalTemplateTaskId])
REFERENCES [dbo].[pTACalTemplateTask] ([TACalTemplateTaskId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalReferenceTask_pTACalTemplateTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]'))
ALTER TABLE [dbo].[pTACalReferenceTask] CHECK CONSTRAINT [FK_pTACalReferenceTask_pTACalTemplateTask]
GO

INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (0, N'Undefined')
INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (1, N'Active')
INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (2, N'Suspended')
INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (3, N'Failed')
INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (4, N'Done')
INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (100, N'In-Progress')
INSERT [dbo].[pTACalStatus] ([StatusID], [StatusName]) VALUES (400, N'Approved')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07788', GetDate())
GO