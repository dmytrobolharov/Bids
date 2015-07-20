
/****** Object:  Table [dbo].[sAccessBIItems]    Script Date: 09/03/2010 21:40:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBIItems]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessBIItems]
GO
CREATE TABLE [dbo].[sAccessBIItems](
	[AccessBIItemID] [uniqueidentifier] NOT NULL,
	[AccessBIId] [uniqueidentifier] NOT NULL,
	[BITypeId] [int] NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessRemove] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[ItemID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_sAccessBIItems] PRIMARY KEY CLUSTERED 
(
	[AccessBIItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessBIItemID]  DEFAULT (newid()) FOR [AccessBIItemID]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessRemove]  DEFAULT ((0)) FOR [AccessRemove]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessBIItems] ADD  CONSTRAINT [DF_sAccessBIItems_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '365', GetDate())

GO 


