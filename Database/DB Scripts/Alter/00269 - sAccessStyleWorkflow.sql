/****** Object:  Table [dbo].[sAccessStyleWorkflow]    Script Date: 08/10/2010 17:26:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'sAccessStyleWorkflow') 
CREATE TABLE [dbo].[sAccessStyleWorkflow](
	[AccessStyleWorkflowID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessStyleWorkflowID]  DEFAULT (newid()),
        [AccessStyleId] [uniqueidentifier] NOT NULL,	
        [StyleTypeId] [int] NULL,
	[AccessRoleId] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessRoleId]  DEFAULT ((0)),
	[AccessView] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessView]  DEFAULT ((0)),
	[AccessCreate] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessCreate]  DEFAULT ((0)),
	[AccessRemove] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessRemove]  DEFAULT ((0)),
	[AccessModify] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessModify]  DEFAULT ((0)),
	[AccessDelete] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessDelete]  DEFAULT ((0)),
	[AccessPrint] [int] NOT NULL CONSTRAINT [DF_sAccessStyleWorkflow_AccessPrint]  DEFAULT ((0)),
	[GroupID] [uniqueidentifier] NOT NULL,
        [WorkflowID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessStyleWorkflow] PRIMARY KEY CLUSTERED 
(
	[AccessStyleWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
