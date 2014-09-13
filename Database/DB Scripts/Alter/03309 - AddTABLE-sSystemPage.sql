IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemPage]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemPage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sSystemPage](
	[sSystemPageID] [uniqueidentifier] NOT NULL,
	[MappingPage] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[sSystemFolderID] [uniqueidentifier] NULL,
 CONSTRAINT [sSystemPageID_PK] PRIMARY KEY CLUSTERED 
(
	[sSystemPageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sSystemPage] ADD  CONSTRAINT [DF_sSystemPage_sSystemPageID]  DEFAULT (newid()) FOR [sSystemPageID]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03309'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03309', GetDate())
END

GO
