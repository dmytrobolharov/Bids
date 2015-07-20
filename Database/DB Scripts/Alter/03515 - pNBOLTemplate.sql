IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLTemplate_TemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLTemplate] DROP CONSTRAINT [DF_pNBOLTemplate_TemplateID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLTemplate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLTemplate](
	[TemplateID] [uniqueidentifier] NOT NULL,
	[TemplateCode] [nvarchar](200) NULL,
	[TemplateName] [nvarchar](200) NULL,
	[ImageID] [uniqueidentifier] NULL,
	[Comments] [nvarchar](500) NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,	
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pNBOLTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLTemplate] ADD  CONSTRAINT [DF_pNBOLTemplate_TemplateID]  DEFAULT (newid()) FOR [TemplateID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03515', GetDate())
GO