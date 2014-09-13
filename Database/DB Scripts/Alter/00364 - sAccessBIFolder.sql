/****** Object:  Table [dbo].[sAccessBIFolder]    Script Date: 09/03/2010 21:40:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBIFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessBIFolder]
GO
CREATE TABLE [dbo].[sAccessBIFolder](
	[AccessBIId] [uniqueidentifier] NOT NULL,
	[BITypeId] [int] NULL,
	[BITypeDesc] [nvarchar](200) NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessRemove] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_sAccessBIFolder] PRIMARY KEY CLUSTERED 
(
	[AccessBIId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessBIId]  DEFAULT (newid()) FOR [AccessBIId]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessRemove]  DEFAULT ((0)) FOR [AccessRemove]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessBIFolder] ADD  CONSTRAINT [DF_sAccessBIFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '364', GetDate())

GO 