IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessCalendarID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessCalendarID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessCalendarFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessCalendarFolder] DROP CONSTRAINT [DF_sAccessCalendarFolder_AccessPrint]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessCalendarFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessCalendarFolder]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessCalendarFolder](
	[AccessCalendarID] [uniqueidentifier] NOT NULL,
	[CalendarTypeId] [int] NULL,
	[AccessRoleId] [int] NULL,
	[AccessView] [int] NULL,
	[AccessCreate] [int] NULL,
	[AccessModify] [int] NULL,
	[AccessDelete] [int] NULL,
	[AccessPrint] [int] NULL,
	[TeamId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessCalendarFolder] PRIMARY KEY CLUSTERED 
(
	[AccessCalendarID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessCalendarID]  DEFAULT (newid()) FOR [AccessCalendarID]
GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessCalendarFolder] ADD  CONSTRAINT [DF_sAccessCalendarFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06455', GetDate())
GO
