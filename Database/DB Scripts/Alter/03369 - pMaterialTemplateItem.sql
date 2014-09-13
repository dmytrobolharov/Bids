IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pMaterialTemplateItem_pMaterialTemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pMaterialTemplateItem]'))
ALTER TABLE [dbo].[pMaterialTemplateItem] DROP CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplate]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pMaterialTemplateItem_pMaterialTemplatePage]') AND parent_object_id = OBJECT_ID(N'[dbo].[pMaterialTemplateItem]'))
ALTER TABLE [dbo].[pMaterialTemplateItem] DROP CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplatePage]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialTemplateItem_MaterialTemplateItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialTemplateItem] DROP CONSTRAINT [DF_pMaterialTemplateItem_MaterialTemplateItemID]
END

GO

/****** Object:  Table [dbo].[pMaterialTemplateItem]    Script Date: 04/17/2012 16:22:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTemplateItem]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialTemplateItem]
GO

/****** Object:  Table [dbo].[pMaterialTemplateItem]    Script Date: 04/17/2012 16:22:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMaterialTemplateItem](
	[MaterialTemplateItemID] [uniqueidentifier] NOT NULL,
	[MaterialTemplateID] [uniqueidentifier] NULL,
	[MaterialTemplatePageID] [uniqueidentifier] NULL,
	[Active] [int] NULL,
	[Sort] [varchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMaterialTemplateItem] PRIMARY KEY CLUSTERED 
(
	[MaterialTemplateItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pMaterialTemplateItem]  WITH CHECK ADD  CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplate] FOREIGN KEY([MaterialTemplateID])
REFERENCES [dbo].[pMaterialTemplate] ([MaterialTemplateID])
GO

ALTER TABLE [dbo].[pMaterialTemplateItem] CHECK CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplate]
GO

ALTER TABLE [dbo].[pMaterialTemplateItem]  WITH CHECK ADD  CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplatePage] FOREIGN KEY([MaterialTemplatePageID])
REFERENCES [dbo].[pMaterialTemplatePage] ([MaterialTemplatePageID])
GO

ALTER TABLE [dbo].[pMaterialTemplateItem] CHECK CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplatePage]
GO

ALTER TABLE [dbo].[pMaterialTemplateItem] ADD  CONSTRAINT [DF_pMaterialTemplateItem_MaterialTemplateItemID]  DEFAULT (newid()) FOR [MaterialTemplateItemID]
GO




	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03369', GetDate())

GO