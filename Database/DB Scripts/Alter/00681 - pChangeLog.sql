IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLog_pChangeTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLog]'))
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [FK_pChangeLog_pChangeTable]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLog_pChangeTransaction]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLog]'))
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [FK_pChangeLog_pChangeTransaction]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeLog_ChangeLogID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [DF_pChangeLog_ChangeLogID]
END

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLogItem_pChangeLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLogItem]'))
ALTER TABLE [dbo].[pChangeLogItem] DROP CONSTRAINT [FK_pChangeLogItem_pChangeLog]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeLog]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeLog]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pChangeLog](
	[ChangeLogID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ChangeTransID] [uniqueidentifier] NULL,
	[ChangeTableID] [uniqueidentifier] NULL,
	[ChangeTablePKID] [varchar](40) NULL,
	[ChangeUserID] [uniqueidentifier] NULL,
	[ChangeUserName] [nvarchar](200) NULL,
	[ChangeDate] [datetime] NULL,
	[ChangeSort] [varchar](5) NULL,
 CONSTRAINT [PK_pChangeLog] PRIMARY KEY CLUSTERED 
(
	[ChangeLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pChangeLog]  WITH CHECK ADD  CONSTRAINT [FK_pChangeLog_pChangeTable] FOREIGN KEY([ChangeTableID])
REFERENCES [dbo].[pChangeTable] ([ChangeTableID])
GO

ALTER TABLE [dbo].[pChangeLog] CHECK CONSTRAINT [FK_pChangeLog_pChangeTable]
GO

ALTER TABLE [dbo].[pChangeLog]  WITH NOCHECK ADD  CONSTRAINT [FK_pChangeLog_pChangeTransaction] FOREIGN KEY([ChangeTransID])
REFERENCES [dbo].[pChangeTransaction] ([ChangeTransID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pChangeLog] CHECK CONSTRAINT [FK_pChangeLog_pChangeTransaction]
GO

ALTER TABLE [dbo].[pChangeLog] ADD  CONSTRAINT [DF_pChangeLog_ChangeLogID]  DEFAULT (newsequentialid()) FOR [ChangeLogID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '679', GetDate())
GO
