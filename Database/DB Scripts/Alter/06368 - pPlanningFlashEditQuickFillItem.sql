IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pPlanningFlashEditQuickFillItem_pPlanningFlashEditQuickFill]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEditQuickFillItem]'))
ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItem] DROP CONSTRAINT [FK_pPlanningFlashEditQuickFillItem_pPlanningFlashEditQuickFill]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFlashEditQuickFillItem_QuickFillItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItem] DROP CONSTRAINT [DF_pPlanningFlashEditQuickFillItem_QuickFillItemID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEditQuickFillItem]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningFlashEditQuickFillItem]
GO

CREATE TABLE [dbo].[pPlanningFlashEditQuickFillItem](
	[QuickFillItemID] [uniqueidentifier] NOT NULL,
	[QuickFillID] [uniqueidentifier] NULL,
	[QuickFillFieldName] [nvarchar](200) NULL,
	[QuickFillFieldValue] [nvarchar](500) NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningFlashEditQuickFillItem] PRIMARY KEY CLUSTERED 
(
	[QuickFillItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItem]  WITH CHECK ADD  CONSTRAINT [FK_pPlanningFlashEditQuickFillItem_pPlanningFlashEditQuickFill] FOREIGN KEY([QuickFillID])
REFERENCES [dbo].[pPlanningFlashEditQuickFill] ([QuickFillID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItem] CHECK CONSTRAINT [FK_pPlanningFlashEditQuickFillItem_pPlanningFlashEditQuickFill]
GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItem] ADD  CONSTRAINT [DF_pPlanningFlashEditQuickFillItem_QuickFillItemID]  DEFAULT (newid()) FOR [QuickFillItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06368', GetDate())
GO
