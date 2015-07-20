IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLogItem_pChangeLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLogItem]'))
ALTER TABLE [dbo].[pChangeLogItem] DROP CONSTRAINT [FK_pChangeLogItem_pChangeLog]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeLogItem_ChangeLogItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeLogItem] DROP CONSTRAINT [DF_pChangeLogItem_ChangeLogItemID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeLogItem]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeLogItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pChangeLogItem](
	[ChangeLogItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ChangeTransID] [uniqueidentifier] NULL,
	[ChangeLogID] [uniqueidentifier] NULL,
	[ChangeFieldName] [varchar](200) NULL,
	[ChangeFieldAlias] [nvarchar](400) NULL,
	[ChangeBeforeValue] [nvarchar](4000) NULL,
	[ChangeAfterValue] [nvarchar](4000) NULL,
	[ChangeBeforeText] [nvarchar](4000) NULL,
	[ChangeAfterText] [nvarchar](4000) NULL,
	[ChangeSort] [varchar](5) NULL,
        [Custom_SMat_Name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [Custom_SMat_Type] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [Custom_SMat_No] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        CONSTRAINT [PK_pChangeLogItem] PRIMARY KEY CLUSTERED 
(
	[ChangeLogItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pChangeLogItem]  WITH CHECK ADD  CONSTRAINT [FK_pChangeLogItem_pChangeLog] FOREIGN KEY([ChangeLogID])
REFERENCES [dbo].[pChangeLog] ([ChangeLogID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pChangeLogItem] CHECK CONSTRAINT [FK_pChangeLogItem_pChangeLog]
GO

ALTER TABLE [dbo].[pChangeLogItem] ADD  CONSTRAINT [DF_pChangeLogItem_ChangeLogItemID]  DEFAULT (newsequentialid()) FOR [ChangeLogItemID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '682', GetDate())
GO
