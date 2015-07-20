IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialTemplate_MaterialTemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialTemplate] DROP CONSTRAINT [DF_pMaterialTemplate_MaterialTemplateID]
END

GO

/****** Object:  Table [dbo].[pMaterialTemplate]    Script Date: 04/17/2012 16:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialTemplate]
GO

/****** Object:  Table [dbo].[pMaterialTemplate]    Script Date: 04/17/2012 16:21:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pMaterialTemplate](
	[MaterialTemplateID] [uniqueidentifier] NOT NULL,
	[MaterialTemplateName] [nvarchar](100) NULL,
	[MaterialTemplateDesc] [nvarchar](400) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMaterialTemplate] PRIMARY KEY CLUSTERED 
(
	[MaterialTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMaterialTemplate] ADD  CONSTRAINT [DF_pMaterialTemplate_MaterialTemplateID]  DEFAULT (newid()) FOR [MaterialTemplateID]
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03367', GetDate())

GO