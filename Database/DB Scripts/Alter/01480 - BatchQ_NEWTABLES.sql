

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueue_BatchQID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueue] DROP CONSTRAINT [DF_pBatchQueue_BatchQID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueueJob_BatchQueueJobID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueueJob] DROP CONSTRAINT [DF_pBatchQueueJob_BatchQueueJobID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueueJob_BatchQueueJobCompleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueueJob] DROP CONSTRAINT [DF_pBatchQueueJob_BatchQueueJobCompleted]
END

GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItem_pBatchQueueJob_BatchQueueJobID]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItem]'))
ALTER TABLE [dbo].[pBatchQueueJobItem] DROP CONSTRAINT [FK_pBatchQueueJobItem_pBatchQueueJob_BatchQueueJobID]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueueJobItem_BatchQueueJobItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueueJobItem] DROP CONSTRAINT [DF_pBatchQueueJobItem_BatchQueueJobItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueueJobItem_BatchQueueJobStatusID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueueJobItem] DROP CONSTRAINT [DF_pBatchQueueJobItem_BatchQueueJobStatusID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueuePage_BatchQueuePageID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueuePage] DROP CONSTRAINT [DF_pBatchQueuePage_BatchQueuePageID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueuePageDep_BatchQueuePageDepID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueuePageDep] DROP CONSTRAINT [DF_pBatchQueuePageDep_BatchQueuePageDepID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueuePageType_BatchQueuePageTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueuePageType] DROP CONSTRAINT [DF_pBatchQueuePageType_BatchQueuePageTypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueueType_BatchQueueTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueueType] DROP CONSTRAINT [DF_pBatchQueueType_BatchQueueTypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBatchQueueType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBatchQueueType] DROP CONSTRAINT [DF_pBatchQueueType_Active]
END

GO



