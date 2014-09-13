IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItem_StyleSKUItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItem] DROP CONSTRAINT [DF_pStyleSKUItem_StyleSKUItemID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItem]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleSKUItem]
GO

CREATE TABLE [dbo].[pStyleSKUItem](
	[StyleSKUItemID] [uniqueidentifier] NOT NULL,
	[WorkflowItemID] [uniqueidentifier] NULL,
	[StyleSKUTemplateID] [uniqueidentifier] NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
	[ItemDim1TypeID] [uniqueidentifier] NULL,
	[ItemDim2TypeID] [uniqueidentifier] NULL,
	[ItemDim3TypeID] [uniqueidentifier] NULL,
	[PlanningID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleSKUItem] PRIMARY KEY CLUSTERED 
(
	[StyleSKUItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleSKUItem] ADD  CONSTRAINT [DF_pStyleSKUItem_StyleSKUItemID]  DEFAULT (newid()) FOR [StyleSKUItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07001', GetDate())
GO
