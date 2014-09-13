IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBatchQFolder]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessBatchQFolder]
GO

CREATE TABLE [dbo].[sAccessBatchQFolder](
	[AccessBatchQId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQTypeId] [uniqueidentifier] NOT NULL,
	[BatchQTypeDesc] [nvarchar](200) NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessRemove] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier]  NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_sAccessBatchQFolder] PRIMARY KEY CLUSTERED 
(
	[AccessBatchQId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT (newid()) FOR [AccessBatchQId]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessRemove]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessBatchQFolder] ADD  DEFAULT ((0)) FOR [AccessPrint]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01551'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01551', GetDate())
END	

GO


