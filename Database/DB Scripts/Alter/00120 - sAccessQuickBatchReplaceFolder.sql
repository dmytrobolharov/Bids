
/****** Object:  Table [dbo].[sAccessQuickBatchReplaceFolder]    Script Date: 06/07/2010 17:17:30 ******/

CREATE TABLE [dbo].[sAccessQuickBatchReplaceFolder](
	[AccessQuickBRId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessQuickBRId]  DEFAULT (newid()),
	[QuickBRTypeId] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_QuickBRTypeId]  DEFAULT ((0)),
	[AccessRoleId] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessRoleId]  DEFAULT ((0)),
	[AccessView] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessView]  DEFAULT ((0)),
	[AccessCreate] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessCreate]  DEFAULT ((0)),
	[AccessModify] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessModify]  DEFAULT ((0)),
	[AccessDelete] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessDelete]  DEFAULT ((0)),
	[AccessPrint] [int] NOT NULL CONSTRAINT [DF_sAccessQuickBatchReplaceFolder_AccessPrint]  DEFAULT ((0)),
	[TeamId] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessQuickBatchReplace] PRIMARY KEY CLUSTERED 
(
	[AccessQuickBRId] ASC
)
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '120', GetDate())
GO