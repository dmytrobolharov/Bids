
/****** Object:  Table [dbo].[sAccessGroupFlashEditFolder]    Script Date: 06/19/2010 18:30:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sAccessGroupFlashEditFolder](
	[AccessFlashEditId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessFlashEditId]  DEFAULT (newid()),
	[FlashEditFolderItemId] [uniqueidentifier] NOT NULL,
	[AccessRoleId] [int] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessRoleId]  DEFAULT ((0)),
	[AccessView] [int] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessView]  DEFAULT ((0)),
	[AccessCreate] [int] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessCreate]  DEFAULT ((0)),
	[AccessModify] [int] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessModify]  DEFAULT ((0)),
	[AccessDelete] [int] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessDelete]  DEFAULT ((0)),
	[AccessPrint] [int] NOT NULL CONSTRAINT [DF_sAccessGroupFlashEditFolder_AccessPrint]  DEFAULT ((0)),
	[GroupId] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupFlashEditFolder] PRIMARY KEY CLUSTERED 
(
	[AccessFlashEditId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '203', GetDate())
GO