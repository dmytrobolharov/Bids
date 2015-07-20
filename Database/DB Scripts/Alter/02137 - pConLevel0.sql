
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pConLevel0_Level0ID]') AND type = 'D')
	BEGIN
	ALTER TABLE [dbo].[pConLevel0] DROP CONSTRAINT [DF_pConLevel0_Level0ID]
	END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pConLevel0_Active]') AND type = 'D')
	BEGIN
	ALTER TABLE [dbo].[pConLevel0] DROP CONSTRAINT [DF_pConLevel0_Active]
	END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pConLevel0]') AND type in (N'U'))
DROP TABLE [dbo].[pConLevel0]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pConLevel0](
	[Level0ID] [uniqueidentifier] NOT NULL,
	[Level0Desc] [nvarchar](100) NULL,
	[Active] [int] NOT NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pConLevel0] PRIMARY KEY CLUSTERED 
(
	[Level0ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pConLevel0] ADD  CONSTRAINT [DF_pConLevel0_Level0ID]  DEFAULT (newid()) FOR [Level0ID]
GO

ALTER TABLE [dbo].[pConLevel0] ADD  CONSTRAINT [DF_pConLevel0_Active]  DEFAULT ((1)) FOR [Active]
GO

Insert into pConLevel0 (Level0Desc, Active) values ('Category', 1)
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pConstructTree_Level0ID]') AND type = 'D')
BEGIN
ALTER TABLE pConstructTree DROP CONSTRAINT [DF_pConstructTree_Level0ID]
END

GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConstructTree' and COLUMN_NAME = N'Level0ID')
       BEGIN 
			
            ALTER TABLE pConstructTree ADD [Level0ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConstructTree_Level0ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}')
       END
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pConstructTree]') AND name = N'pConstructTree_Level0ID')
DROP INDEX [pConstructTree_Level0ID] ON [dbo].[pConstructTree] WITH ( ONLINE = OFF )
GO


CREATE NONCLUSTERED INDEX [pConstructTree_Level0ID] ON [dbo].[pConstructTree] 
(
	[Level0ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConstructTree' and COLUMN_NAME = N'Level0ID')
       BEGIN 
			
            update pConstructTree set Level0ID = (select Level0ID from pConLevel0 where Level0Desc = 'Category')
       END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02137'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02137', GetDate())
	END
GO
