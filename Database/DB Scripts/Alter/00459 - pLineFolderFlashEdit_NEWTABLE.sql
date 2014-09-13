
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderFlashEdit_LineFolderFlashEditId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderFlashEdit] DROP CONSTRAINT [DF_pLineFolderFlashEdit_LineFolderFlashEditId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderFlashEdit_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderFlashEdit] DROP CONSTRAINT [DF_pLineFolderFlashEdit_Active]
END

GO



/****** Object:  Table [dbo].[pLineFolderFlashEdit]    Script Date: 09/28/2010 16:07:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderFlashEdit]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderFlashEdit]
GO



/****** Object:  Table [dbo].[pLineFolderFlashEdit]    Script Date: 09/28/2010 16:07:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pLineFolderFlashEdit](
	[LineFolderFlashEditId] [uniqueidentifier] NOT NULL,
	[LineFolderFlashEditTableName] [varchar](200) NULL,
	[LineFolderFlashEditTablePKI] [varchar](200) NULL,
	[LineFolderFlashEditFormName] [nvarchar](100) NULL,
	[LineFolderFlashEditDescription] [nvarchar](2000) NULL,
	[LineFolderFlashEditSort] [nvarchar](5) NULL,
	[LineFolderFlashEditURL] [nvarchar](200) NULL,
	[LineFolderFlashEditXML] [nvarchar](200) NULL,
	[LineFolderFlashEditSearchXML] [nvarchar](200) NULL,
	[LineFolderFlashEditBatchXML] [nvarchar](200) NULL,
	[LineFolderFlashEditBatchGridXML] [nvarchar](200) NULL,
	[LineFolderFlashEditActive] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pLineFolderFlashEdit] PRIMARY KEY CLUSTERED 
(
	[LineFolderFlashEditId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pLineFolderFlashEdit] ADD  CONSTRAINT [DF_pLineFolderFlashEdit_LineFolderFlashEditId]  DEFAULT (newsequentialid()) FOR [LineFolderFlashEditId]
GO

ALTER TABLE [dbo].[pLineFolderFlashEdit] ADD  CONSTRAINT [DF_pLineFolderFlashEdit_Active]  DEFAULT ((1)) FOR [LineFolderFlashEditActive]
GO



INSERT INTO [pLineFolderFlashEdit]
           ([LineFolderFlashEditId]
           ,[LineFolderFlashEditTableName]
           ,[LineFolderFlashEditTablePKI]
           ,[LineFolderFlashEditFormName]
           ,[LineFolderFlashEditDescription]
           ,[LineFolderFlashEditSort]
           ,[LineFolderFlashEditURL]
           ,[LineFolderFlashEditXML]
           ,[LineFolderFlashEditSearchXML]
           ,[LineFolderFlashEditBatchXML]
           ,[LineFolderFlashEditBatchGridXML]
           ,[LineFolderFlashEditActive]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate])
     VALUES
           ('a8dfa703-dbca-df11-8c09-005056c00008'
           ,'pStyleCostingHeader'
           ,'StyleID'
           ,'Costing'
           ,'Style Costing'
           ,'0001'
           ,'Line_List_FlashEdit_Search.aspx'
           ,'FlashEdit_Style_Costing_Default.xml'
           ,'FlashEdit_Style_Costing_Search.xml'
           ,'FlashEdit_Style_Costing_Batch.xml'
           ,'FlashEdit_Style_Costing_BatchGrid.xml'
           ,1
           ,NULL
           ,NULL
           ,NULL
           ,NULL)
GO

