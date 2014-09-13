

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLog_pChangeTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLog]'))
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [FK_pChangeLog_pChangeTable]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLog_pChangeTransaction]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLog]'))
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [FK_pChangeLog_pChangeTransaction]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeLog_ChangeLogID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [DF_pChangeLog_ChangeLogID]
END

GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLogItem_pChangeLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLogItem]'))
ALTER TABLE [dbo].[pChangeLogItem] DROP CONSTRAINT [FK_pChangeLogItem_pChangeLog]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeLogItem_ChangeLogItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeLogItem] DROP CONSTRAINT [DF_pChangeLogItem_ChangeLogItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeTable_ChangeTableID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeTable] DROP CONSTRAINT [DF_pChangeTable_ChangeTableID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeTransaction_ChangeTransID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeTransaction] DROP CONSTRAINT [DF_pChangeTransaction_ChangeTransID]
END

GO


/****** Object:  Table [dbo].[pChangeLog]    Script Date: 10/13/2010 09:42:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeLog]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeLog]
GO

/****** Object:  Table [dbo].[pChangeLogItem]    Script Date: 10/13/2010 09:42:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeLogItem]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeLogItem]
GO

/****** Object:  Table [dbo].[pChangeTable]    Script Date: 10/13/2010 09:42:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeTable]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeTable]
GO

/****** Object:  Table [dbo].[pChangeTransaction]    Script Date: 10/13/2010 09:42:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeTransaction]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeTransaction]
GO



/****** Object:  Table [dbo].[pChangeLog]    Script Date: 10/13/2010 09:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pChangeLog](
	[ChangeLogID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ChangeTransID] [uniqueidentifier] NULL,
	[ChangeTableID] [uniqueidentifier] NULL,
	[ChangeTablePKID] [varchar](40) NULL,
	[ChangeUserID] [uniqueidentifier] NULL,
	[ChangeUserName] [nvarchar](200) NULL,
	[ChangeDate] [datetime] NULL,
	[ChangeSort] [varchar](5) NULL,
 CONSTRAINT [PK_pChangeLog] PRIMARY KEY CLUSTERED 
(
	[ChangeLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[pChangeLogItem]    Script Date: 10/13/2010 09:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pChangeLogItem](
	[ChangeLogItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ChangeTransID] [uniqueidentifier] NULL,
	[ChangeLogID] [uniqueidentifier] NULL,
	[ChangeFieldName] [varchar](200) NULL,
	[ChangeFieldAlias] [nvarchar](400) NULL,
	[ChangeBeforeValue] [nvarchar](4000) NULL,
	[ChangeAfterValue] [nvarchar](4000) NULL,
	[ChangeBeforeText] [nvarchar](4000) NULL,
	[ChangeAfterText] [nvarchar](4000) NULL,
	[ChangeSort] [varchar](5) NULL,
 CONSTRAINT [PK_pChangeLogItem] PRIMARY KEY CLUSTERED 
(
	[ChangeLogItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[pChangeTable]    Script Date: 10/13/2010 09:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pChangeTable](
	[ChangeTableID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ChangeTableName] [varchar](200) NULL,
	[ChangeTableFieldName] [varchar](200) NULL,
	[ChangeTablePKName] [varchar](200) NULL,
	[ChangeTableXML] [varchar](200) NULL,
 CONSTRAINT [PK_pChangeTable] PRIMARY KEY CLUSTERED 
(
	[ChangeTableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[pChangeTransaction]    Script Date: 10/13/2010 09:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pChangeTransaction](
	[ChangeTransID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ChangeTransPageName] [varchar](200) NULL,
	[ChangeTransTableID] [uniqueidentifier] NULL,
	[ChangeTransTablePKID] [varchar](40) NULL,
	[ChangeTransUserID] [uniqueidentifier] NULL,
	[ChangeTransDate] [datetime] NULL,
 CONSTRAINT [PK_pChangeTransaction] PRIMARY KEY CLUSTERED 
(
	[ChangeTransID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pChangeLog]  WITH CHECK ADD  CONSTRAINT [FK_pChangeLog_pChangeTable] FOREIGN KEY([ChangeTableID])
REFERENCES [dbo].[pChangeTable] ([ChangeTableID])
GO

ALTER TABLE [dbo].[pChangeLog] CHECK CONSTRAINT [FK_pChangeLog_pChangeTable]
GO

ALTER TABLE [dbo].[pChangeLog]  WITH NOCHECK ADD  CONSTRAINT [FK_pChangeLog_pChangeTransaction] FOREIGN KEY([ChangeTransID])
REFERENCES [dbo].[pChangeTransaction] ([ChangeTransID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pChangeLog] CHECK CONSTRAINT [FK_pChangeLog_pChangeTransaction]
GO

ALTER TABLE [dbo].[pChangeLog] ADD  CONSTRAINT [DF_pChangeLog_ChangeLogID]  DEFAULT (newsequentialid()) FOR [ChangeLogID]
GO

ALTER TABLE [dbo].[pChangeLogItem]  WITH CHECK ADD  CONSTRAINT [FK_pChangeLogItem_pChangeLog] FOREIGN KEY([ChangeLogID])
REFERENCES [dbo].[pChangeLog] ([ChangeLogID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pChangeLogItem] CHECK CONSTRAINT [FK_pChangeLogItem_pChangeLog]
GO

ALTER TABLE [dbo].[pChangeLogItem] ADD  CONSTRAINT [DF_pChangeLogItem_ChangeLogItemID]  DEFAULT (newsequentialid()) FOR [ChangeLogItemID]
GO

ALTER TABLE [dbo].[pChangeTable] ADD  CONSTRAINT [DF_pChangeTable_ChangeTableID]  DEFAULT (newsequentialid()) FOR [ChangeTableID]
GO

ALTER TABLE [dbo].[pChangeTransaction] ADD  CONSTRAINT [DF_pChangeTransaction_ChangeTransID]  DEFAULT (newsequentialid()) FOR [ChangeTransID]
GO


