
/****** Object:  Table [dbo].[sAccessGroupQuickBatchReplaceFolder]    Script Date: 06/07/2010 17:16:55 ******/

CREATE TABLE [dbo].[sAccessGroupQuickBatchReplaceFolder](
	[AccessQuickBRId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessQuickBRId]  DEFAULT (newid()),
	[QuickBRTypeId] [int] NOT NULL,
	[AccessRoleId] [int] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessRoleId]  DEFAULT ((0)),
	[AccessView] [int] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessView]  DEFAULT ((0)),
	[AccessCreate] [int] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessCreate]  DEFAULT ((0)),
	[AccessModify] [int] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessModify]  DEFAULT ((0)),
	[AccessDelete] [int] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessDelete]  DEFAULT ((0)),
	[AccessPrint] [int] NOT NULL CONSTRAINT [DF_sAccessGroupQuickBatchReplaceFolder_AccessPrint]  DEFAULT ((0)),
	[GroupId] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200)  NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200)  NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupQuickBatchReplaceFolder] PRIMARY KEY CLUSTERED 
(
	[AccessQuickBRId] ASC
)
) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '121', GetDate())
GO