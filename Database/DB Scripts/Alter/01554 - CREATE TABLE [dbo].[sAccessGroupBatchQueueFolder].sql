IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupBatchQueueFolder]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessGroupBatchQueueFolder]
GO


CREATE TABLE [dbo].[sAccessGroupBatchQueueFolder](
	[AccessBatchQueueId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeID] [uniqueidentifier] NOT NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[AccessRemove] [int] NOT NULL,
 CONSTRAINT [PK_sAccessGroupBatchQueueFolder] PRIMARY KEY CLUSTERED 
(
	[AccessBatchQueueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessBatchQueueId]  DEFAULT (newid()) FOR [AccessBatchQueueId]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD  CONSTRAINT [DF_sAccessGroupBatchQueueFolder_AccessRemove]  DEFAULT ((0)) FOR [AccessRemove]
GO


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01554'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01554', GetDate())
END	

GO

