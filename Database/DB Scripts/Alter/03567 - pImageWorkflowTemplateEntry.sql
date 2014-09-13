IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowTemplateEntry_ImageWorkflowTemplateEntryID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowTemplateEntry] DROP CONSTRAINT [DF_pImageWorkflowTemplateEntry_ImageWorkflowTemplateEntryID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowTemplateEntry_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowTemplateEntry] DROP CONSTRAINT [DF_pImageWorkflowTemplateEntry_Active]
END

GO

/****** Object:  Table [dbo].[pImageWorkflowTemplateEntry]    Script Date: 05/29/2012 17:45:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageWorkflowTemplateEntry]') AND type in (N'U'))
DROP TABLE [dbo].[pImageWorkflowTemplateEntry]
GO

/****** Object:  Table [dbo].[pImageWorkflowTemplateEntry]    Script Date: 05/29/2012 17:45:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pImageWorkflowTemplateEntry](
	[ImageWorkflowTemplateEntryID] [uniqueidentifier] NOT NULL,
	[ImageWorkflowTemplateID] [uniqueidentifier] NOT NULL,
	[ImageWorkflowTemplateItemID] [uniqueidentifier] NOT NULL,
	[Sort] [varchar](4) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pImageWorkflowTemplateEntry] PRIMARY KEY CLUSTERED 
(
	[ImageWorkflowTemplateEntryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pImageWorkflowTemplateEntry] ADD  CONSTRAINT [DF_pImageWorkflowTemplateEntry_ImageWorkflowTemplateEntryID]  DEFAULT (newid()) FOR [ImageWorkflowTemplateEntryID]
GO

ALTER TABLE [dbo].[pImageWorkflowTemplateEntry] ADD  CONSTRAINT [DF_pImageWorkflowTemplateEntry_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03567', GetDate())
GO 