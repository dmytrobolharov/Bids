IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pFlashEditQuickFillItem_pFlashEditQuickFill]') AND parent_object_id = OBJECT_ID(N'[dbo].[pFlashEditQuickFillItem]'))
ALTER TABLE [dbo].[pFlashEditQuickFillItem] DROP CONSTRAINT [FK_pFlashEditQuickFillItem_pFlashEditQuickFill]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashEditQuickFillItem_QuickFillItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashEditQuickFillItem] DROP CONSTRAINT [DF_pFlashEditQuickFillItem_QuickFillItemID]
END

GO

/****** Object:  Table [dbo].[pFlashEditQuickFillItem]    Script Date: 03/27/2013 13:12:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pFlashEditQuickFillItem]') AND type in (N'U'))
DROP TABLE [dbo].[pFlashEditQuickFillItem]
GO

/****** Object:  Table [dbo].[pFlashEditQuickFillItem]    Script Date: 03/27/2013 13:12:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pFlashEditQuickFillItem](
	[QuickFillItemID] [uniqueidentifier] NOT NULL,
	[QuickFillID] [uniqueidentifier] NULL,
	[QuickFillFieldName] [nvarchar](200) NULL,
	[QuickFillFieldValue] [nvarchar](500) NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pFlashEditQuickFillItem] PRIMARY KEY CLUSTERED 
(
	[QuickFillItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pFlashEditQuickFillItem]  WITH CHECK ADD  CONSTRAINT [FK_pFlashEditQuickFillItem_pFlashEditQuickFill] FOREIGN KEY([QuickFillID])
REFERENCES [dbo].[pFlashEditQuickFill] ([QuickFillID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pFlashEditQuickFillItem] CHECK CONSTRAINT [FK_pFlashEditQuickFillItem_pFlashEditQuickFill]
GO

ALTER TABLE [dbo].[pFlashEditQuickFillItem] ADD  CONSTRAINT [DF_pFlashEditQuickFillItem_QuickFillItemID]  DEFAULT (newid()) FOR [QuickFillItemID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05414', GetDate())
GO
