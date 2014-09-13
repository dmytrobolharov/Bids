IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowTemplate_ImageWorkflowTemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowTemplate] DROP CONSTRAINT [DF_pImageWorkflowTemplate_ImageWorkflowTemplateID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowTemplate_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowTemplate] DROP CONSTRAINT [DF_pImageWorkflowTemplate_Active]
END

GO

/****** Object:  Table [dbo].[pImageWorkflowTemplate]    Script Date: 05/29/2012 17:45:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageWorkflowTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pImageWorkflowTemplate]
GO

/****** Object:  Table [dbo].[pImageWorkflowTemplate]    Script Date: 05/29/2012 17:45:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pImageWorkflowTemplate](
	[ImageWorkflowTemplateID] [uniqueidentifier] NOT NULL,
	[ImageWorkflowTemplateName] [nvarchar](100) NULL,
	[ImageWorkflowTemplateDesc] [nvarchar](400) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pImageWorkflowTemplate] PRIMARY KEY CLUSTERED 
(
	[ImageWorkflowTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pImageWorkflowTemplate] ADD  CONSTRAINT [DF_pImageWorkflowTemplate_ImageWorkflowTemplateID]  DEFAULT (newid()) FOR [ImageWorkflowTemplateID]
GO

ALTER TABLE [dbo].[pImageWorkflowTemplate] ADD  CONSTRAINT [DF_pImageWorkflowTemplate_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03566', GetDate())
GO 