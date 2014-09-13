IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningType_PlanningTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningType] DROP CONSTRAINT [DF_pPlanningType_PlanningTypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningType] DROP CONSTRAINT [DF_pPlanningType_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningType_Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningType] DROP CONSTRAINT [DF_pPlanningType_Sort]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningType]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningType]
GO

CREATE TABLE [dbo].[pPlanningType](
	[PlanningTypeID] [uniqueidentifier] NOT NULL,
	[PlanningCode] [nvarchar](10) NULL,
	[PlanningType] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_pPlanningType] PRIMARY KEY CLUSTERED 
(
	[PlanningTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningType] ADD  CONSTRAINT [DF_pPlanningType_PlanningTypeID]  DEFAULT (newid()) FOR [PlanningTypeID]
GO

ALTER TABLE [dbo].[pPlanningType] ADD  CONSTRAINT [DF_pPlanningType_Active]  DEFAULT ((0)) FOR [Active]
GO

ALTER TABLE [dbo].[pPlanningType] ADD  CONSTRAINT [DF_pPlanningType_Sort]  DEFAULT ((0)) FOR [Sort]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07461', GetDate())
GO
