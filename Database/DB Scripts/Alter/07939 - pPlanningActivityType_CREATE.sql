IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningActivityType_PlanningActivityTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningActivityType] DROP CONSTRAINT [DF_pPlanningActivityType_PlanningActivityTypeID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningActivityType]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningActivityType]
GO

CREATE TABLE [dbo].[pPlanningActivityType](
	[PlanningActivityTypeID] [uniqueidentifier] NOT NULL,
	[PlanningActivityKey] [nvarchar](5) NULL,
	[PlanningActivityType] [nvarchar](50) NULL,
	[PlanningActivityMsg] [nvarchar](500) NULL,
 CONSTRAINT [PK_pPlanningActivityType] PRIMARY KEY CLUSTERED 
(
	[PlanningActivityTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningActivityType] ADD  CONSTRAINT [DF_pPlanningActivityType_PlanningActivityTypeID]  DEFAULT (newid()) FOR [PlanningActivityTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07939', GetDate())
GO
