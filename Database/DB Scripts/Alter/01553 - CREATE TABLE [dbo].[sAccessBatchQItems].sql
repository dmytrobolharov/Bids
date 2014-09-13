IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBatchQItems]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessBatchQItems]
GO

CREATE TABLE [dbo].[sAccessBatchQItems](
	[AccessBatchQItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[AccessBatchQId] [uniqueidentifier] NOT NULL,
	[BatchQTypeId] UNIQUEIDENTIFIER NOT NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessRemove] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[BatchQueueID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessBatchQItems] PRIMARY KEY CLUSTERED 
(
	[AccessBatchQItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT (newid()) FOR [AccessBatchQItemID]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessRemove]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessBatchQItems] ADD  DEFAULT ((0)) FOR [AccessPrint]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01553'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01553', GetDate())
END	

GO

