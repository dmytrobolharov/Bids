
/****** Object:  Table [dbo].[pFlashEditFolderItem]    Script Date: 06/19/2010 18:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pFlashEditFolderItem](
	[FlashEditFolderItemId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pFlashEditFolderItem_FlashEditFolderItemId]  DEFAULT (newid()),
	[FlashEditFolderId] [uniqueidentifier] NOT NULL,
	[FlashEditFormName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemDescription] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemSort] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemURL] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemXML] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemSearchXML] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlashEditItemBatchXML] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [int] NOT NULL CONSTRAINT [DF_pFlashEditFolderItem_Active]  DEFAULT ((1)),
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pFlashEditFolderItem] PRIMARY KEY CLUSTERED 
(
	[FlashEditFolderItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '201', GetDate())
GO