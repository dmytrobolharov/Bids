IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowTemplateItem_ImageWorkflowTemplateItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowTemplateItem] DROP CONSTRAINT [DF_pImageWorkflowTemplateItem_ImageWorkflowTemplateItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowTemplateItem_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowTemplateItem] DROP CONSTRAINT [DF_pImageWorkflowTemplateItem_Active]
END

GO

/****** Object:  Table [dbo].[pImageWorkflowTemplateItem]    Script Date: 05/29/2012 17:44:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageWorkflowTemplateItem]') AND type in (N'U'))
DROP TABLE [dbo].[pImageWorkflowTemplateItem]
GO

/****** Object:  Table [dbo].[pImageWorkflowTemplateItem]    Script Date: 05/29/2012 17:44:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pImageWorkflowTemplateItem](
	[ImageWorkflowTemplateItemID] [uniqueidentifier] NOT NULL,
	[ImageWorkflowTemplateItemName] [nvarchar](100) NULL,
	[ImageWorkflowTemplateItemDesc] [nvarchar](400) NULL,
	[ImageWorkflowTemplateItemURL] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[Sort] [varchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pImageWorkflowTemplateItem] PRIMARY KEY CLUSTERED 
(
	[ImageWorkflowTemplateItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pImageWorkflowTemplateItem] ADD  CONSTRAINT [DF_pImageWorkflowTemplateItem_ImageWorkflowTemplateItemID]  DEFAULT (newid()) FOR [ImageWorkflowTemplateItemID]
GO

ALTER TABLE [dbo].[pImageWorkflowTemplateItem] ADD  CONSTRAINT [DF_pImageWorkflowTemplateItem_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03568', GetDate())
GO 

