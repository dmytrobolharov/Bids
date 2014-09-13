

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashEditFolderItem_FlashEditFolderItemId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashEditFolderItem] DROP CONSTRAINT [DF_pFlashEditFolderItem_FlashEditFolderItemId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashEditFolderItem_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashEditFolderItem] DROP CONSTRAINT [DF_pFlashEditFolderItem_Active]
END

GO



/****** Object:  Table [dbo].[pFlashEditFolderItem]    Script Date: 09/28/2010 01:30:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pFlashEditFolderItem]') AND type in (N'U'))
DROP TABLE [dbo].[pFlashEditFolderItem]
GO



/****** Object:  Table [dbo].[pFlashEditFolderItem]    Script Date: 09/28/2010 01:30:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pFlashEditFolderItem](
	[FlashEditFolderItemId] [uniqueidentifier] NOT NULL,
	[FlashEditFolderId] [uniqueidentifier] NOT NULL,
	[FlashEditFormName] [nvarchar](100) NULL,
	[FlashEditItemName] [nvarchar](100) NULL,
	[FlashEditItemDescription] [nvarchar](2000) NULL,
	[FlashEditTableName] [varchar](200) NULL,
	[FlashEditTablePKI] [varchar](200) NULL,	
	[FlashEditItemSort] [nvarchar](5) NULL,
	[FlashEditItemURL] [nvarchar](200) NULL,
	[FlashEditItemXML] [nvarchar](200) NULL,
	[FlashEditItemSearchXML] [nvarchar](200) NULL,
	[FlashEditItemBatchXML] [nvarchar](200) NULL,
	[FlashEditItemBatchGridXML] [nvarchar](200) NULL,	
	[Active] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pFlashEditFolderItem] PRIMARY KEY CLUSTERED 
(
	[FlashEditFolderItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pFlashEditFolderItem] ADD  CONSTRAINT [DF_pFlashEditFolderItem_FlashEditFolderItemId]  DEFAULT (newsequentialid()) FOR [FlashEditFolderItemId]
GO

ALTER TABLE [dbo].[pFlashEditFolderItem] ADD  CONSTRAINT [DF_pFlashEditFolderItem_Active]  DEFAULT ((1)) FOR [Active]
GO



INSERT INTO [pFlashEditFolderItem]
           ([FlashEditFolderItemId]
           ,[FlashEditFolderId]
           ,[FlashEditFormName]
           ,[FlashEditItemName]
           ,[FlashEditItemDescription]
           ,[FlashEditItemSort]
           ,[FlashEditItemURL]
           ,[FlashEditItemXML]
           ,[FlashEditItemSearchXML]
           ,[FlashEditItemBatchXML]
           ,[Active]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate]
           ,[FlashEditTableName]
           ,[FlashEditTablePKI]
           ,[FlashEditItemBatchGridXML]
           )
			VALUES
			(
			'8fd5c4c1-6ec1-4a38-9413-e41235904d46',	
			'985b2f44-ef92-4d27-a606-91b90c579495',
			'Style',	
			'Costing',	
			'Pre costing Edit',	
			'00001',	
			'FlashEdit_Search.aspx',	
			'FlashEdit_Style_Cost_Default.xml',	
			'FlashEdit_Style_Cost_Search.xml',
			'FlashEdit_Style_Cost_Batch.xml',	
			'1',	
			NULL,	
			NULL,	
			NULL,	
			NULL,	
			'pStyleQuoteItem',	
			'StyleQuoteItemID',	
			'FlashEdit_Style_Cost_BatchGrid.xml'
			)
GO


INSERT INTO [pFlashEditFolderItem]
           ([FlashEditFolderItemId]
           ,[FlashEditFolderId]
           ,[FlashEditFormName]
           ,[FlashEditItemName]
           ,[FlashEditItemDescription]
           ,[FlashEditItemSort]
           ,[FlashEditItemURL]
           ,[FlashEditItemXML]
           ,[FlashEditItemSearchXML]
           ,[FlashEditItemBatchXML]
           ,[Active]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate]
           ,[FlashEditTableName]
           ,[FlashEditTablePKI]
           ,[FlashEditItemBatchGridXML]
           )
			VALUES
			(
			'c5df7a0b-d6c9-43b6-84ef-cfabd647d450',	
			'2414640b-d8aa-4f52-b4bf-d9f4446d50da',
			'Material',	
			'Material Color',	
			'Material Color Edit',	
			'00003',	
			'FlashEdit_Search.aspx',	
			'FlashEdit_Material_Color_Default.xml',	
			'FlashEdit_Material_Color_Search.xml',
			'FlashEdit_Material_Color_Batch.xml',	
			'1',	
			NULL,	
			NULL,	
			NULL,	
			NULL,	
			'pMaterialColor',	
			'MaterialColorID',	
			'FlashEdit_Material_Color_BatchGrid.xml'
			)
GO