/****** Object:  Table [dbo].[pBatchQueue]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueue]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueue]
GO

/****** Object:  Table [dbo].[pBatchQueueJob]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJob]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueueJob]
GO

/****** Object:  Table [dbo].[pBatchQueueJobItem]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItem]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueueJobItem]
GO

/****** Object:  Table [dbo].[pBatchQueuePage]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePage]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueuePage]
GO

/****** Object:  Table [dbo].[pBatchQueuePageDep]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePageDep]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueuePageDep]
GO

/****** Object:  Table [dbo].[pBatchQueuePageType]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePageType]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueuePageType]
GO

/****** Object:  Table [dbo].[pBatchQueueType]    Script Date: 05/31/2011 10:44:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueType]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueueType]
GO


/****** Object:  Table [dbo].[pBatchQueue]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pBatchQueue](
	[BatchQueueID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeID] [uniqueidentifier] NULL,
	[BatchQueueName] [nvarchar](200) NULL,
	[BatchQueueDesc] [varchar](4000) NULL,
	[BatchQueueUrl] [varchar](200) NULL,
	[BatchQueueIcon] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pBatchQueue] PRIMARY KEY CLUSTERED 
(
	[BatchQueueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[pBatchQueueJob]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pBatchQueueJob](
	[BatchQueueJobID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueID] [uniqueidentifier] NULL,
	[BatchQueueJobDate] [datetime] NULL,
	[BatchQueueJobTeamID] [uniqueidentifier] NULL,
	[BatchQueueJobStatusID] [uniqueidentifier] NULL,
	[BatchQueueJobCompleted] [int] NULL,
 CONSTRAINT [PK_pBatchQueueJob] PRIMARY KEY CLUSTERED 
(
	[BatchQueueJobID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[pBatchQueueJobItem]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pBatchQueueJobItem](
	[BatchQueueJobItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[BatchQueuePageID] [uniqueidentifier] NULL,
	[BatchQueueJobStatusID] [int] NULL,
	[BatchQueueJobCount] [int] NULL,
	[BatchQueueJobSeq] [varchar](5) NULL,
	[BatchQueueJobTable] [varchar](200) NULL,
 CONSTRAINT [PK_pBatchQueueJobItem] PRIMARY KEY CLUSTERED 
(
	[BatchQueueJobItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[pBatchQueuePage]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pBatchQueuePage](
	[BatchQueuePageID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageTypeID] [uniqueidentifier] NOT NULL,
	[BatchQueueID] [uniqueidentifier] NOT NULL,
	[BatchQueuePageOrder] [varchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pBatchQueuePage] PRIMARY KEY CLUSTERED 
(
	[BatchQueuePageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[pBatchQueuePageDep]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pBatchQueuePageDep](
	[BatchQueuePageDepID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageID] [uniqueidentifier] NULL,
	[BatchQueuePageRelationID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBatchQueuePageDep] PRIMARY KEY CLUSTERED 
(
	[BatchQueuePageDepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[pBatchQueuePageType]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pBatchQueuePageType](
	[BatchQueuePageTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageTypeName] [nvarchar](200) NULL,
	[BatchQueuePageTypeDesc] [nvarchar](4000) NULL,
	[BatchQueuePagePkID] [varchar](100) NULL,
	[BatchQueuePageXmlSearch] [varchar](200) NULL,
	[BatchQueuePageXmlForm] [varchar](200) NULL,
	[BatchQueuePageXmlGrid] [varchar](200) NULL,
	[BatchQueuePageXmlSelected] [varchar](200) NULL,
	[BatchQueuePageUrl] [varchar](400) NULL,
	[BatchQueuePageRecType] [varchar](10) NULL,
	[BatchQueuePageRecMax] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pBatchQueuePageType] PRIMARY KEY CLUSTERED 
(
	[BatchQueuePageTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[pBatchQueueType]    Script Date: 05/31/2011 10:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pBatchQueueType](
	[BatchQueueTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeName] [nvarchar](100) NULL,
	[BatchQueueTypeDesc] [nvarchar](4000) NULL,
	[BatchQueueTypeURL] [varchar](200) NULL,
	[BatchQueueTypeIcon] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBatchQueueType] PRIMARY KEY CLUSTERED 
(
	[BatchQueueTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pBatchQueue] ADD  CONSTRAINT [DF_pBatchQueue_BatchQID]  DEFAULT (newsequentialid()) FOR [BatchQueueID]
GO

ALTER TABLE [dbo].[pBatchQueueJob] ADD  CONSTRAINT [DF_pBatchQueueJob_BatchQueueJobID]  DEFAULT (newsequentialid()) FOR [BatchQueueJobID]
GO

ALTER TABLE [dbo].[pBatchQueueJob] ADD  CONSTRAINT [DF_pBatchQueueJob_BatchQueueJobCompleted]  DEFAULT ((0)) FOR [BatchQueueJobCompleted]
GO

ALTER TABLE [dbo].[pBatchQueueJobItem]  WITH CHECK ADD  CONSTRAINT [FK_pBatchQueueJobItem_pBatchQueueJob_BatchQueueJobID] FOREIGN KEY([BatchQueueJobID])
REFERENCES [dbo].[pBatchQueueJob] ([BatchQueueJobID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] CHECK CONSTRAINT [FK_pBatchQueueJobItem_pBatchQueueJob_BatchQueueJobID]
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] ADD  CONSTRAINT [DF_pBatchQueueJobItem_BatchQueueJobItemID]  DEFAULT (newsequentialid()) FOR [BatchQueueJobItemID]
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] ADD  CONSTRAINT [DF_pBatchQueueJobItem_BatchQueueJobStatusID]  DEFAULT ((0)) FOR [BatchQueueJobStatusID]
GO

ALTER TABLE [dbo].[pBatchQueuePage] ADD  CONSTRAINT [DF_pBatchQueuePage_BatchQueuePageID]  DEFAULT (newsequentialid()) FOR [BatchQueuePageID]
GO

ALTER TABLE [dbo].[pBatchQueuePageDep] ADD  CONSTRAINT [DF_pBatchQueuePageDep_BatchQueuePageDepID]  DEFAULT (newsequentialid()) FOR [BatchQueuePageDepID]
GO

ALTER TABLE [dbo].[pBatchQueuePageType] ADD  CONSTRAINT [DF_pBatchQueuePageType_BatchQueuePageTypeID]  DEFAULT (newsequentialid()) FOR [BatchQueuePageTypeID]
GO

ALTER TABLE [dbo].[pBatchQueueType] ADD  CONSTRAINT [DF_pBatchQueueType_BatchQueueTypeID]  DEFAULT (newsequentialid()) FOR [BatchQueueTypeID]
GO

ALTER TABLE [dbo].[pBatchQueueType] ADD  CONSTRAINT [DF_pBatchQueueType_Active]  DEFAULT ((1)) FOR [Active]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01480', GetDate())
GO

