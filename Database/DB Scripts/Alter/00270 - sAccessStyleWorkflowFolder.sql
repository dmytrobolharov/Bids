/****** Object:  Table [dbo].[sAccessStyleWorkflowFolder]    Script Date: 08/12/2010 12:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'sAccessStyleWorkflowFolder') 
CREATE TABLE [dbo].[sAccessStyleWorkflowFolder](
    [AccessStyleWorkflowID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessStyleWorkflowID]  DEFAULT (newid()),
	[AccessStyleId] [uniqueidentifier] NOT NULL,
	[StyleTypeId] [int] NULL,
	[AccessRoleId] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessRoleId]  DEFAULT ((0)),
	[AccessView] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessView]  DEFAULT ((0)),
	[AccessCreate] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessCreate]  DEFAULT ((0)),
	[AccessModify] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessModify]  DEFAULT ((0)),
	[AccessRemove] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessRemove]  DEFAULT ((0)),
	[AccessDelete] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessDelete]  DEFAULT ((0)),
	[AccessPrint] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflowFolder_AccessPrint]  DEFAULT ((0)),
        [WorkflowID] [uniqueidentifier] NOT NULL,
	[TeamId] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessStyleWorkflowFolder] PRIMARY KEY CLUSTERED 
(
	[AccessStyleWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



  