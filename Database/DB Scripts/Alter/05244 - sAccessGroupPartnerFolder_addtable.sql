

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessPartnerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessPartnerID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPartnerFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPartnerFolder] DROP CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessPrint]
END

GO



/****** Object:  Table [dbo].[sAccessGroupPartnerFolder]    Script Date: 03/05/2013 17:11:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupPartnerFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupPartnerFolder]
GO


/****** Object:  Table [dbo].[sAccessGroupPartnerFolder]    Script Date: 03/05/2013 17:11:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupPartnerFolder](
	[AccessPartnerID] [uniqueidentifier] NOT NULL,
	[PartnerTypeId] [int] NOT NULL,
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
 CONSTRAINT [PK_sAccessGroupPartnerFolder] PRIMARY KEY CLUSTERED 
(
	[AccessPartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessPartnerID]  DEFAULT (newid()) FOR [AccessPartnerID]
GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupPartnerFolder] ADD  CONSTRAINT [DF_sAccessGroupPartnerFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05244', GetDate())
GO
