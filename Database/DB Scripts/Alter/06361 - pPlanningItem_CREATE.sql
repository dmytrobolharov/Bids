IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningItem_PlanningItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [DF_pPlanningItem_PlanningItemID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningItem_PlanningItemDrop]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [DF_pPlanningItem_PlanningItemDrop]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningItem_PlanningItemDropUser]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [DF_pPlanningItem_PlanningItemDropUser]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningItem_PlanningItemDropDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [DF_pPlanningItem_PlanningItemDropDate]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningItem_PlanningImageLink]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [DF_pPlanningItem_PlanningImageLink]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningItem_StyleSeasonYearID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [DF_pPlanningItem_StyleSeasonYearID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningItem]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningItem]
GO


CREATE TABLE [dbo].[pPlanningItem](
	[PlanningItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[PlanningItemDrop] [nvarchar](5) NOT NULL,
	[PlanningItemDropUser] [nvarchar](200) NULL,
	[PlanningItemDropDate] [datetime] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[PlanningImageID] [uniqueidentifier] NULL,
	[PlanningImageVersion] [int] NULL,
	[PlanningImageFile] [nvarchar](200) NULL,
	[PlanningImageLink] [bit] NULL,
	[PlanningItemCustom1] [nvarchar](100) NULL,
	[PlanningItemCustom2] [nvarchar](100) NULL,
	[PlanningItemCustom3] [nvarchar](100) NULL,
	[PlanningItemCustom4] [nvarchar](100) NULL,
	[PlanningItemCustom5] [nvarchar](100) NULL,
	[PlanningItemCustom6] [nvarchar](100) NULL,
	[PlanningItemCustom7] [nvarchar](100) NULL,
	[PlanningItemCustom8] [nvarchar](100) NULL,
	[PlanningItemCustom9] [nvarchar](100) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MChange] [int] NULL,
	[PlanningItemSort] [nvarchar](5) NULL,
	[Sort] [nvarchar](5) NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningItem] PRIMARY KEY CLUSTERED 
(
	[PlanningItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningItem] ADD  CONSTRAINT [DF_pPlanningItem_PlanningItemID]  DEFAULT (newid()) FOR [PlanningItemID]
GO

ALTER TABLE [dbo].[pPlanningItem] ADD  CONSTRAINT [DF_pPlanningItem_PlanningItemDrop]  DEFAULT (N'No') FOR [PlanningItemDrop]
GO

ALTER TABLE [dbo].[pPlanningItem] ADD  CONSTRAINT [DF_pPlanningItem_PlanningItemDropUser]  DEFAULT (N'NONE') FOR [PlanningItemDropUser]
GO

ALTER TABLE [dbo].[pPlanningItem] ADD  CONSTRAINT [DF_pPlanningItem_PlanningItemDropDate]  DEFAULT (getdate()) FOR [PlanningItemDropDate]
GO

ALTER TABLE [dbo].[pPlanningItem] ADD  CONSTRAINT [DF_pPlanningItem_PlanningImageLink]  DEFAULT ((1)) FOR [PlanningImageLink]
GO

ALTER TABLE [dbo].[pPlanningItem] ADD  CONSTRAINT [DF_pPlanningItem_StyleSeasonYearID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [StyleSeasonYearID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06361', GetDate())
GO
