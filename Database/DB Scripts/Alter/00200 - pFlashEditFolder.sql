
/****** Object:  Table [dbo].[pFlashEditFolder]    Script Date: 06/21/2010 12:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pFlashEditFolder](
	[FlashEditFolderId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pFlashEditFolder_FlashEditFolderId]  DEFAULT (newid()),
	[FlashEditFolderName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditFolderDesc] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditFolderSort] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditDefaultXML] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditSearchXML] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [int] NOT NULL CONSTRAINT [DF_pFlashEditFolder_Active]  DEFAULT ((1)),
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pFlashEditFolder] PRIMARY KEY CLUSTERED 
(
	[FlashEditFolderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '200', GetDate())
GO