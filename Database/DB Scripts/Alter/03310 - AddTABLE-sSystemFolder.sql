IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemFolder]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sSystemFolder](
	[sSystemFolderID] [uniqueidentifier] NOT NULL,
	[sSystemFolder] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](50) NULL,
 CONSTRAINT [PK_sSystemFolder] PRIMARY KEY CLUSTERED 
(
	[sSystemFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sSystemFolder] ADD  CONSTRAINT [DF_sSystemFolder_sSystemFolderID]  DEFAULT (newid()) FOR [sSystemFolderID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03310'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03310', GetDate())
END

GO