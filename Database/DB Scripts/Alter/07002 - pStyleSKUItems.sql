IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_StyleSKUItemsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_StyleSKUItemsID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery1WSUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery1WSUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery2WSUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery2WSUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery3WSUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery3WSUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery1RUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery1RUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery2RUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery2RUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery3RUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery3RUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery1EUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery1EUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery2EUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery2EUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_Delivery3EUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_Delivery3EUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_TotalWSUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_TotalWSUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_TotalRUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_TotalRUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_TotalEUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_TotalEUnits]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUItems_TotalUnits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUItems] DROP CONSTRAINT [DF_pStyleSKUItems_TotalUnits]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItems]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleSKUItems]
GO

CREATE TABLE [dbo].[pStyleSKUItems](
	[StyleSKUItemsID] [uniqueidentifier] NOT NULL,
	[StyleSKUItemID] [uniqueidentifier] NULL,
	[ItemDim1ID] [uniqueidentifier] NULL,
	[ItemDim2ID] [uniqueidentifier] NULL,
	[ItemDim3ID] [uniqueidentifier] NULL,
	[Delivery1StatusID] [int] NULL,
	[Delivery2StatusID] [int] NULL,
	[Delivery3StatusID] [int] NULL,
	[Delivery1WSUnits] [int] NULL,
	[Delivery2WSUnits] [int] NULL,
	[Delivery3WSUnits] [int] NULL,
	[Delivery1RUnits] [int] NULL,
	[Delivery2RUnits] [int] NULL,
	[Delivery3RUnits] [int] NULL,
	[Delivery1EUnits] [int] NULL,
	[Delivery2EUnits] [int] NULL,
	[Delivery3EUnits] [int] NULL,
	[TotalWSUnits] [int] NULL,
	[TotalRUnits] [int] NULL,
	[TotalEUnits] [int] NULL,
	[TotalUnits] [int] NULL,
 CONSTRAINT [PK_pStyleSKUItems] PRIMARY KEY CLUSTERED 
(
	[StyleSKUItemsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_StyleSKUItemsID]  DEFAULT (newid()) FOR [StyleSKUItemsID]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery1WSUnits]  DEFAULT ((0)) FOR [Delivery1WSUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery2WSUnits]  DEFAULT ((0)) FOR [Delivery2WSUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery3WSUnits]  DEFAULT ((0)) FOR [Delivery3WSUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery1RUnits]  DEFAULT ((0)) FOR [Delivery1RUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery2RUnits]  DEFAULT ((0)) FOR [Delivery2RUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery3RUnits]  DEFAULT ((0)) FOR [Delivery3RUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery1EUnits]  DEFAULT ((0)) FOR [Delivery1EUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery2EUnits]  DEFAULT ((0)) FOR [Delivery2EUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_Delivery3EUnits]  DEFAULT ((0)) FOR [Delivery3EUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_TotalWSUnits]  DEFAULT ((0)) FOR [TotalWSUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_TotalRUnits]  DEFAULT ((0)) FOR [TotalRUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_TotalEUnits]  DEFAULT ((0)) FOR [TotalEUnits]
GO

ALTER TABLE [dbo].[pStyleSKUItems] ADD  CONSTRAINT [DF_pStyleSKUItems_TotalUnits]  DEFAULT ((0)) FOR [TotalUnits]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07002', GetDate())
GO
