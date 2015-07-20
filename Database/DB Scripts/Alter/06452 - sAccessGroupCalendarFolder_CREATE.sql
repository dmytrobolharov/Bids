IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessCalendarID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessCalendarID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupCalendarFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupCalendarFolder] DROP CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessGroupCalendarFolder]    Script Date: 08/19/2013 11:55:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupCalendarFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupCalendarFolder]
GO

/****** Object:  Table [dbo].[sAccessGroupCalendarFolder]    Script Date: 08/19/2013 11:55:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupCalendarFolder](
	[AccessCalendarID] [uniqueidentifier] NOT NULL,
	[CalendarTypeId] [int] NOT NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupCalendarFolder] PRIMARY KEY CLUSTERED 
(
	[AccessCalendarID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessCalendarID]  DEFAULT (newid()) FOR [AccessCalendarID]
GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupCalendarFolder] ADD  CONSTRAINT [DF_sAccessGroupCalendarFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06452', GetDate())
GO
