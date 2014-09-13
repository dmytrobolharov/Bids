IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialTemplatePage_MaterialTemplatePageID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialTemplatePage] DROP CONSTRAINT [DF_pMaterialTemplatePage_MaterialTemplatePageID]
END

GO

/****** Object:  Table [dbo].[pMaterialTemplatePage]    Script Date: 04/17/2012 16:22:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTemplatePage]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialTemplatePage]
GO

/****** Object:  Table [dbo].[pMaterialTemplatePage]    Script Date: 04/17/2012 16:22:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMaterialTemplatePage](
	[MaterialTemplatePageID] [uniqueidentifier] NOT NULL,
	[MaterialTemplatePageName] [nvarchar](100) NULL,
	[MaterialTemplatePageDesc] [nvarchar](400) NULL,
	[MaterialTemplatePageURL] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[Sort] [varchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMaterialTemplatePage] PRIMARY KEY CLUSTERED 
(
	[MaterialTemplatePageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pMaterialTemplatePage] ADD  CONSTRAINT [DF_pMaterialTemplatePage_MaterialTemplatePageID]  DEFAULT (newid()) FOR [MaterialTemplatePageID]
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03368', GetDate())

GO