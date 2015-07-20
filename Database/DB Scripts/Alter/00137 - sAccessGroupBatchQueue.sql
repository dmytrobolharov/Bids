/****** Object:  Table [dbo].[sAccessGroupBatchQueue]    Script Date: 06/08/2010 10:42:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupBatchQueue](
	[AccessBatchQueueId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessBatchQueueId]  DEFAULT (newid()),
	[BatchQueueTypeID] [uniqueidentifier] NOT NULL,
	[AccessRoleId] [int] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessRoleId]  DEFAULT ((0)),
	[AccessView] [int] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessView]  DEFAULT ((0)),
	[AccessCreate] [int] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessCreate]  DEFAULT ((0)),
	[AccessModify] [int] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessModify]  DEFAULT ((0)),
	[AccessDelete] [int] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessDelete]  DEFAULT ((0)),
	[AccessPrint] [int] NOT NULL CONSTRAINT [DF_sAccessGroupBatchQueue_AccessPrint]  DEFAULT ((0)),
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupBatchQueue] PRIMARY KEY CLUSTERED 
(
	[AccessBatchQueueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '137', GetDate())
GO
