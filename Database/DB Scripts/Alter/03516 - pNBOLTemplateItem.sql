IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLTemplateItem_TemplateItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLTemplateItem] DROP CONSTRAINT [DF_pNBOLTemplateItem_TemplateItemID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLTemplateItem]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLTemplateItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLTemplateItem](
	[TemplateItemID] [uniqueidentifier] NOT NULL,
	[TemplateID] [uniqueidentifier] NULL,
	[MacroID] [uniqueidentifier] NULL,
	[OperationID] [uniqueidentifier] NULL,
	[ImageID] [uniqueidentifier] NULL,
	[Code] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[MachineID] [uniqueidentifier] NULL,
	[OperationTypeID] [nvarchar](200) NULL,
	[BaseRate] [decimal](18, 2) NULL,
	[SAM] [decimal](18, 2) NULL,
	[ParentID] [uniqueidentifier] NULL,
	[Sort] [nvarchar](5) NULL,
	[Sort2] [nvarchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pNBOLTemplateItem] PRIMARY KEY CLUSTERED 
(
	[TemplateItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLTemplateItem] ADD  CONSTRAINT [DF_pNBOLTemplateItem_TemplateItemID]  DEFAULT (newid()) FOR [TemplateItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03516', GetDate())
GO